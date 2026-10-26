for (var i = 0; i < global.net_peer_count; i += 1)
{
    if (global.net_peer_port[i] == argument1 && global.net_peer_ip[i] == argument0)
    {
        return i;
    }
}
return -1;
