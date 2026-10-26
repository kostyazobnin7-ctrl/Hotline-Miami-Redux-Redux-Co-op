var w = net_packet_begin(global.NET_MSG_PEVENT);
buffer_write(w, buffer_u8, argument0);
buffer_write(w, buffer_u8, argument1);
buffer_write(w, buffer_u8, argument2);
buffer_write(w, buffer_u16, clamp(round(argument3), 0, 65535));
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
