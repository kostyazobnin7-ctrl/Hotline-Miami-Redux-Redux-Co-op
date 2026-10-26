if (global.net_mode != global.NET_MODE_HOST || global.net_started)
{
    return 0;
}
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i] && !global.pl_ready[i])
    {
        return 0;
    }
}
return 1;
