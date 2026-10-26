if (global.net_socket >= 0)
{
    net_stop();
}
global.net_mode = argument0;
if (!net_transport_init())
{
    net_transport_shutdown();
    global.net_mode = global.NET_MODE_OFF;
    net_players_init();
    return 0;
}
net_players_init();
if (global.net_mode == global.NET_MODE_HOST)
{
    window_set_caption("HLMR-R COOP [HOST :" + string(global.net_local_port) + "]");
}
else
{
    window_set_caption("HLMR-R COOP [CLIENT :" + string(global.net_local_port) + " -> " + global.net_host_ip + ":" + string(global.net_port) + "]");
}
return 1;
