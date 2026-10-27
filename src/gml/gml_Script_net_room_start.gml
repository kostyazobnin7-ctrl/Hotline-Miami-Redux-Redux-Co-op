// v1.6: пауза (ESC) — уход в rmPause и возврат в ту же сохранённую комнату (persistent).
// Состояние кооператива (кто жив, кто лежит, аватары) не трогаем: раньше возврат из паузы
// оживлял всех. Перезапуск из меню паузы (PauseRestart) идёт обычным путём.
var from_pause = (global.net_rs_last == rmPause && room == global.lastroom && global.PauseRestart == 0 && !global.net_restarting);
global.net_rs_last = room;
if (room == rmPause || from_pause)
{
    if (from_pause)
    {
        // комната сохранена вместе с аватарами — вернуть ссылки на них (иначе появлялись двойники)
        with (objCoopAvatar)
        {
            if (pid >= 1 && pid <= global.NET_MAX_PLAYERS)
            {
                global.av[pid] = id;
            }
        }
        net_log("возврат из паузы — состояние игроков сохранено");
    }
    exit;
}
if (global.net_restarting && global.net_mode == global.NET_MODE_HOST)
{
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        global.pw_wpn[i] = global.NET_WPN_NONE;
        global.pw_ammo[i] = 0;
        global.pw_reload[i] = 0;
    }
}
global.net_restarting = 0;
for (var k = 0; k < ds_list_size(global.net_dummy_list); k += 1)
{
    var d = ds_list_find_value(global.net_dummy_list, k);
    if (instance_exists(d))
    {
        with (d)
        {
            instance_destroy();
        }
    }
}
ds_list_clear(global.net_dummy_list);
global.net_dummy = -4;
with (objCoopAvatar)
{
    instance_destroy();
}
with (objCoopEntity)
{
    instance_destroy();
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.av[i] = -4;
    global.sn_have[i] = 0;
    global.pt_armed[i] = 0;
}
if (global.net_mode == global.NET_MODE_CLIENT && global.net_started && global.net_my_pid > 0)
{
    net_dummy_place(global.sn_x1[global.net_my_pid], global.sn_y1[global.net_my_pid], 0);
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.spec_active[i] = 0;
    global.spec_target_of[i] = 0;
    global.spec_fade[i] = 0;
}
global.spec_sent_target = -1;
ds_map_clear(global.net_tgt_map);
ds_map_clear(global.net_tgt_until);
ds_map_clear(global.ent_map);
ds_map_clear(global.net_exec_map);
ds_map_clear(global.door_map);
global.door_have = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.pe_exec[i] = -4;
}
global.ent_next = 1;
if (global.net_mode == global.NET_MODE_HOST)
{
    if (global.ps_iframes[1] > 0)
    {
        global.god = global.ps_god_saved;
    }
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        global.ps_state[i] = global.NET_PS_ALIVE;
        global.ps_timer[i] = 0;
        global.ps_rev[i] = 0;
        global.ps_reviver[i] = 0;
        global.ps_iframes[i] = 0;
        global.ps_body[i] = -4;
        global.ps_cause[i] = 0;
    }
    global.net_restart_ticks = -1;
    for (var kn = 0; kn <= global.NET_MAX_PLAYERS; kn += 1)
    {
        global.pk_knives[kn] = 3 - (2 * (global.hardmode == 1)); // v1.8: как ammo у objPlayerBiker
        global.pk_armor[kn] = 1; // v2.0: броня Мартина
    }
    global.net_restart_sec = 0;
    ds_list_clear(global.net_spur_list);
}
