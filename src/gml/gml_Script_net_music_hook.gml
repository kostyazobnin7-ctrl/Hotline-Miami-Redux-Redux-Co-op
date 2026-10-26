/// net_music_hook(play, path)
// v1.4.4: начало sxeasy_play (play = 1) и sxeasy_stop (play = 0).
// ХОСТ: запоминает, что играет, и сразу шлёт FLOW (клиенты включают то же).
// КЛИЕНТ: свои вызовы игры игнорирует (музыку включает только FLOW от хоста).
// Возвращает 1, если вызов надо пропустить.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return 0;
}
if (global.net_mode == global.NET_MODE_CLIENT)
{
    return !global.net_mus_replay;
}
if (argument0)
{
    var p = string_replace(string(argument1), working_directory, "");
    if (global.net_mus_on && global.net_mus_path == p)
    {
        return 0;
    }
    global.net_mus_on = 1;
    global.net_mus_path = p;
}
else
{
    if (!global.net_mus_on)
    {
        return 0;
    }
    global.net_mus_on = 0;
}
global.net_mus_seq = (global.net_mus_seq + 1) % 65536;
global.net_flow_room = -1; // FLOW на этом же тике
return 0;
