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
// v1.4.4: музыка и маски
if ((buffer_tell(b) + 4) <= argument1)
{
    var mseq = buffer_read(b, buffer_u16);
    var mon = buffer_read(b, buffer_u8);
    var mpath = buffer_read(b, buffer_string);
    if (mseq != global.net_mus_seen)
    {
        global.net_mus_seen = mseq;
        global.net_mus_replay = 1;
        if (mon && mpath != "")
        {
            net_log("музыка: " + mpath);
            sxeasy_play(working_directory + mpath);
        }
        else
        {
            net_log("музыка: стоп");
            sxeasy_stop(1);
        }
        global.net_mus_replay = 0;
    }
    for (var i = 1; i <= global.NET_MAX_PLAYERS && (buffer_tell(b) + 2) <= argument1; i += 1)
    {
        var mk = buffer_read(b, buffer_u8);
        var sk = buffer_read(b, buffer_u8);
        // v2.2.2 / bug3: свою маску FLOW никогда не затирает — только локальное
        // подтверждение меню (net_mask_client_step) / MASK. Раньше при pl_mask==255
        // хост мог навязать 0/чужую до Enter.
        if (i == global.net_my_pid)
        {
            continue;
        }
        global.pl_mask[i] = mk;
        global.pl_mskin[i] = sk;
    }
}
global.net_flow_have = 1;
