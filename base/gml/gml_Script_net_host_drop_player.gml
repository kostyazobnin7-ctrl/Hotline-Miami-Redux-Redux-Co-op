var pid = argument0;
var reason = argument1;
if (global.net_mode != global.NET_MODE_HOST || pid < 2 || pid > global.NET_MAX_PLAYERS || !global.pl_used[pid])
{
    exit;
}
var ip = global.pl_ip[pid];
var port = global.pl_port[pid];
var txt;
if (reason == global.NET_LEAVE_TIMEOUT)
{
    txt = "таймаут";
}
else
{
    txt = "вышел (причина " + string(reason) + ")";
}
net_player_remove(pid, txt);
if (argument2)
{
    net_peer_forget(ip, port);
}
var w = net_packet_begin(global.NET_MSG_LEAVE);
buffer_write(w, buffer_u8, pid);
buffer_write(w, buffer_u8, reason);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
net_lobby_broadcast();
