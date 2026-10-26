var w = net_packet_begin(global.NET_MSG_HELLO);
buffer_write(w, buffer_u16, global.NET_PROTO);
buffer_write(w, buffer_string, global.net_name);
net_transport_send(global.net_host_ip, global.net_port, w, buffer_tell(w));
global.net_hello_t = current_time;
