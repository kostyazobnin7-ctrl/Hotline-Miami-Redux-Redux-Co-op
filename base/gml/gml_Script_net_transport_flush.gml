var i = ds_list_size(global.net_q_time) - 1;
while (i >= 0)
{
    if (ds_list_find_value(global.net_q_time, i) <= current_time)
    {
        var b = ds_list_find_value(global.net_q_buf, i);
        net_udp_send(ds_list_find_value(global.net_q_ip, i), ds_list_find_value(global.net_q_port, i), b, buffer_get_size(b));
        buffer_delete(b);
        ds_list_delete(global.net_q_time, i);
        ds_list_delete(global.net_q_ip, i);
        ds_list_delete(global.net_q_port, i);
        ds_list_delete(global.net_q_buf, i);
    }
    i -= 1;
}
