using System.Text;
using System.Text.RegularExpressions;
using UndertaleModLib;
using UndertaleModLib.Decompiler;
using UndertaleModLib.Models;

// coopbuild2 <base data.win> <out data.win> <src/gml> [--name ИМЯ]
// Сборка поверх собранной v1.3 (исходники v1.0–v1.3 утеряны, база — её data.win):
//  1) все .gml из src/gml заменяют или добавляют код с тем же именем;
//  2) правки игрового кода — по декомпилированному тексту (сюжетные предметы, зоны, диалоги);
//  3) --name меняет имя игры (папку сохранений) для экземпляров стенда.
if (args.Length < 3) { Console.Error.WriteLine("usage: coopbuild2 <base.win> <out.win> <src/gml> [--name N]"); return 2; }
var utmt = Environment.GetEnvironmentVariable("COOP_UTMT_DIR") ?? @"C:\Users\kosty\OneDrive\Desktop\UndertaleModTool";
string? newName = null;
for (int i = 3; i + 1 < args.Length; i++) if (args[i] == "--name") newName = args[i + 1];

UndertaleData data;
using (var fs = File.OpenRead(args[0])) data = UndertaleIO.Read(fs, (w, _) => { });
GameSpecificResolver.BaseDirectory = utmt + Path.DirectorySeparatorChar;
GameSpecificResolver.ReloadDefinitions();
GameSpecificResolver.Initialize(data);
var ctx = new GlobalDecompileContext(data);
string Src(string cn)
{
    var c = data.Code.ByName(cn) ?? throw new Exception("нет кода " + cn);
    return new Underanalyzer.Decompiler.DecompileContext(ctx, c, data.ToolInfo.DecompilerSettings).DecompileToString().Replace("\r\n", "\n");
}
var finalText = new Dictionary<string, string>();
string Cur(string cn) => finalText.TryGetValue(cn, out var t) ? t : Src(cn);

// --- 1. Наш код ---
int ours = 0;
foreach (var f in Directory.GetFiles(args[2], "*.gml").OrderBy(f => f))
{
    finalText[Path.GetFileNameWithoutExtension(f)] = File.ReadAllText(f, Encoding.UTF8).Replace("\r\n", "\n");
    ours++;
}

// --- 2. Сюжетные предметы по ПКМ/ЛКМ ---
// У этих объектов глобальные события нажатия мыши (ev_global_left/right_press) с проверкой objPlayer.
// В сетевой игре они выполняются только через net_story_try (хост) и net_story_apply (клиент).
var storyObjs = new[] {
    "objAssassinBar", "objAssassinPizza", "objAssassinVHS", "objBossPhone", "objBriefcase", "objCellDoor",
    "objChipsBag", "objClubKeys", "objDrink", "objFiles", "objKeycard", "objKeys", "objLaundryBasket",
    "objLockedDoor", "objNes", "objNicklasBar", "objNicklasPizza", "objNicklasStoreSpecial", "objNicklasStore",
    "objNicklasVHS", "objPhone", "objPimpPhone", "objPizzaTake", "objSixpack", "objSpecialCartridge", "objVHSTake" };
int storyEv = 0;
var list = new StringBuilder("/// net_story_list()\n// Сгенерировано coopbuild2: объекты сюжетных предметов\n");
int nobj = 0;
foreach (var o in storyObjs)
{
    if (data.GameObjects.ByName(o) == null) { Console.WriteLine("  нет объекта " + o); continue; }
    list.Append("global.st_obj[" + nobj + "] = " + o + ";\n");
    nobj++;
    foreach (var ev in new[] { "_Mouse_53", "_Mouse_54" })
    {
        var cn = "gml_Object_" + o + ev;
        if (data.Code.ByName(cn) == null) continue;
        finalText[cn] = "if (!net_story_allow()) exit;\n" + Cur(cn);
        storyEv++;
    }
}
list.Append("global.st_nobj = " + nobj + ";\n");
finalText["gml_Script_net_story_list"] = list.ToString();

// --- 3. Сюжетные зоны: срабатывают от ближайшего живого игрока, а не только от objPlayer ---
var zoneObjs = new[] { "objGirlfriend", "objGirlfriendDead", "objJanitorNotice", "objJanitorVacuum",
    "objCrocodileMan", "objDeadTable", "objDogPetCorpse", "objFatCorpseEat" };
var rxRead = new Regex(@"\bobjPlayer\.([xy])\b(?!\s*(?:=(?!=)|\+=|-=|\*=|/=))");
var rxMeet = new Regex(@"place_meeting\(([^,()]+(?:\([^()]*\))?[^,()]*),\s*([^,()]+(?:\([^()]*\))?[^,()]*),\s*objPlayer\)");
int zoneRefs = 0;
foreach (var o in zoneObjs)
{
    var cn = "gml_Object_" + o + "_Step_0";
    if (data.Code.ByName(cn) == null) { Console.WriteLine("  нет " + cn); continue; }
    var t = Cur(cn);
    int n = 0;
    t = rxRead.Replace(t, m => { n++; return "net_zone_" + m.Groups[1].Value + "()"; });
    t = rxMeet.Replace(t, m => { n++; return "net_zone_meet(" + m.Groups[1].Value + ", " + m.Groups[2].Value + ")"; });
    finalText[cn] = t;
    zoneRefs += n;
}

// --- 4. Диалоги: хост рассылает номер сообщения, клиент показывает только присланные ---
finalText["gml_Script_scrGetMessage"] = "if (net_msg_hook(argument0)) exit;\n" + Cur("gml_Script_scrGetMessage");

// --- Импорт ---
var group = new UndertaleModLib.Compiler.CodeImportGroup(data);
foreach (var kv in finalText) group.QueueReplace(kv.Key, kv.Value);
var res = group.Import();
if (!res.Successful)
{
    Console.Error.WriteLine("ОШИБКА КОМПИЛЯЦИИ:\n" + res.PrintAllErrors(false));
    return 1;
}
if (newName != null)
{
    data.GeneralInfo.Name = data.Strings.MakeString(newName);
    data.GeneralInfo.FileName = data.Strings.MakeString(newName);
}
using (var fs = File.Create(args[1])) UndertaleIO.Write(fs, data);
Console.WriteLine($"наш код: {ours}; предметы: {nobj} объектов, {storyEv} событий; зоны: {zoneRefs} ссылок; всего фрагментов {finalText.Count}");
return 0;
