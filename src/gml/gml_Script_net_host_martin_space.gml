/// net_host_martin_space()
// v2.0, начало KeyPress Space игрока хоста: хост-Мартин бьёт стоящего врага головой
// (иначе игра хватала бы его за горло). 1 — удар был, оригинальный Space пропустить.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED || global.net_mode != global.NET_MODE_HOST || !net_martin(1))
{
    return 0;
}
if (!net_player_has_vars(object_index) || reload > 0)
{
    return 0;
}
if (net_martin_headbutt(id, 1))
{
    reload = 20;
    global.mh_t = 27;
    return 1;
}
return 0;
