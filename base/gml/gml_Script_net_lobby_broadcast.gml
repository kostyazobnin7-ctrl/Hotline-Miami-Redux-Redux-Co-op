if (global.net_mode != global.NET_MODE_HOST)
{
    exit;
}
var n = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        n += 1;
    }
}
var w = net_packet_begin(global.NET_MSG_LOBBY_STATE);
buffer_write(w, buffer_u8, n);
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        var flags = global.NET_PF_CONNECTED;
        if (global.pl_ready[i])
        {
            flags |= global.NET_PF_READY;
        }
        if (global.pl_host[i])
        {
            flags |= global.NET_PF_HOST;
        }
        buffer_write(w, buffer_u8, i);
        buffer_write(w, buffer_u8, flags);
        buffer_write(w, buffer_string, global.pl_name[i]);
    }
}
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.net_lobby_t = current_time;
global.net_lobby_count = n;
