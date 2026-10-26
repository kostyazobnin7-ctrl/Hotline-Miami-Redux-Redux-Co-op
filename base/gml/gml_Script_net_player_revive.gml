var pid = argument0;
if (global.ps_state[pid] != global.NET_PS_DOWNED)
{
    exit;
}
var b = global.ps_body[pid];
global.ps_state[pid] = global.NET_PS_ALIVE;
global.ps_timer[pid] = 0;
global.ps_rev[pid] = 0;
global.ps_reviver[pid] = 0;
global.ps_iframes[pid] = global.NET_IFRAMES_TICKS;
global.ps_body[pid] = -4;
if (pid == 1)
{
    var bx = 0;
    var by = 0;
    var ba = 0;
    if (b != -4 && instance_exists(b))
    {
        bx = b.x;
        by = b.y;
        ba = b.image_angle;
        with (b)
        {
            instance_destroy();
        }
    }
    else if (global.net_dummy != -4 && instance_exists(global.net_dummy))
    {
        bx = global.net_dummy.x;
        by = global.net_dummy.y;
    }
    if (global.net_dummy != -4 && instance_exists(global.net_dummy))
    {
        with (global.net_dummy)
        {
            instance_destroy();
        }
    }
    global.net_dummy = -4;
    var p = instance_create(bx, by, global.ps_p1_obj);
    if (instance_exists(p) && net_player_has_vars(p.object_index))
    {
        p.dir = ba;
    }
    global.ps_god_saved = global.god;
    global.god = 1;
}
else
{
    with (global.av[pid])
    {
        net_avatar_stand_up();
    }
}
global.net_ev_flash = 20;
net_log("игрок " + string(pid) + " поднят, i-frames " + string(global.NET_IFRAMES_TICKS));
net_send_pevent(global.NET_EV_REVIVED, pid, 0, 0);
