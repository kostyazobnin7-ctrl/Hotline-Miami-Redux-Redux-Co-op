for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i] && global.pl_port[i] == argument1 && global.pl_ip[i] == argument0)
    {
        return i;
    }
}
return 0;
