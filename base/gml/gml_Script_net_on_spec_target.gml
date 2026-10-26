if (global.net_mode != global.NET_MODE_HOST || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
var sender = net_player_find(argument2, argument3);
if (sender == 0)
{
    global.net_drops += 1;
    exit;
}
var t = buffer_read(argument0, buffer_u8);
if (t > global.NET_MAX_PLAYERS)
{
    t = 0;
}
global.spec_target_of[sender] = t;
