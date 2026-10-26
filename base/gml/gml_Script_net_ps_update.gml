for (var k = 0; k < ds_list_size(global.net_spur_list); k += 1)
{
    var bi = ds_list_find_value(global.net_spur_list, k);
    if (instance_exists(bi))
    {
        with (bi)
        {
            instance_destroy();
        }
    }
}
ds_list_clear(global.net_spur_list);
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.ps_iframes[i] > 0)
    {
        global.ps_iframes[i] -= 1;
        if (i == 1 && global.ps_iframes[i] == 0)
        {
            global.god = global.ps_god_saved;
        }
    }
}
if (global.ps_state[1] != global.NET_PS_ALIVE)
{
    var b = global.ps_body[1];
    if (b != -4 && instance_exists(b))
    {
        net_dummy_place(b.x, b.y, b.image_angle);
    }
    else if (global.net_dummy != -4 && instance_exists(global.net_dummy))
    {
        net_dummy_place(global.net_dummy.x, global.net_dummy.y, 0);
    }
    else
    {
        net_dummy_place(global.cam_px[1], global.cam_py[1], 0);
    }
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.ps_state[i] != global.NET_PS_DOWNED)
    {
        continue;
    }
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    var b = global.ps_body[i];
    if (i == 1 && b != -4 && instance_exists(b))
    {
        global.ps_cause[1] = net_death_cause(b);
    }
    var best = 0;
    var bestd = global.NET_REVIVE_RADIUS + 1;
    if (b != -4 && instance_exists(b))
    {
        for (var j = 1; j <= global.NET_MAX_PLAYERS; j += 1)
        {
            if (j == i || (j >= 2 && !global.pl_used[j]))
            {
                continue;
            }
            if ((global.pin_btn[j] & global.NET_BTN_REVIVE) == 0)
            {
                continue;
            }
            var me = net_player_inst(j);
            if (me == -4)
            {
                continue;
            }
            var d = point_distance(me.x, me.y, b.x, b.y);
            if (d <= global.NET_REVIVE_RADIUS && d < bestd)
            {
                best = j;
                bestd = d;
            }
        }
    }
    if (best != 0)
    {
        if (global.ps_reviver[i] != best)
        {
            global.ps_reviver[i] = best;
            global.ps_rev[i] = 0;
        }
        global.ps_rev[i] += 1;
        if ((global.ps_rev[i] % 6) == 1)
        {
            net_send_pevent(global.NET_EV_REVIVE_PROGRESS, i, best, (global.ps_rev[i] * 255) / global.NET_REVIVE_TICKS);
        }
        if (global.ps_rev[i] >= global.NET_REVIVE_TICKS)
        {
            net_player_revive(i);
            continue;
        }
    }
    else if (global.ps_rev[i] > 0)
    {
        global.ps_rev[i] = 0;
        global.ps_reviver[i] = 0;
        net_send_pevent(global.NET_EV_REVIVE_CANCEL, i, global.NET_CANCEL_LEFT, 0);
    }
    global.ps_timer[i] -= 1;
    if (global.ps_timer[i] <= 0)
    {
        net_player_dead(i);
    }
}
var alive = 0;
var anyone = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    if (global.ps_state[i] == global.NET_PS_ALIVE)
    {
        if (i == 1 || (global.av[i] != -4 && instance_exists(global.av[i])))
        {
            alive = 1;
        }
    }
    else
    {
        anyone = 1;
    }
}
if (anyone && !alive)
{
    if (global.net_restart_ticks < 0)
    {
        global.net_restart_ticks = global.NET_RESTART_TICKS;
        net_log("нет живых игроков — перезапуск через " + string(global.NET_RESTART_TICKS) + " тиков");
    }
    if ((global.net_restart_ticks % 60) == 0)
    {
        net_send_restart_cd(global.net_restart_ticks div 60);
    }
    global.net_restart_ticks -= 1;
    if (global.net_restart_ticks < 0)
    {
        net_level_restart();
    }
}
else
{
    global.net_restart_ticks = -1;
}
