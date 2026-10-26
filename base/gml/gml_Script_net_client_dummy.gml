var a = -4;
if (global.net_my_pid > 0)
{
    a = global.av[global.net_my_pid];
}
var d;
if (a != -4 && instance_exists(a))
{
    d = net_dummy_place(a.x, a.y, a.dir);
}
else if (global.net_dummy != -4 && instance_exists(global.net_dummy))
{
    d = global.net_dummy;
}
else
{
    d = net_dummy_place(0, 0, 0);
}
instance_deactivate_object(objPlayer);
instance_activate_object(d);
if (a != -4 && instance_exists(a))
{
    with (d)
    {
        left = a.left;
        legdir = a.legdir;
        legindex = a.legindex;
        sprite_index = a.sprite_index;
        image_index = a.image_index;
        ammo = global.pw_ammo[global.net_my_pid];
    }
}
