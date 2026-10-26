if (global.net_mode != global.NET_MODE_HOST || global.net_started)
{
    return 0;
}
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    // v1.7: и сохранение хоста уже применено у клиента
    if (global.pl_used[i] && (!global.pl_ready[i] || !global.pl_save_ok[i]))
    {
        return 0;
    }
}
return 1;
