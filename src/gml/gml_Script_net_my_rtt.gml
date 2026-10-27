/// net_my_rtt()
// v2.2, КЛИЕНТ: пинг до хоста в мс; -1 — нет связи или ещё не замерен.
if (global.net_mode != global.NET_MODE_CLIENT || global.net_conn != global.NET_CONN_CONNECTED)
{
    return -1;
}
var k = net_peer_find(global.net_host_ip, global.net_port);
if (k < 0 || !global.net_peer_alive[k] || global.net_peer_rtt[k] < 0)
{
    return -1;
}
return round(global.net_peer_rtt[k]);
