var a;
if (argument1 == 1)
{
    a = net_player_inst(1);
}
else
{
    a = global.av[argument1];
}
if (a == -4 || !instance_exists(a))
{
    exit;
}
var p = -4;
if (argument1 != 1)
{
    p = net_player_inst(1);
}
var best = -1;
var bestd = -1;
for (var k = 0; k < 16; k += 1)
{
    var ang = k * 22.5;
    var sx = a.x + lengthdir_x(48, ang);
    var sy = a.y + lengthdir_y(48, ang);
    if (collision_line(sx, sy, a.x, a.y, objSolid, false, true) == -4 && position_meeting(sx, sy, objSolid) == 0)
    {
        var d = 1000;
        if (p != -4)
        {
            d = point_distance(sx, sy, p.x, p.y);
        }
        if (d > bestd)
        {
            bestd = d;
            best = ang;
        }
    }
}
if (best < 0)
{
    net_log("debug: нет свободного направления для выстрела в P" + string(argument1));
    exit;
}
var b = instance_create(a.x + lengthdir_x(48, best), a.y + lengthdir_y(48, best), argument0);
b.direction = best + 180;
b.speed = 8;
b.image_angle = b.direction;
global.net_debug_shots += 1;
net_log("debug: " + object_get_name(argument0) + " -> P" + string(argument1));
