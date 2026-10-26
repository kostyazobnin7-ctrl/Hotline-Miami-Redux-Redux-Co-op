if (global.net_ping_enabled && (current_time - global.net_ping_t) >= global.NET_PING_INTERVAL_MS)
{
    global.net_ping_t = current_time;
    for (i = 0; i < global.net_peer_count; i += 1)
    {
        var w = net_packet_begin(global.NET_MSG_PING);
        buffer_write(w, buffer_u32, current_time);
        net_transport_send(global.net_peer_ip[i], global.net_peer_port[i], w, buffer_tell(w));
    }
}
var i = global.net_peer_count - 1;
while (i >= 0)
{
    if (global.net_peer_alive[i] && (current_time - global.net_peer_seen[i]) > global.NET_PEER_TIMEOUT_MS)
    {
        var tip = global.net_peer_ip[i];
        var tport = global.net_peer_port[i];
        var tfixed = global.net_peer_fixed[i];
        global.net_peer_alive[i] = 0;
        global.net_peer_rtt[i] = -1;
        net_log("таймаут пира " + tip + ":" + string(tport));
        net_on_peer_timeout(tip, tport);
        if (!tfixed)
        {
            net_peer_forget(tip, tport);
        }
    }
    i -= 1;
}
if ((current_time - global.net_rate_t) >= 1000)
{
    global.net_rate_t = current_time;
    global.net_rate_out = global.net_rate_out_acc;
    global.net_rate_in = global.net_rate_in_acc;
    global.net_rate_out_acc = 0;
    global.net_rate_in_acc = 0;
}
