if (!net_from_host(argument2, argument3) || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTING)
{
    exit;
}
global.net_reject_reason = buffer_read(argument0, buffer_u8);
global.net_conn = global.NET_CONN_REJECTED;
global.net_ping_enabled = 0;
net_log("хост отказал, причина " + string(global.net_reject_reason));
