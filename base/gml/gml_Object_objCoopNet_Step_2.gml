cam_update();
if (global.net_mode == global.NET_MODE_CLIENT && global.net_started && room == global.net_host_room)
{
    net_doors_apply();
}
