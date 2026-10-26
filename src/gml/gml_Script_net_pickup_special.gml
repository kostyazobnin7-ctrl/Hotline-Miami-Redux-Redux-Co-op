/// net_pickup_special(px, py, dir, pid)
// v1.6, ХОСТ: клиент pid нажал «подобрать» — особые предметы (маски с пола, буквы, улики,
// коробки, подарки...). Выполняется начало scrPlayerPickUp (net_c_pickup_special) в контексте
// objPlayer хоста, поставленного на место аватара (как net_story_try). 1 — что-то подобрано.
var px = argument0;
var py = argument1;
var pdir = argument2;
var p = net_player_inst(1);
if (p != -4 && !net_player_has_vars(p.object_index))
{
    return 0;
}
if (p == -4)
{
    p = global.net_dummy;
    if (p == -4 || !instance_exists(p))
    {
        return 0;
    }
}
var sx = p.x;
var sy = p.y;
var sd = p.dir;
var ss = p.sprite_index;
var si = p.image_index;
var ic = instance_count;
var dn = global.done;
with (p)
{
    x = px;
    y = py;
    dir = pdir;
    sprite_index = sprPWalkUnarmed;
    image_index = 0;
}
global.st_run = 1;
with (p)
{
    net_c_pickup_special();
}
global.st_run = 0;
var ch = instance_count != ic || global.done != dn;
if (instance_exists(p))
{
    with (p)
    {
        x = sx;
        y = sy;
        dir = sd;
        sprite_index = ss;
        image_index = si;
    }
}
if (ch)
{
    net_story_add(global.ST_PICK, 0, 0, 0, px, py, pdir);
    net_log("подбор: игрок " + string(argument3) + " — особый предмет");
}
return ch;
