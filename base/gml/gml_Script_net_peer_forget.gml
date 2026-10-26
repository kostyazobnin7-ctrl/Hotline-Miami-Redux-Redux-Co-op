var i = net_peer_find(argument0, argument1);
if (i < 0)
{
    exit;
}
for (var j = i; j < (global.net_peer_count - 1); j += 1)
{
    global.net_peer_ip[j] = global.net_peer_ip[j + 1];
    global.net_peer_port[j] = global.net_peer_port[j + 1];
    global.net_peer_seen[j] = global.net_peer_seen[j + 1];
    global.net_peer_rtt[j] = global.net_peer_rtt[j + 1];
    global.net_peer_alive[j] = global.net_peer_alive[j + 1];
    global.net_peer_fixed[j] = global.net_peer_fixed[j + 1];
}
global.net_peer_count -= 1;
