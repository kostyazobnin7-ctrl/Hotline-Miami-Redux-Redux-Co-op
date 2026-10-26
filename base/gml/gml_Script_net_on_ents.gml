var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 6)
{
    global.net_drops += 1;
    exit;
}
var u = net_clock_sample(buffer_read(b, buffer_u16));
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (sz < (6 + (n * global.NET_ENT_ENTRY)))
{
    global.net_drops += 1;
    exit;
}
if (rm != room || rm != global.net_host_room)
{
    exit;
}
for (var k = 0; k < n; k += 1)
{
    var eid = buffer_read(b, buffer_u16);
    var kind = buffer_read(b, buffer_u8);
    var ex = buffer_read(b, buffer_s16);
    var ey = buffer_read(b, buffer_s16);
    var ang = (buffer_read(b, buffer_u8) * 360) / 256;
    var spr = buffer_read(b, buffer_u16);
    var fr = buffer_read(b, buffer_u8);
    var fl = buffer_read(b, buffer_u8);
    if (!sprite_exists(spr))
    {
        continue;
    }
    var e = ds_map_find_value(global.ent_map, eid);
    if (is_undefined(e) || !instance_exists(e))
    {
        e = instance_create(ex, ey, objCoopEntity);
        ds_map_replace(global.ent_map, eid, e);
    }
    with (e)
    {
        net_ent_push(u, ex, ey, ang);
    }
    e.kind = kind;
    e.sprite_index = spr;
    e.image_index = fr;
    e.flags = fl;
    e.seen = current_time;
    if (kind == global.NET_ENT_BODY)
    {
        e.depth = 10;
    }
    else if (kind == global.NET_ENT_BULLET)
    {
        e.depth = -5;
    }
    else if (kind == global.NET_ENT_WEAPON)
    {
        e.depth = 5;
    }
    else
    {
        e.depth = -2;
    }
}
