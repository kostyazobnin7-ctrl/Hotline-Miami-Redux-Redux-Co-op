var b = argument0;
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
var want = buffer_read(b, buffer_u8);
if (global.net_started || want < 2 || want > global.NET_MAX_PLAYERS || want == sender || global.pl_used[want])
{
    net_send_welcome(sender);
    net_lobby_broadcast();
    exit;
}
global.pl_used[want] = 1;
global.pl_ip[want] = global.pl_ip[sender];
global.pl_port[want] = global.pl_port[sender];
global.pl_name[want] = global.pl_name[sender];
global.pl_ready[want] = global.pl_ready[sender];
global.pl_host[want] = 0;
global.pl_used[sender] = 0;
global.pl_ip[sender] = "";
global.pl_port[sender] = 0;
global.pl_name[sender] = "";
global.pl_ready[sender] = 0;
net_log("игрок '" + global.pl_name[want] + "' перешёл из слота " + string(sender) + " в " + string(want));
net_send_welcome(want);
net_lobby_broadcast();
