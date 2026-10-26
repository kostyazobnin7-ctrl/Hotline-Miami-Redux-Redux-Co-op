/// net_on_props(buf, size, ip, port)
// КЛИЕНТ: сюжетные предметы хоста. Свой ближайший предмет того же объекта двигается
// на место хоста, недостающий создаётся. Лишние не удаляются: их убирает повтор
// события (net_story_apply), а у хоста часть объектов может быть просто выключена.
var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 4)
{
    global.net_drops += 1;
    exit;
}
if (global.net_mode != global.NET_MODE_CLIENT)
{
    exit;
}
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (rm != room || rm != global.net_host_room)
{
    exit;
}
var used = ds_list_create();
for (var j = 0; j < n && (buffer_tell(b) + 6) <= sz; j += 1)
{
    var ob = buffer_read(b, buffer_u16);
    var px = buffer_read(b, buffer_s16);
    var py = buffer_read(b, buffer_s16);
    if (!object_exists(ob))
    {
        continue;
    }
    var best = noone;
    var bd = 64;
    with (ob)
    {
        if (object_index == ob && ds_list_find_index(used, id) < 0)
        {
            var d = point_distance(x, y, px, py);
            if (d < bd)
            {
                bd = d;
                best = id;
            }
        }
    }
    if (best == noone)
    {
        best = instance_create(px, py, ob);
        net_log("сюжет: создан " + object_get_name(ob));
    }
    with (best)
    {
        x = px;
        y = py;
        speed = 0;
    }
    ds_list_add(used, best);
}
ds_list_destroy(used);
