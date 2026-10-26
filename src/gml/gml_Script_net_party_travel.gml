var p = net_player_inst(1);
if (p != -4 && !net_player_has_vars(p.object_index))
{
    exit;
}
// v1.4.4: p == -4 — хост лежит или убит; группу ведут клиенты (хост поднимается при переходе)
if (instance_exists(objEffector))
{
    if (objEffector.fade != 0)
    {
        exit;
    }
}
// v1.4.4: хост ещё выбирает маску — переход отложить (иначе игра возвращала его назад)
if (p != -4 && net_mask_menu_open())
{
    exit;
}
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    var a = global.av[i];
    if (!global.pl_used[i] || a == -4 || !instance_exists(a))
    {
        continue;
    }
    if (global.ps_state[i] != global.NET_PS_ALIVE || global.pe_exec[i] != -4)
    {
        continue;
    }
    var t = net_party_trigger(a);
    if (t == -4)
    {
        global.pt_armed[i] = 1;
    }
    else if (!global.pt_armed[i])
    {
    }
    else
    {
        if (p != -4)
        {
            with (t)
            {
                if (place_meeting(x, y, p))
                {
                    t = -4;
                }
            }
        }
        if (t == -4)
        {
        }
        else
        {
            if (p == -4)
            {
                // проходы и машина срабатывают только от настоящего игрока — поднять хоста;
                // в следующей комнате все и так снова живы (net_room_start)
                if (global.ps_state[1] == global.NET_PS_DEAD)
                {
                    global.ps_state[1] = global.NET_PS_DOWNED;
                }
                net_player_revive(1);
                p = net_player_inst(1);
                if (p == -4 || !net_player_has_vars(p.object_index))
                {
                    exit;
                }
                net_log("хост поднят для перехода группы");
            }
            p.x = a.x;
            p.y = a.y;
            p.myxspeed = 0;
            p.myyspeed = 0;
            net_log("P" + string(i) + " ведёт группу: " + object_get_name(t.object_index) + " (" + room_get_name(room) + ")");
            exit;
        }
    }
}
