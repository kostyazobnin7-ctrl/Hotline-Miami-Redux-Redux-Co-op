/// net_any_alive()
// v1.7: остался ли хоть один живой игрок (хост или аватар). Вне сети — 0, как в оригинале
// (после смерти игрока босс замирает: state = 1000).
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED || global.net_mode != global.NET_MODE_HOST)
{
    return 0;
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    if (net_player_inst(i) != -4)
    {
        return 1;
    }
}
return 0;
