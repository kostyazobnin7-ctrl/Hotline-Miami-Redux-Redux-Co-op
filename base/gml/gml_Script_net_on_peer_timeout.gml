if (global.net_mode == global.NET_MODE_HOST)
{
    net_host_drop_player(net_player_find(argument0, argument1), global.NET_LEAVE_TIMEOUT, 0);
}
else if (global.net_mode == global.NET_MODE_CLIENT)
{
    if (global.net_conn == global.NET_CONN_CONNECTED && argument1 == global.net_port && argument0 == global.net_host_ip)
    {
        net_client_lost(global.NET_LEAVE_TIMEOUT);
    }
}
