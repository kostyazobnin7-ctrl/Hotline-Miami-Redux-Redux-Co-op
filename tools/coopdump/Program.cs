using UndertaleModLib; using UndertaleModLib.Models; using UndertaleModLib.Decompiler;
// coopdump <data.win> <outdir> <regex>  — декомпиляция кода с именами ассетов
var utmt = Environment.GetEnvironmentVariable("COOP_UTMT_DIR") ?? throw new Exception("set COOP_UTMT_DIR to the UndertaleModTool folder");
using var fs = File.OpenRead(args[0]);
var data = UndertaleIO.Read(fs, (w, _) => {});
if (args[1] == "--info") { var g = data.GeneralInfo; Console.WriteLine(g.Name.Content + " | " + g.FileName.Content + " | " + g.DisplayName.Content + " | " + g.GameID + " | " + g.Config.Content); return; }
if (args[1] == "--rooms") { foreach (var on in args[2].Split(',')) { var rs = data.Rooms.Where(r => r.GameObjects.Any(g => g.ObjectDefinition?.Name.Content == on)).Select(r => r.Name.Content + "x" + r.GameObjects.Count(g => g.ObjectDefinition?.Name.Content == on)); Console.WriteLine(on + ": " + string.Join(" ", rs)); } return; }
if (args[1] == "--objidx") { foreach (var on in args[2].Split(',')) Console.WriteLine(on + " " + data.GameObjects.IndexOf(data.GameObjects.ByName(on))); return; }
if (args[1] == "--inst") { var r = data.Rooms.ByName(args[2]); foreach (var g in r.GameObjects.Where(g => args[3].Split(',').Contains(g.ObjectDefinition?.Name.Content))) Console.WriteLine(g.ObjectDefinition.Name.Content + " @" + g.X + "," + g.Y + " sx" + g.ScaleX + " sy" + g.ScaleY + " cc:" + (g.CreationCode?.Name.Content ?? "-")); return; }
if (args[1] == "--spridx") { foreach (var on in args[2].Split(',')) { var sp = data.Sprites.ByName(on); Console.WriteLine(on + " " + (sp == null ? -1 : data.Sprites.IndexOf(sp)) + (sp == null ? "" : " frames " + sp.Textures.Count)); } return; }
if (args[1] == "--sprlike") { foreach (var sp in data.Sprites) if (sp.Name.Content.Contains(args[2])) Console.WriteLine(data.Sprites.IndexOf(sp) + " " + sp.Name.Content + " f" + sp.Textures.Count); return; }
if (args[1] == "--children") { var root = data.GameObjects.ByName(args[2]); foreach (var o in data.GameObjects) { for (var q = o.ParentId; q != null; q = q.ParentId) { if (q == root) { var cr = o.Events[0].FirstOrDefault()?.Actions.FirstOrDefault()?.CodeId?.Name.Content ?? "-"; Console.WriteLine(o.Name.Content + " " + cr); break; } if (q.ParentId == q) break; } } return; }
GameSpecificResolver.BaseDirectory = utmt + Path.DirectorySeparatorChar;
GameSpecificResolver.ReloadDefinitions(); GameSpecificResolver.Initialize(data);
var ctx = new GlobalDecompileContext(data);
var rx = new System.Text.RegularExpressions.Regex(args[2]);
Directory.CreateDirectory(args[1]); int n = 0;
foreach (var c in data.Code) {
  if (c.ParentEntry != null || !rx.IsMatch(c.Name.Content)) continue;
  string t;
  try { t = new Underanalyzer.Decompiler.DecompileContext(ctx, c, data.ToolInfo.DecompilerSettings).DecompileToString(); }
  catch (Exception e) { t = "/* DECOMPILE FAIL: " + e.Message + " */"; }
  File.WriteAllText(Path.Combine(args[1], c.Name.Content + ".gml"), t); n++;
}
Console.WriteLine("dumped " + n);
