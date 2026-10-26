/// net_lc_hook()
// v1.4.4: начало Create objLevelComplete («CHAPTER CLEAR»). Хост рассылает событие,
// клиент показывает надпись только по нему (у клиента враги выключены, и проверка
// конца уровня срабатывала сама — надпись была дважды). 1 — удалить экземпляр.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return 0;
}
if (global.net_mode == global.NET_MODE_HOST)
{
    net_story_add(global.ST_LC, max(0, x), max(0, y), 0, 0, 0, 0);
    return 0;
}
return !global.st_lc_allow;
