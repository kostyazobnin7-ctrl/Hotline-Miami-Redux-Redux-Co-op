if (!global.net_restarting)
{
    exit;
}
var fresh = 0;
with (objPlayer)
{
    if (id != global.net_dummy && net_exec_owner() < 2 && ds_list_find_index(global.net_rs_list, id) < 0)
    {
        fresh = 1;
    }
}
if (!fresh && (current_time - global.net_rs_t) < global.NET_RESTART_INPLACE_MS)
{
    exit;
}
if (fresh)
{
    net_log("перезапуск уровня без смены комнаты (" + room_get_name(room) + ") — сброс кооп-состояния");
}
else
{
    net_log("перезапуск не дошёл до Room Start за " + string(global.NET_RESTART_INPLACE_MS) + " мс — сброс кооп-состояния");
}
with (objCoopAvatar)
{
    instance_destroy();
}
with (objCoopEntity)
{
    instance_destroy();
}
if (global.net_dummy != -4 && instance_exists(global.net_dummy))
{
    with (global.net_dummy)
    {
        instance_destroy();
    }
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.av[i] = -4;
    global.sn_have[i] = 0;
}
net_room_start();
