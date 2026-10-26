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
dir = global.pin_aim[pid];
if (image_speed == 0)
{
    if (global.pw_wpn[pid] == global.NET_WPN_NONE)
    {
        sprite_index = sprPWalkUnarmed;
    }
    else
    {
        sprite_index = global.wpn_walk[global.pw_wpn[pid]];
        if (global.pw_wpn[pid] >= 30)
        {
            throwindex = global.pw_wpn[pid] - 30;
        }
    }
}
for (var k = 0; k < steps; k += 1)
{
    net_input_pop(pid);
    dir = global.pin_aim[pid];
    net_avatar_move(global.pin_move[pid]);
}
