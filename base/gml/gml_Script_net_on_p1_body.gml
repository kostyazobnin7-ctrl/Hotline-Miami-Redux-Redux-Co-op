if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    exit;
}
if (global.ps_state[1] != global.NET_PS_ALIVE)
{
    visible = false;
    ds_list_add(global.net_spur_list, id);
    exit;
}
global.ps_p1_obj = 0;
with (objPlayer)
{
    if (id != global.net_dummy && net_player_has_vars(object_index))
    {
        global.ps_p1_obj = object_index;
    }
}
net_player_down(1, id);
net_dummy_place(x, y, image_angle);
