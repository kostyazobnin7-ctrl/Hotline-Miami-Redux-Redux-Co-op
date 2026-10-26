var b = argument0;
var sz = argument1;
var ip = argument2;
var port = argument3;
if (global.net_mode != global.NET_MODE_HOST || sz < 4)
{
    global.net_drops += 1;
    exit;
}
var proto = buffer_read(b, buffer_u16);
var nick = net_clean_nick(buffer_read(b, buffer_string));
var pid = net_player_find(ip, port);
if (pid > 0)
{
    net_send_welcome(pid);
    exit;
}
if (proto != global.NET_PROTO)
{
    net_send_reject(ip, port, global.NET_REJECT_VERSION);
    exit;
}
if (global.net_started)
{
    net_send_reject(ip, port, global.NET_REJECT_STARTED);
    exit;
}
pid = net_player_free_slot();
if (pid == 0)
{
    net_send_reject(ip, port, global.NET_REJECT_FULL);
    exit;
}
net_player_add(pid, ip, port, nick, 0);
net_send_welcome(pid);
net_lobby_broadcast();
