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
    // v1.7: зона может сработать от другого игрока — прямое «objPWalkWindow.поле = ...» падало,
    // если хост не лезет в окно (CLEAN HIT, objJanitorVacuum). Через with — только если объект есть.
    t = Regex.Replace(t, @"\b(objPWalkWindow|objPlayerMouse|objPlayerBikerHouse)\.(\w+) = ([^;\n]+);", "with ($1)\n    $2 = $3;");
    finalText[cn] = t;
    zoneRefs += n;
}

// --- 4. Диалоги: хост рассылает номер сообщения, клиент показывает только присланные ---
finalText["gml_Script_scrGetMessage"] = "if (net_msg_hook(argument0)) exit;\n" + Cur("gml_Script_scrGetMessage");

// --- 5. Интерлюдия (v1.4.2): global.song у клиента может быть ещё не строкой, а переход —
// только после FLOW от хоста (иначе global.interlude = 0, т. е. первая комната игры) ---
{
    var cn = "gml_Object_objInterlude_Draw_0";
    var t = Cur(cn);
    int n0 = t.Length;
    t = t.Replace("string_length(global.song) > 0", "is_string(global.song) && string_length(global.song) > 0");
    t = t.Replace("room_goto(global.interlude);", "if (!net_is_client() || global.net_flow_have)\n        room_goto(global.interlude);");
    if (t.Length == n0) throw new Exception("objInterlude: правка не применилась");
    finalText[cn] = t;
}

// --- 6. v1.4.4: «CHAPTER CLEAR» у клиента только по команде хоста ---
{
    var cn = "gml_Object_objLevelComplete_Create_0";
    finalText[cn] = "if (net_lc_hook())\n{\n    instance_destroy();\n    exit;\n}\n" + Cur(cn);
}

// --- 8. v1.4.4: global.done = 1 у клиента не ставится (решает хост) ---
{
    int files = 0, refs = 0;
    foreach (var c in data.Code)
    {
        if (c.ParentEntry != null) continue;
        var cn = c.Name.Content;
        if (cn.StartsWith("gml_Script_net_") || cn.StartsWith("gml_Object_objCoop")) continue;
        string t;
        try { t = Cur(cn); } catch { continue; }
        int n = Regex.Matches(t, @"global\.done = 1;").Count;
        if (n == 0) continue;
        finalText[cn] = t.Replace("global.done = 1;", "net_done_set();");
        files++; refs += n;
    }
    Console.WriteLine($"  global.done = 1 -> net_done_set: {files} фрагментов, {refs} мест");
}

// --- 9. v1.6: особые подборы (маски с пола, буквы, улики, коробки...) для аватаров клиентов ---
// Начало scrPlayerPickUp до «release = 0;» — только особые предметы, каждый с exit; дальше оружие.
{
    var t = Cur("gml_Script_scrPlayerPickUp");
    int cut = t.IndexOf("\nrelease = 0;");
    if (cut < 0) throw new Exception("scrPlayerPickUp: нет «release = 0;»");
    finalText["gml_Script_net_c_pickup_special"] =
        "/// net_c_pickup_special()\n// Сгенерировано coopbuild2 из scrPlayerPickUp (особые подборы), выполняется в контексте objPlayer\n"
        + t.Substring(0, cut) + "\n";
}

