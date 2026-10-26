var w = net_packet_begin(global.NET_MSG_START);
buffer_write(w, buffer_u16, global.net_start_room);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.net_start_t = current_time;
