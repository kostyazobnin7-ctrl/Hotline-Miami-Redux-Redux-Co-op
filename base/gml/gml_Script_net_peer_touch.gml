var ip = argument0;
var port = argument1;
var seen = argument2;
for (i = 0; i < global.net_peer_count; i += 1)
{
    if (global.net_peer_port[i] == port && global.net_peer_ip[i] == ip)
    {
        if (seen)
        {
            if (!global.net_peer_alive[i])
            {
                net_log("пир " + ip + ":" + string(port) + " на связи");
            }
            global.net_peer_seen[i] = current_time;
            global.net_peer_alive[i] = 1;
        }
        return i;
    }
}
if (global.net_peer_count >= 8)
{
    return -1;
}
var i = global.net_peer_count;
global.net_peer_ip[i] = ip;
global.net_peer_port[i] = port;
global.net_peer_rtt[i] = -1;
global.net_peer_alive[i] = seen;
global.net_peer_fixed[i] = !seen;
if (seen)
{
    global.net_peer_seen[i] = current_time;
}
else
{
    global.net_peer_seen[i] = 0;
}
global.net_peer_count += 1;
net_log("новый пир " + ip + ":" + string(port));
return i;
