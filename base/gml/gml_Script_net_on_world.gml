var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 4)
{
    global.net_drops += 1;
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTED)
{
    exit;
}
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (n != global.NET_WORLD_COUNT || sz < (4 + (n * 2)) || !room_exists(rm))
{
    global.net_drops += 1;
    exit;
}
for (var i = 0; i < n; i += 1)
{
    var v = buffer_read(b, buffer_s16);
    net_world_set(i, v);
}
if (global.net_host_room != rm)
{
    net_log("хост в комнате " + room_get_name(rm) + ", level " + string(global.level));
}
global.net_host_room = rm;
if (!global.net_started)
{
    global.net_started = 1;
    net_lobby_ui_close();
}
