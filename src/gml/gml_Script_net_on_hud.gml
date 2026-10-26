var b = argument0;
if (!net_from_host(argument2, argument3) || argument1 < global.NET_HUD_SIZE)
{
    global.net_drops += 1;
    exit;
}
if (global.net_mode != global.NET_MODE_CLIENT || room != global.net_host_room)
{
    exit;
}
global.myscore = buffer_read(b, buffer_s32);
global.comboscore = buffer_read(b, buffer_s32);
global.combo = buffer_read(b, buffer_u8);
global.combotime = buffer_read(b, buffer_u8);
global.kills = buffer_read(b, buffer_u16);
// v1.4: координаты убийств; отсутствующие — нули (scrCountMobilityScore читает killx[0..kills-1])
if (buffer_tell(b) < argument1)
{
    var n = buffer_read(b, buffer_u8);
    for (var j = 0; j < n && (buffer_tell(b) + 6) <= argument1; j += 1)
    {
        var k = buffer_read(b, buffer_u16);
        global.killx[k] = buffer_read(b, buffer_s16);
        global.killy[k] = buffer_read(b, buffer_s16);
    }
}
net_kills_fill();
if (global.drawscore > global.myscore)
{
    global.drawscore = global.myscore;
}
global.net_hud_t = current_time;
