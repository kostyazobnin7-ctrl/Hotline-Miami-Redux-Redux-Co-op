/// net_story_try(px, py, dir, pid)
// ХОСТ. Игрок pid нажал кнопку в точке (px, py): выполнить событие ближайшего сюжетного
// предмета. Для клиента objPlayer хоста на время события ставится на место аватара
// (без оружия, чтобы событие ничего не выбросило), потом всё возвращается.
// Возвращает 1, если предмет сработал (тогда событие уходит клиентам).
var px = argument0;
var py = argument1;
var pdir = argument2;
var own = (argument3 == 1);
// Игрок хоста (objPlayerMouse и т. п.); при ударах/казнях его место занимают объекты
// без dir/active (objEnemyBash...) — тогда предметы не трогаем. Хост убит — манекен.
var p = net_player_inst(1);
if (p != -4 && !net_player_has_vars(p.object_index))
{
    return 0;
}
if (p == -4)
{
    if (own || global.net_dummy == -4 || !instance_exists(global.net_dummy))
    {
        return 0;
    }
    p = global.net_dummy;
}
var lst = ds_list_create();
for (var k = 0; k < global.st_nobj; k += 1)
{
    with (global.st_obj[k])
    {
        if (ds_list_find_index(lst, id) < 0 && (own || distance_to_point(px, py) < global.ST_NEAR_CL))
        {
            ds_list_add(lst, id);
        }
    }
}
if (ds_list_size(lst) == 0)
{
    ds_list_destroy(lst);
    return 0;
}
var sx = p.x;
var sy = p.y;
var sd = p.dir;
var ss = p.sprite_index;
var si = p.image_index;
var sa = p.active;
var res = 0;
for (var k = 0; k < ds_list_size(lst) && !res; k += 1)
{
    var inst = ds_list_find_value(lst, k);
    if (!instance_exists(inst))
    {
        continue;
    }
    if (!own)
    {
        with (p)
        {
            x = px;
            y = py;
            dir = pdir;
            sprite_index = sprPWalkUnarmed;
            image_index = 0;
        }
    }
    var ob = inst.object_index;
    var ix = inst.x;
    var iy = inst.y;
    var ii = inst.image_index;
    var ic = instance_count;
    var dn = global.done;
    var ps = p.sprite_index;
    var pa = p.active;
    global.st_run = 1;
    with (inst)
    {
        event_perform(ev_mouse, ev_global_right_press);
    }
    global.st_run = 0;
    var ch = !instance_exists(inst) || instance_count != ic || global.done != dn;
    if (!ch && inst.image_index != ii)
    {
        ch = 1;
    }
    if (!ch && instance_exists(p) && (p.sprite_index != ps || p.active != pa))
    {
        ch = 1;
    }
    if (!own && instance_exists(p))
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
    if (ch)
    {
        net_story_add(global.ST_USE, ob, ix, iy, px, py, pdir);
        net_log("сюжет: игрок " + string(argument3) + " -> " + object_get_name(ob));
        res = 1;
    }
}
ds_list_destroy(lst);
return res;
