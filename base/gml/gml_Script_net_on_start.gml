if (!net_from_host(argument2, argument3) || argument1 < 3)
{
    global.net_drops += 1;
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTED || global.net_started)
{
    exit;
}
global.net_started = 1;
global.net_start_room = buffer_read(argument0, buffer_u16);
global.net_want_slot = 0;
global.net_want_ready = -1;
net_log("хост начал игру, комната " + string(global.net_start_room));
net_lobby_ui_close();
