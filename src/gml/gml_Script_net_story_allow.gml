/// net_story_allow()
// Начало событий мыши сюжетных предметов. Вне сетевой игры — как в оригинале.
// В сетевой игре событие выполняется только из net_story_try / net_story_apply.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return 1;
}
return global.st_run;
