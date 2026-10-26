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
if (global.drawscore > global.myscore)
{
    global.drawscore = global.myscore;
}
global.net_hud_t = current_time;
