var w = net_packet_begin(global.NET_MSG_REJECT);
buffer_write(w, buffer_u8, argument2);
net_transport_send(argument0, argument1, w, buffer_tell(w));
net_log("отказ " + argument0 + ":" + string(argument1) + ", причина " + string(argument2));
