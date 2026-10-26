if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    return 0;
}
var t = net_tgt();
if (t == -4)
{
    return 1;
}
if (t.object_index != objCoopAvatar)
{
    for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        if (global.pe_exec[i] != -4)
        {
            instance_deactivate_object(global.pe_exec[i]);
        }
    }
    return 0;
}
if (global.ps_state[t.pid] != global.NET_PS_ALIVE || global.ps_iframes[t.pid] > 0)
{
    return 1;
}
var ws = sprite_index;
var spr;
if (argument0 == 1)
{
    spr = 100;
}
else if (ws == 428 || ws == 427 || ws == 435 || ws == 1343 || ws == 1046)
{
    spr = 95;
}
else
{
    spr = 98;
}
var dir = point_direction(x, y, t.x, t.y);
with (t)
{
    for (var i = 0; i < 6; i += 1)
    {
        my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, dir), (y - 3) + random(6) + lengthdir_y(8, dir), objBloodDrop);
        my_id.sprite_index = sprBloodSplatSmall;
        my_id.direction = (dir - 30) + random(60);
        my_id.image_angle = my_id.direction;
        my_id.speed = 2 + random(4);
    }
    var my_id = instance_create(x, y, objBloodSmoke);
    my_id.direction = dir;
    my_id.speed = 2;
    my_id.image_angle = dir;
    hits += 1;
    global.net_hits_taken += 1;
    net_log("враг ударил игрока " + string(pid) + " в ближнем бою");
    net_avatar_fall_sprite(spr, dir);
}
return 1;
