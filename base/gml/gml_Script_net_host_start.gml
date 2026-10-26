if (!net_host_can_start())
{
    return 0;
}
global.net_started = 1;
global.net_start_room = room;
net_send_start();
net_log("START, комната " + string(room));
return 1;
