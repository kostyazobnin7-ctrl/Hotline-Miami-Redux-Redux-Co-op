/// net_pl_rtt(pid)
// v2.2: пинг игрока в мс (-1 — неизвестно). Хост меряет до каждого клиента сам (PING/PONG),
// клиенты: до хоста — свой замер, остальные — из пакета LOOK (их пинг до хоста).
var p = argument0;
if (p < 1 || p > global.NET_MAX_PLAYERS)
{
    return -1;
}
if (global.net_mode == global.NET_MODE_HOST)
{
    if (p == 1)
    {
        return 0;
    }
    var k = net_peer_find(global.pl_ip[p], global.pl_port[p]);
    if (k < 0 || !global.net_peer_alive[k] || global.net_peer_rtt[k] < 0)
    {
        return -1;
    }
    return round(global.net_peer_rtt[k]);
}
if (global.net_mode == global.NET_MODE_CLIENT)
{
    if (p == 1 || p == global.net_my_pid)
    {
        return net_my_rtt();
    }
    return global.pl_rtt[p];
}
return -1;
