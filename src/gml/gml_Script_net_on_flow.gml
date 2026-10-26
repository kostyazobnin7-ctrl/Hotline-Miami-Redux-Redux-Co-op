/// net_on_flow(buf, size, ip, port)
// КЛИЕНТ: переменные хода сюжета от хоста (см. net_flow_send).
// Без них у клиента global.song = 0, и objInterlude падал на string_length;
// global.sequence = 0 — objShowControls ушёл бы в комнату 0.
var b = argument0;
if (!net_from_host(argument2, argument3) || argument1 < 7)
{
    global.net_drops += 1;
    exit;
}
if (global.net_mode != global.NET_MODE_CLIENT)
{
    exit;
}
var s = buffer_read(b, buffer_string);
if ((buffer_tell(b) + 5) > argument1)
{
    global.net_drops += 1;
    exit;
}
var ns = "";
if (s != "")
{
    ns = working_directory + s;
}
if (!global.net_flow_have || !is_string(global.song) || global.song != ns)
{
    net_log("FLOW: песня '" + s + "'");
}
global.song = ns;
global.interlude = buffer_read(b, buffer_s16);
global.revisit = buffer_read(b, buffer_u8);
global.nextlevel = buffer_read(b, buffer_s16);
if ((buffer_tell(b) + 4) <= argument1)
{
    global.sequence = buffer_read(b, buffer_s16);
    global.title = buffer_read(b, buffer_string);
    global.pretitle = buffer_read(b, buffer_string);
}
global.net_flow_have = 1;
