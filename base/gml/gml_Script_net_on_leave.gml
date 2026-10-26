var b = argument0;
var sz = argument1;
var ip = argument2;
var port = argument3;
if (sz < 3)
{
    global.net_drops += 1;
    exit;
}
var pid = buffer_read(b, buffer_u8);
var reason = buffer_read(b, buffer_u8);
if (global.net_mode == global.NET_MODE_HOST)
{
    var sender = net_player_find(ip, port);
    if (sender == 0)
    {
        exit;
    }
    if (pid != sender)
    {
        global.net_drops += 1;
        exit;
    }
    net_host_drop_player(pid, global.NET_LEAVE_QUIT, 1);
}
else if (global.net_mode == global.NET_MODE_CLIENT)
{
    if (!net_from_host(ip, port))
    {
        global.net_drops += 1;
        exit;
    }
    if (pid == 1 || reason == global.NET_LEAVE_HOST_QUIT)
    {
        net_client_lost(global.NET_LEAVE_HOST_QUIT);
    }
    else if (pid == global.net_my_pid)
    {
        net_client_lost(global.NET_LEAVE_KICKED);
    }
    else if (pid >= 2 && pid <= global.NET_MAX_PLAYERS && global.pl_used[pid])
    {
        net_log("игрок " + string(pid) + " '" + global.pl_name[pid] + "' покинул игру, причина " + string(reason));
        global.pl_used[pid] = 0;
    }
}
