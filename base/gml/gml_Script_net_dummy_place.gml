var d = global.net_dummy;
if (d == -4 || !instance_exists(d))
{
    d = instance_create(argument0, argument1, objPlayer);
    ds_list_add(global.net_dummy_list, d);
    with (d)
    {
        visible = false;
        sprite_index = sprPWalkUnarmed;
        mask_index = sprMask;
        image_speed = 0;
        dir = 0;
        left = 1;
        legdir = 0;
        legindex = 0;
        myxspeed = 0;
        myyspeed = 0;
        aimon = 0;
        reload = 0;
        ammo = 0;
        light = 0;
        active = 0;
        maskon = 0;
        maskindex = 0;
        masksprite = -1;
    }
    global.net_dummy = d;
}
with (d)
{
    myxspeed = argument0 - x;
    myyspeed = argument1 - y;
    x = argument0;
    y = argument1;
    dir = argument2;
}
return d;
