if (global.net_mode == global.NET_MODE_CLIENT)
{
    if (global.net_conn == global.NET_CONN_CONNECTING)
    {
        if ((current_time - global.net_connect_t) > global.NET_CONNECT_TIMEOUT_MS)
        {
            global.net_conn = global.NET_CONN_REJECTED;
            global.net_reject_reason = global.NET_REJECT_TIMEOUT;
            global.net_ping_enabled = 0;
            net_log("хост не ответил за " + string(global.NET_CONNECT_TIMEOUT_MS) + " мс");
        }
        else if ((current_time - global.net_hello_t) >= global.NET_HELLO_RESEND_MS)
        {
            net_send_hello();
        }
    }
    else if (global.net_conn == global.NET_CONN_CONNECTED && !global.net_started)
    {
        var me = global.net_my_pid;
        var ws = global.net_want_slot;
        if (ws != 0 && (ws == me || global.pl_used[ws]))
        {
            global.net_want_slot = 0;
        }
        if (global.net_want_ready != -1 && me > 0 && global.pl_ready[me] == global.net_want_ready)
        {
            global.net_want_ready = -1;
        }
        if ((current_time - global.net_req_t) >= global.NET_REQ_RESEND_MS)
        {
            if (global.net_want_slot != 0)
            {
                net_send_u8(global.net_host_ip, global.net_port, global.NET_MSG_SLOT_REQ, global.net_want_slot);
                global.net_req_t = current_time;
            }
            if (global.net_want_ready != -1)
            {
                net_send_u8(global.net_host_ip, global.net_port, global.NET_MSG_READY, global.net_want_ready);
                global.net_req_t = current_time;
            }
        }
    }
}
else if (global.net_mode == global.NET_MODE_HOST)
{
    if ((current_time - global.net_lobby_t) >= global.NET_LOBBY_RESEND_MS && global.net_lobby_count > 1)
    {
        net_lobby_broadcast();
    }
    if (global.net_started && (current_time - global.net_start_t) >= global.NET_START_RESEND_MS)
    {
        net_send_start();
    }
}
