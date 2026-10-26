if (global.net_socket < 0 || global.net_left)
{
    exit;
}
global.net_left = 1;
if (global.net_mode == global.NET_MODE_CLIENT && global.net_conn == global.NET_CONN_CONNECTED)
{
    for (var k = 0; k < global.NET_LEAVE_REPEAT; k += 1)
    {
        net_send_leave(global.net_host_ip, global.net_port, global.net_my_pid, global.NET_LEAVE_QUIT, 1);
    }
    net_log("выход: LEAVE хосту");
}
else if (global.net_mode == global.NET_MODE_HOST)
{
    for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        if (global.pl_used[i])
        {
            for (var k = 0; k < global.NET_LEAVE_REPEAT; k += 1)
            {
                net_send_leave(global.pl_ip[i], global.pl_port[i], 1, global.NET_LEAVE_HOST_QUIT, 1);
            }
        }
    }
    net_log("выход хоста: LEAVE всем клиентам");
}
