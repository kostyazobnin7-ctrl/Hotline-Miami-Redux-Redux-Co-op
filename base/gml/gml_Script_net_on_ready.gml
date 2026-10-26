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
var r = buffer_read(argument0, buffer_u8) != 0;
if (global.pl_ready[sender] != r)
{
    global.pl_ready[sender] = r;
    net_log("игрок " + string(sender) + " готов: " + string(r));
}
net_lobby_broadcast();
