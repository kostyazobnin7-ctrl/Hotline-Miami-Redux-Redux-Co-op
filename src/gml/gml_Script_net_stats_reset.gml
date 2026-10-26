/// net_stats_reset()
// v1.9: обнулить статистику игроков (начало уровня).
for (var i = 0; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.stat_kills[i] = 0;
    global.stat_execs[i] = 0;
    global.stat_downs[i] = 0;
}
