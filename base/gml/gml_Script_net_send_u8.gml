var w = net_packet_begin(argument2);
buffer_write(w, buffer_u8, argument3);
net_transport_send(argument0, argument1, w, buffer_tell(w));
