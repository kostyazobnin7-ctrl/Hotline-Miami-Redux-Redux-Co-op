var p = pid;
if (reload > 0 || global.pe_exec[p] != -4)
{
    exit;
}
ds_list_clear(global.net_exec_tmp);
with (objPlayer)
{
    ds_list_add(global.net_exec_tmp, id);
}
var nw0 = instance_number(objWeaponThrow);
var w = global.pw_wpn[p];
var px = instance_create(x, y, objCoopEntity);
with (px)
{
    visible = false;
    mask_index = sprMask;
    image_speed = 0;
    image_index = 0;
    if (w == global.NET_WPN_NONE)
    {
        sprite_index = sprPWalkUnarmed;
    }
    else
    {
        sprite_index = global.wpn_walk[w];
    }
    throwindex = 0;
    if (w != global.NET_WPN_NONE && w >= 30)
    {
        throwindex = w - 30;
    }
    dir = other.dir;
    left = other.left;
    reload = 0;
    ammo = 0;
    maskindex = 0;
    maskon = 0;
    lastweapon = 0;
    lastammo = 0;
    release = 0;
    decadenced = 0;
    nothing = 0;
    my_id = -4;
}
global.net_atk = px;
with (px)
{
    net_c_scrKillShield(0, 0, 0, 0, 0);
}
global.net_atk = -4;
if (instance_exists(px))
{
    with (px)
    {
        instance_destroy();
    }
    exit;
}
var e = -4;
with (objPlayer)
{
    if (e == -4 && ds_list_find_index(global.net_exec_tmp, id) < 0)
    {
        e = id;
    }
}
if (instance_number(objWeaponThrow) > nw0)
{
    global.pw_wpn[p] = global.NET_WPN_NONE;
    global.pw_ammo[p] = 0;
    sprite_index = sprPWalkUnarmed;
}
if (e == -4)
{
    exit;
}
ds_map_replace(global.net_exec_map, e, p);
global.pe_exec[p] = e;
global.stat_execs[p] += 1; // v1.9
visible = false;
x = e.x;
y = e.y;
global.net_execs += 1;
net_log("P" + string(p) + " казнит: " + object_get_name(e.object_index));
