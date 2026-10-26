var e = global.pe_exec[pid];
instance_activate_object(e);
if (!instance_exists(e))
{
    global.pe_exec[pid] = -4;
    visible = true;
    exit;
}
x = e.x;
y = e.y;
visible = false;
var n = ds_list_size(global.pin_q[pid]);
var steps = 0;
if (n > 0)
{
    steps = 1;
}
if (n > 3)
{
    steps = 2;
}
if (n > 8)
{
    steps = 3;
}
for (var k = 0; k < steps; k += 1)
{
    net_input_pop(pid);
}
global.net_exec_click = 1;
if (global.pin_atk_edge[pid])
{
    with (e)
    {
        event_perform(ev_mouse, ev_global_left_press);
    }
}
if ((global.pin_btn[pid] & global.NET_BTN_ATTACK) != 0)
{
    if (instance_exists(e))
    {
        with (e)
        {
            event_perform(ev_mouse, ev_global_left_button);
        }
    }
}
global.net_exec_click = 0;
global.pin_atk_edge[pid] = 0;
global.pin_use_edge[pid] = 0;
