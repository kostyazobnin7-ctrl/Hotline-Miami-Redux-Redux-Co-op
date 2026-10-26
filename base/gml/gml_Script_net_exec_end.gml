var p = net_exec_owner();
if (p < 2)
{
    return instance_create(argument0, argument1, objPlayerMouse);
}
ds_map_delete(global.net_exec_map, id);
global.pe_exec[p] = -4;
var a = global.av[p];
if (a == -4 || !instance_exists(a))
{
    a = instance_create(argument0, argument1, objCoopAvatar);
    a.pid = p;
    global.av[p] = a;
}
a.x = argument0;
a.y = argument1;
a.visible = true;
a.image_speed = 0;
a.image_index = 0;
a.myxspeed = 0;
a.myyspeed = 0;
net_log("P" + string(p) + " закончил казнь");
return a;
