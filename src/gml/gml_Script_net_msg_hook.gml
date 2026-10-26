/// net_msg_hook(msg)
// Начало scrGetMessage. Хост рассылает номер диалога; клиент показывает диалог только
// по команде хоста (свои локальные срабатывания зон и предметов не дублируются).
// Возвращает 1, если диалог показывать не надо.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return 0;
}
if (global.net_mode == global.NET_MODE_HOST)
{
    net_story_add(global.ST_MSG, argument0, object_index, x, y, 0, 0);
    return 0;
}
return !global.st_replay;
