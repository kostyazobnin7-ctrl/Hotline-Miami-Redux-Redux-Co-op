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
var p = -4;
if (argument0 != 1)
{
    p = net_player_inst(1);
}
var best = -1;
var bestd = -1;
if (argument1)
{
    var sx = a.x + lengthdir_x(24, a.dir);
    var sy = a.y + lengthdir_y(24, a.dir);
    if (!position_meeting(sx, sy, objSolid))
    {
        e = instance_create(sx, sy, objEnemyMelee);
        e.alert = 2;
        net_log("debug: objEnemyMelee по прицелу P" + string(argument0) + " (" + string(round(e.x)) + "," + string(round(e.y)) + ")");
        exit;
    }
}
for (var k = 0; k < 16; k += 1)
{
    var ang = k * 22.5;
    var sx = a.x + lengthdir_x(64, ang);
    var sy = a.y + lengthdir_y(64, ang);
    if (collision_line(sx, sy, a.x, a.y, objSolid, false, true) == -4 && !position_meeting(sx, sy, objSolid))
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
    net_log("debug: нет места для врага у P" + string(argument0));
    exit;
}
var e = instance_create(a.x + lengthdir_x(64, best), a.y + lengthdir_y(64, best), objEnemyMelee);
e.alert = 2;
net_log("debug: objEnemyMelee у P" + string(argument0) + " (" + string(round(e.x)) + "," + string(round(e.y)) + ")");
