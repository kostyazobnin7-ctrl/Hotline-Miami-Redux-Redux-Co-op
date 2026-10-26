var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 4)
{
    global.net_drops += 1;
    exit;
}
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (sz < (4 + (n * 6)))
{
    global.net_drops += 1;
    exit;
}
if (rm != room || rm != global.net_host_room)
{
    exit;
}
ds_map_clear(global.door_map);
for (var k = 0; k < n; k += 1)
{
    var did = buffer_read(b, buffer_u32);
    var ang = buffer_read(b, buffer_s16);
    ds_map_replace(global.door_map, did, ang);
}
global.door_have = 1;
