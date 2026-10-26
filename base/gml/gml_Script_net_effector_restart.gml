global.net_restarting = 1;
var dx = 0;
var dy = 0;
if (global.net_dummy != -4 && instance_exists(global.net_dummy))
{
    dx = global.net_dummy.x;
    dy = global.net_dummy.y;
    with (global.net_dummy)
    {
        instance_destroy();
    }
}
global.net_dummy = -4;
if (instance_exists(objEffector) || instance_exists(objEffectorHouse) || instance_exists(objEffectorInstant) || instance_exists(objEffectorHospital))
{
    with (objEffector)
    {
        event_perform(ev_keypress, ord("R"));
    }
    with (objEffectorHouse)
    {
        event_perform(ev_keypress, ord("R"));
    }
    with (objEffectorInstant)
    {
        event_perform(ev_keypress, ord("R"));
    }
    with (objEffectorHospital)
    {
        event_perform(ev_keypress, ord("R"));
    }
    var started = 0;
    with (objEffector)
    {
        if (fade == 1)
        {
            started = 1;
        }
    }
    with (objEffectorHouse)
    {
        if (fade == 1)
        {
            started = 1;
        }
    }
    with (objEffectorInstant)
    {
        if (fade == 1)
        {
            started = 1;
        }
    }
    with (objEffectorHospital)
    {
        if (fade == 1)
        {
            started = 1;
        }
    }
    if (!started)
    {
        net_room_restart_clean();
    }
}
else
{
    net_room_restart_clean();
}
net_dummy_place(dx, dy, 0);
ds_list_clear(global.net_rs_list);
with (objPlayer)
{
    ds_list_add(global.net_rs_list, id);
}
global.net_rs_t = current_time;