// --- 10. v1.7: боссы (Байкер objBoss2, Пантера objBoss4 + objPanther) ---
{
    string Must(string cn, string a, string b, int count = 1)
    {
        var t = Cur(cn);
        int n = 0, i = 0;
        while ((i = t.IndexOf(a, i, StringComparison.Ordinal)) >= 0) { n++; i += a.Length; }
        if (n != count) throw new Exception($"{cn}: «{a.Split('\n')[0]}…» найдено {n}, ждали {count}");
        finalText[cn] = t.Replace(a, b);
        return finalText[cn];
    }
    // Байкер: «игрок убит -> state 1000» навсегда (в коопе остальные живы — стоял АФК)
    Must("gml_Object_objBoss2_Step_0",
        "if (!instance_exists(net_tgt()))\n{\n    speed = 0;\n    state = 1000;\n}",
        "if (!instance_exists(net_tgt()))\n{\n    speed = 0;\n    exit;\n}");
    Must("gml_Object_objBoss2_Step_0",
        "scrPlayerDieMelee();\n        state = 1000;",
        "scrPlayerDieMelee();\n        if (!net_any_alive())\n            state = 1000;");
    // Байкер вытаскивает тесак: удар засчитывался только от позиции хоста
    Must("gml_Object_objBoss2Pry_Step_0", "with (objPlayer)", "with (net_tgt())");
    // Байкер ползёт: добивает только хост (иначе уничтожался objPlayer хоста)
    Must("gml_Object_objBoss2Crawl_Step_0",
        "if (point_distance(x, y, net_tgt_x(), net_tgt_y()) < 14)",
        "if (net_tgt_is_host() && point_distance(x, y, net_tgt_x(), net_tgt_y()) < 14)");
    // после добивания — клюшка на полу для всех
    Must("gml_Object_objPClubBoss2_Step_0", "instance_create(x, y, objGoToCar);",
        "instance_create(x, y, objGoToCar);\n    net_boss_drop_club(x, y);");
    // пантеры: укус клиента — через кооп-обработку (раньше погибал хост, пантера исчезала)
    var pt = Cur("gml_Object_objPanther_Step_0");
    var rxBite = new Regex(@"scrPlayerDiePantherBite\(\);\s*instance_destroy\(\);");
    int nb = rxBite.Matches(pt).Count;
    if (nb == 0) throw new Exception("objPanther: укус не найден");
    finalText["gml_Object_objPanther_Step_0"] = rxBite.Replace(pt,
        "if (!net_panther_bite())\n{\n    scrPlayerDiePantherBite();\n    instance_destroy();\n}");
    Console.WriteLine($"  боссы: Байкер 5 правок, пантеры {nb} укуса");
}

// --- 11. v1.7: скин Байкера у хоста, настройка выбора маски при перезапуске ---
{
    var cn = "gml_Object_objPlayerMouse_Draw_0";
    finalText[cn] = "if (net_skin_draw_self())\n{\n    exit;\n}\n" + Cur(cn);
    foreach (var en in new[] { "gml_Object_objEffector_Step_0", "gml_Object_objEffectorHouse_Draw_0" })
    {
        var t = Cur(en);
        if (!t.Contains("global.maskonsaved = 0;")) throw new Exception(en + ": нет maskonsaved = 0");
        finalText[en] = t.Replace("global.maskonsaved = 0;", "net_mask_restart_reset();");
    }
}

// --- 12. v1.8.1: HUD читает поля своего игрока, а не первого objPlayer (объект казни клиента) ---
{
    var rxHud = new Regex(@"\bobjPlayer\.(\w+)\b(?!\s*(?:=(?!=)|\+=|-=|\*=|/=))");
    int nh = 0;
    foreach (var cn in new[] { "gml_Script_scrDrawHUD", "gml_Script_scrStoryDrawAmmo", "gml_Object_objEffector_Draw_0", "gml_Object_objEffectorHouse_Draw_0" })
    {
        if (data.Code.ByName(cn) == null) continue;
        var t = Cur(cn);
        t = rxHud.Replace(t, m => { nh++; return "net_hud_player()." + m.Groups[1].Value; });
        finalText[cn] = t;
    }
    Console.WriteLine($"  HUD: objPlayer. -> net_hud_player(). {nh} мест");
    // хост-Байкер: ПКМ без подбора оружия (после генерации net_c_pickup_special!)
    finalText["gml_Script_scrPlayerPickUp"] = "if (net_host_biker_pick())\n{\n    exit;\n}\n" + Cur("gml_Script_scrPlayerPickUp");
    // хост-Байкер: тело
    finalText["gml_Object_objPlayerDead_Draw_0"] = "if (global.net_started && net_biker(1))\n{\n    var nbs = net_skin_spr(1, sprite_index);\n    draw_sprite_ext(nbs, image_index mod max(1, sprite_get_number(nbs)), x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);\n    exit;\n}\n" + Cur("gml_Object_objPlayerDead_Draw_0");
}

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
