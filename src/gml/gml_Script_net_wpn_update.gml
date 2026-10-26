if (global.ps_state[1] != global.NET_PS_ALIVE)
{
    global.pw_wpn[1] = global.NET_WPN_NONE;
    global.pw_ammo[1] = 0;
}
else
{
    var p = net_player_inst(1);
    if (p != -4)
    {
        with (p)
        {
            if (net_player_has_vars(object_index))
            {
                global.pw_wpn[1] = net_wpn_id();
                global.pw_ammo[1] = ammo;
            }
        }
    }
}
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pw_reload[i] > 0)
    {
        global.pw_reload[i] -= 1;
    }
    // v1.8: Байкер всегда с тесаком (как мачете — режет с одного удара), чужое оружие не берёт
    if (net_biker(i) && global.ps_state[i] == global.NET_PS_ALIVE)
    {
        global.pw_wpn[i] = 18;
        global.pw_ammo[i] = 0;
    }
    if (global.pin_pick[i] == global.pin_pick_done[i])
    {
        continue;
    }
    global.pin_pick_done[i] = global.pin_pick[i];
    if (!global.pl_used[i] || global.ps_state[i] != global.NET_PS_ALIVE || global.pw_reload[i] > 0)
    {
        continue;
    }
    var a = global.av[i];
    if (a == -4 || !instance_exists(a))
    {
        continue;
    }
    // v1.4: сначала сюжетный предмет (кейс, телефон...), иначе — оружие
    if (net_pickup_special(a.x, a.y, a.dir, i) || net_story_try(a.x, a.y, a.dir, i))
    {
        continue;
    }
    if (net_biker(i))
    {
        net_biker_throw(a, i);
        continue;
    }
    with (a)
    {
        net_avatar_pickup();
    }
}
