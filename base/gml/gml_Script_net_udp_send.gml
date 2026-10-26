var r = network_send_udp_raw(global.net_socket, argument0, argument1, argument2, argument3);
if (r >= 0)
{
    global.net_bytes_out += argument3;
    global.net_rate_out_acc += argument3;
}
return r;
