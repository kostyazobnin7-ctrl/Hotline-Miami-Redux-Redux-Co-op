/// net_story_apply(kind, a, b, c, d, e, f)
// КЛИЕНТ: повторить сюжетное событие хоста.
//  USE — событие предмета a у точки (b, c); локальный манекен objPlayer ставится в (d, e), dir f.
//  MSG — scrGetMessage(a) в контексте ближайшего объекта b у (c, d) (или objEffector).
var kind = argument0;
if (kind == global.ST_USE)
{
    var ob = argument1;
    if (!object_exists(ob))
    {
        exit;
    }
    var inst = instance_nearest(argument2, argument3, ob);
    if (inst == noone || point_distance(inst.x, inst.y, argument2, argument3) > 32)
    {
        net_log("сюжет: нет " + object_get_name(ob) + " у " + string(argument2) + "," + string(argument3));
        exit;
    }
    var p = global.net_dummy;
    if (p == -4 || !instance_exists(p) || p.object_index != objPlayer)
    {
        net_log("сюжет: нет манекена objPlayer");
        exit;
    }
    var sx = p.x;
    var sy = p.y;
    var sd = p.dir;
    var ss = p.sprite_index;
    var si = p.image_index;
    var sa = p.active;
    var nx = argument4;
    var ny = argument5;
    var nd = argument6;
    with (p)
    {
        x = nx;
        y = ny;
        dir = nd;
        sprite_index = sprPWalkUnarmed;
        image_index = 0;
    }
    global.st_run = 1;
    with (inst)
    {
        event_perform(ev_mouse, ev_global_right_press);
    }
    global.st_run = 0;
    if (instance_exists(p))
    {
        with (p)
        {
            x = sx;
            y = sy;
            dir = sd;
            sprite_index = ss;
            image_index = si;
            active = sa;
        }
    }
    net_log("сюжет: повтор " + object_get_name(ob));
}
else if (kind == global.ST_PICK)
{
    // v1.6: особый подбор хоста за клиента — повторить у себя (маска откроется и в своём сохранении)
    var p2 = global.net_dummy;
    if (p2 == -4 || !instance_exists(p2) || p2.object_index != objPlayer)
    {
        exit;
    }
    var qx = p2.x;
    var qy = p2.y;
    var qd = p2.dir;
    var qs = p2.sprite_index;
    var nx2 = argument4;
    var ny2 = argument5;
    var nd2 = argument6;
    with (p2)
    {
        x = nx2;
        y = ny2;
        dir = nd2;
        sprite_index = sprPWalkUnarmed;
    }
    global.st_run = 1;
    with (p2)
    {
        net_c_pickup_special();
    }
    global.st_run = 0;
    if (instance_exists(p2))
    {
        with (p2)
        {
            x = qx;
            y = qy;
            dir = qd;
            sprite_index = qs;
        }
    }
    net_log("подбор: повтор особого предмета");
}
else if (kind == global.ST_LC)
{
    // v1.4.4: надпись конца уровня — только по команде хоста, одна
    if (!instance_exists(objLevelComplete))
    {
        global.st_lc_allow = 1;
        instance_create(argument1, argument2, objLevelComplete);
        global.st_lc_allow = 0;
        net_log("сюжет: CHAPTER CLEAR");
    }
}
else if (kind == global.ST_MSG)
{
    var ctx = noone;
    if (argument2 != 65535 && object_exists(argument2))
    {
        ctx = instance_nearest(argument3, argument4, argument2);
        if (ctx != noone && point_distance(ctx.x, ctx.y, argument3, argument4) > 32)
        {
            ctx = noone;
        }
    }
    if (ctx == noone && instance_exists(objEffector))
    {
        ctx = instance_find(objEffector, 0);
    }
    if (ctx == noone)
    {
        ctx = id;
    }
    var msg = argument1;
    global.st_replay = 1;
    with (ctx)
    {
        scrGetMessage(msg);
    }
    global.st_replay = 0;
    net_log("сюжет: диалог " + string(argument1));
}
