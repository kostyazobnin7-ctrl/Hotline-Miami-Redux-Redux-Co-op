var pid = argument0;
var w = net_packet_begin(global.NET_MSG_WELCOME);
buffer_write(w, buffer_u8, pid);
buffer_write(w, buffer_u32, global.net_session);
net_transport_send(global.pl_ip[pid], global.pl_port[pid], w, buffer_tell(w));
