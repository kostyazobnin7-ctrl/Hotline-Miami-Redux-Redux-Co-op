var ip = argument0;
var port = argument1;
var buf = argument2;
var size = argument3;
if (global.net_socket < 0 || size < 1)
{
    return -1;
}
if (size > global.NET_MAX_PACKET)
{
    net_log("ОШИБКА: пакет " + string(size) + " байт больше лимита, не отправлен");
    return -1;
}
net_crash_pkt(">", buffer_peek(buf, 0, buffer_u8), size); // v2.2
if (global.net_lag <= 0 && global.net_jitter <= 0)
{
    return net_udp_send(ip, port, buf, size);
}
var b = buffer_create(size, buffer_fixed, 1);
buffer_copy(buf, 0, size, b, 0);
ds_list_add(global.net_q_time, current_time + global.net_lag + irandom(global.net_jitter));
ds_list_add(global.net_q_ip, ip);
ds_list_add(global.net_q_port, port);
ds_list_add(global.net_q_buf, b);
return size;
