global.net_socket = -1;
global.net_local_port = -1;
global.net_logf = -1;
global.net_wbuf = buffer_create(256, buffer_grow, 1);
global.net_q_time = ds_list_create();
global.net_q_ip = ds_list_create();
global.net_q_port = ds_list_create();
global.net_q_buf = ds_list_create();
global.net_peer_count = 0;
global.net_bytes_out = 0;
global.net_bytes_in = 0;
global.net_rate_out = 0;
global.net_rate_in = 0;
global.net_rate_t = current_time;
global.net_rate_out_acc = 0;
global.net_rate_in_acc = 0;
global.net_drops = 0;
global.net_ping_t = current_time;
if (global.net_mode == global.NET_MODE_OFF)
{
    return 0;
}
var tries, p;
if (global.net_mode == global.NET_MODE_HOST)
{
    p = global.net_port;
    tries = 1;
}
else
{
    p = global.net_port + 1;
    tries = global.NET_PORT_TRIES;
}
for (var k = 0; k < tries; k += 1)
{
    global.net_socket = network_create_socket_ext(1, p + k);
    if (global.net_socket >= 0)
    {
        global.net_local_port = p + k;
        break;
    }
}
if (global.net_local_port > 0)
{
    global.net_logname = "coop_net_" + string(global.net_local_port) + ".log";
}
global.net_logf = file_text_open_append(global.net_logname);
if (global.net_socket < 0)
{
    show_debug_message("[COOP] не удалось открыть UDP-порт " + string(p));
    return 0;
}
net_log("---- старт, режим " + string(global.net_mode) + ", порт " + string(global.net_local_port) + ", протокол " + string(global.NET_PROTO) + ", lag " + string(global.net_lag) + " jitter " + string(global.net_jitter));
if (global.crash_prev)
{
    net_log("ВНИМАНИЕ: прошлый запуск игры завершился вылетом, его состояние — coop_crash_context.txt");
}
if (global.net_mode == global.NET_MODE_CLIENT)
{
    net_peer_touch(global.net_host_ip, global.net_port, 0);
}
return 1;
