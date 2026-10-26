for (var i = 0; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.pl_used[i] = 0;
    global.pl_ip[i] = "";
    global.pl_port[i] = 0;
    global.pl_name[i] = "";
    global.pl_ready[i] = 0;
    global.pl_host[i] = 0;
}
global.net_my_pid = 0;
global.net_session = 0;
global.net_conn = global.NET_CONN_IDLE;
global.net_reject_reason = 0;
global.net_started = 0;
global.net_ping_enabled = 1;
global.net_hello_t = 0;
global.net_connect_t = current_time;
global.net_lobby_t = current_time;
global.net_lobby_count = 0;
global.net_want_slot = 0;
global.net_want_ready = -1;
global.net_req_t = 0;
global.net_start_t = 0;
global.net_start_room = 0;
net_sync_init();
global.net_left = 0;
global.net_lost_reason = 0;
global.net_lost_t = 0;
if (global.net_mode == global.NET_MODE_HOST)
{
    var dt = date_current_datetime();
    var ms_of_day = floor((dt - floor(dt)) * 86400000);
    global.net_session = ((ms_of_day % 2000000) * 1000) + (get_timer() % 1000) + 1;
    net_player_add(1, "", 0, global.net_name, 1);
    global.net_my_pid = 1;
    global.net_conn = global.NET_CONN_CONNECTED;
}
else if (global.net_mode == global.NET_MODE_CLIENT)
{
    global.net_conn = global.NET_CONN_CONNECTING;
    global.net_hello_t = current_time - global.NET_HELLO_RESEND_MS;
}
