/// net_biker_throw(avatar, pid)
// v1.8, ХОСТ: ПКМ Байкера — метнуть нож (как objPlayerBiker Mouse_51): objThrowingKnife из
// аватара в сторону прицела, 3 ножа на этаж (1 на харде). Оружие Байкер не подбирает.
var a = argument0;
var p = argument1;
if (global.pk_knives[p] <= 0 || global.pw_reload[p] > 0)
{
    exit;
}
global.pk_knives[p] -= 1;
global.pw_reload[p] = 30;
with (a)
{
    var k = instance_create(x, y, objThrowingKnife);
    global.dir = dir;
    with (k)
    {
        move_contact_solid(global.dir, 12);
    }
    k.direction = dir;
    k.image_angle = dir;
    k.speed = 12;
    sprite_index = sprBikerAttackKnife;
    image_index = 0;
    image_speed = 0.5;
}
net_snd(14, 0, 0);
net_log("P" + string(p) + " (Байкер) метнул нож, осталось " + string(global.pk_knives[p]));
