if (global.net_mode != global.NET_MODE_CLIENT)
{
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTED && global.net_conn != global.NET_CONN_CONNECTING)
{
    exit;
}
global.net_conn = global.NET_CONN_LOST;
global.net_lost_reason = argument0;
global.net_lost_t = current_time;
global.net_ping_enabled = 0;
global.net_my_pid = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.pl_used[i] = 0;
}
global.net_lobby_count = 0;
net_log("связь с хостом потеряна, причина " + string(argument0));
