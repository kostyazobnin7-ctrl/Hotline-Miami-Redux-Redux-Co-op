if (!visible)
{
    exit;
}
var eid = ds_map_find_value(global.ent_map, id);
if (is_undefined(eid))
{
    eid = global.ent_next;
    global.ent_next = (global.ent_next % 65535) + 1;
    ds_map_add(global.ent_map, id, eid);
}
if (global.ent_n >= global.NET_ENT_PER_PACKET)
{
    net_ents_flush();
}
if (global.ent_n == 0)
{
    w = net_packet_begin(global.NET_MSG_ENTS);
    buffer_write(w, buffer_u16, global.net_tick % 65536);
    buffer_write(w, buffer_u16, room);
    global.ent_cpos = buffer_tell(w);
    buffer_write(w, buffer_u8, 0);
}
var w = global.net_wbuf;
var ang = image_angle;
var fl = 0;
if (argument0 == global.NET_ENT_ENEMY && (object_index == objEnemy || object_is_ancestor(object_index, objEnemy)))
{
    ang = direction;
    if (!scrIsSearching(sprite_index))
    {
        fl |= 4;
    }
}
var ys = image_yscale;
if (object_index == objWeaponThrow || object_index == objThrowingWeapon)
{
    ang = angle;
    ys = image_yscale * left;
}
if (image_xscale < 0)
{
    fl |= 1;
}
if (ys < 0)
{
    fl |= 2;
}
buffer_write(w, buffer_u16, eid);
buffer_write(w, buffer_u8, argument0);
buffer_write(w, buffer_s16, clamp(round(x), -32768, 32767));
buffer_write(w, buffer_s16, clamp(round(y), -32768, 32767));
buffer_write(w, buffer_u8, round(((((ang % 360) + 360) % 360) * 256) / 360) % 256);
if (global.ent_ovr_spr >= 0)
{
    buffer_write(w, buffer_u16, global.ent_ovr_spr);
    buffer_write(w, buffer_u8, floor(max(0, global.ent_ovr_frm)) % 256);
}
else
{
    buffer_write(w, buffer_u16, max(0, sprite_index));
    buffer_write(w, buffer_u8, floor(max(0, image_index)) % 256);
}
buffer_write(w, buffer_u8, fl);
global.ent_n += 1;
