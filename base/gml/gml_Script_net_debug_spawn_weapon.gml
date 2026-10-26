var a;
if (argument0 == 1)
{
    a = net_player_inst(1);
}
else
{
    a = global.av[argument0];
}
if (a == -4 || !instance_exists(a))
{
    exit;
}
var w = instance_create(a.x, a.y, objWeapon);
global.net_debug_wpn = (global.net_debug_wpn + 1) % 3;
if (keyboard_check(vk_shift))
{
    global.net_debug_wpn = 1;
}
if (global.net_debug_wpn == 0)
{
    w.image_index = 1;
    w.ammo = 6;
}
else if (global.net_debug_wpn == 1)
{
    w.image_index = 4;
    w.ammo = 0;
}
else
{
    w.image_index = 9;
    w.ammo = 30;
}
net_log("debug: objWeapon " + global.wpn_name[w.image_index] + " у P" + string(argument0));
