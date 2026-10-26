var p = net_player_inst(1);
if (p == -4 || !net_player_has_vars(p.object_index))
{
    exit;
}
if (instance_exists(objEffector))
{
    if (objEffector.fade != 0)
    {
        exit;
    }
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
        with (t)
        {
            if (place_meeting(x, y, p))
            {
                t = -4;
            }
        }
        if (t == -4)
        {
        }
        else
        {
            p.x = a.x;
            p.y = a.y;
            p.myxspeed = 0;
            p.myyspeed = 0;
            net_log("P" + string(i) + " ведёт группу: " + object_get_name(t.object_index) + " (" + room_get_name(room) + ")");
            exit;
        }
    }
}
