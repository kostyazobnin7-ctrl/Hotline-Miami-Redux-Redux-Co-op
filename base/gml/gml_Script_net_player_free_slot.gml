for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (!global.pl_used[i])
    {
        return i;
    }
}
return 0;
