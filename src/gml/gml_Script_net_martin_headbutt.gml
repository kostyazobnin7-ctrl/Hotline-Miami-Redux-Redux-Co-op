/// net_martin_headbutt(inst, pid)
// v2.0, ХОСТ: удар головой Мясника (Space, как scrHeadButtEnemy + objPigHeadButt в игре):
// стоящий враг вплотную спереди убит сразу. Не действует на собак, толстяков, полицию,
// уклоняющихся. 1 — сработало.
var a = argument0;
var p = argument1;
if (!instance_exists(a))
{
    return 0;
}
var hx = a.x + lengthdir_x(12, a.dir);
var hy = a.y + lengthdir_y(12, a.dir);
var e = noone;
var bd = 20;
with (objEnemy)
{
    if (object_index == objDogPatrol || object_index == objEnemyFat || scrIsPolice(object_index) || object_index == objEDodger || object_index == objEDodgerG)
    {
        continue;
    }
    var d = point_distance(x, y, hx, hy);
    if (d < bd)
    {
        bd = d;
        e = id;
    }
}
if (e == noone)
{
    if (global.net_debug)
    {
        var ne = instance_nearest(hx, hy, objEnemy);
        var nd = -1;
        if (ne != noone)
        {
            nd = point_distance(ne.x, ne.y, hx, hy);
        }
        net_log("debug: удар головой P" + string(p) + " — рядом нет врага (ближайший " + string(round(nd)) + ")");
    }
    return 0;
}
var ex = e.x;
var ey = e.y;
var ang = a.dir;
with (e)
{
    if (!(sprite_index == sprEWalkUnarmed || sprite_index == sprEGiveUp))
    {
        var wt = instance_create(x, y, objWeaponThrow);
        wt.direction = (ang - 115) + random(50);
        wt.speed = 2 + random(1);
        wt.image_index = scrCurrentWeaponExt(sprite_index);
        wt.ammo = ammo;
    }
    instance_destroy();
}
var b = instance_create(ex + lengthdir_x(7, ang), ey + lengthdir_y(7, ang), objBloodPool);
var db = instance_create(ex, ey, objDeadBody);
db.sprite_index = sprEDeadHammer;
db.image_speed = 0.15;
db.image_angle = ang;
var sc = instance_create(ex, ey - 12, objScore);
sc.text = "+" + string(200 + (400 * global.factor)) + "pts";
global.myscore += 200 + (400 * global.factor);
global.killscore += 200;
global.boldscore += 400 * global.factor;
global.combotime = 240;
global.combo += 1;
global.killx[global.kills] = ex;
global.killy[global.kills] = ey;
global.kills += 1;
global.shake = 4;
net_snd(14, 0, 0);
net_snd(15, 0, 0);
net_log("P" + string(p) + " (Мартин) удар головой");
return 1;
