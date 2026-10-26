if (global.net_socket >= 0)
{
    network_destroy(global.net_socket);
    global.net_socket = -1;
    net_log("---- стоп");
}
if (global.net_q_buf >= 0)
{
    for (var i = 0; i < ds_list_size(global.net_q_buf); i += 1)
    {
        buffer_delete(ds_list_find_value(global.net_q_buf, i));
    }
    ds_list_destroy(global.net_q_time);
    ds_list_destroy(global.net_q_ip);
    ds_list_destroy(global.net_q_port);
    ds_list_destroy(global.net_q_buf);
    global.net_q_buf = -1;
}
if (global.net_wbuf >= 0)
{
    buffer_delete(global.net_wbuf);
    global.net_wbuf = -1;
}
if (global.net_logf >= 0)
{
    file_text_close(global.net_logf);
    global.net_logf = -1;
}
