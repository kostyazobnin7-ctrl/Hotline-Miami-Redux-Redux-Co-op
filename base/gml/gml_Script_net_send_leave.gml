var w = net_packet_begin(global.NET_MSG_LEAVE);
buffer_write(w, buffer_u8, argument2);
buffer_write(w, buffer_u8, argument3);
if (argument4)
{
    net_udp_send(argument0, argument1, w, buffer_tell(w));
}
else
{
    net_transport_send(argument0, argument1, w, buffer_tell(w));
}
