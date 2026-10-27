/// net_lobby_extra_update()
// v1.7, каждый тик (лобби и игра):
//  ХОСТ — раз в 0.5 с пакет LOOK (настройка масок, скины игроков, кому передано сохранение);
//         клиентам без подтверждения раз в секунду шлёт сохранение (SAVE).
//  КЛИЕНТ — раз в секунду MASK: своя маска, её скин и скин персонажа (Джек / Байкер).
if (global.net_conn != global.NET_CONN_CONNECTED)
{
    exit;
}
if (global.net_mode == global.NET_MODE_HOST)
{
    for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        if (!global.pl_used[i])
        {
            global.pl_save_ok[i] = 0;
            global.pl_skin[i] = 0;
        }
    }
    global.pl_skin[1] = global.net_skin_my; // v1.8.1: хост тоже может быть Байкером
    if ((current_time - global.lx_t) < 500)
    {
        exit;
    }
    global.lx_t = current_time;
    var w = net_packet_begin(global.NET_MSG_LOOK);
    buffer_write(w, buffer_u8, global.net_opt_masks);
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        buffer_write(w, buffer_u8, global.pl_skin[i]);
        buffer_write(w, buffer_u8, i == 1 || global.pl_save_ok[i]);
    }
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        buffer_write(w, buffer_u8, clamp(global.pk_knives[i], 0, 255)); // v1.8
        buffer_write(w, buffer_u8, clamp(global.pk_armor[i], 0, 255)); // v2.0
    }
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        buffer_write(w, buffer_u16, clamp(global.stat_kills[i], 0, 65535)); // v1.9
        buffer_write(w, buffer_u16, clamp(global.stat_execs[i], 0, 65535));
        buffer_write(w, buffer_u16, clamp(global.stat_downs[i], 0, 65535));
    }
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        // v2.2: пинг каждого игрока до хоста (65535 — неизвестно) — для таблицы на TAB
        var rt = net_pl_rtt(i);
        if (rt < 0)
        {
            rt = 65535;
        }
        buffer_write(w, buffer_u16, clamp(rt, 0, 65535));
    }
    var size = buffer_tell(w);
    for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        if (global.pl_used[i])
        {
            net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
            if (!global.pl_save_ok[i] && (current_time - global.sv_sent_t[i]) >= 1000)
            {
                global.sv_sent_t[i] = current_time;
                net_save_send(i);
            }
        }
    }
}
else if (global.net_mode == global.NET_MODE_CLIENT)
{
    var me = global.net_my_pid;
    if (me <= 0 || (current_time - global.lx_t) < 1000)
    {
        exit;
    }
    global.lx_t = current_time;
    global.pl_skin[me] = global.net_skin_my;
    var w = net_packet_begin(global.NET_MSG_MASK);
    buffer_write(w, buffer_u8, global.pl_mask[me]);
    buffer_write(w, buffer_u8, global.pl_mskin[me]);
    buffer_write(w, buffer_u8, global.net_skin_my);
    net_transport_send(global.net_host_ip, global.net_port, w, buffer_tell(w));
}
