if (global.ps_state[pid] != global.NET_PS_ALIVE || global.ps_iframes[pid] > 0)
{
    exit;
}
hits += 1;
global.net_hits_taken += 1;
net_log("игрок " + string(pid) + " получил попадание (всего " + string(hits) + ")");
var my_id = instance_create(x, y, objBloodSmoke);
my_id.direction = (argument0 + random(10)) - 5;
my_id.speed = 1;
my_id.image_angle = my_id.direction;
for (var i = 0; i < 3; i += 1)
{
    my_id = instance_create((x - 3) + random(6), (y - 3) + random(6), objBloodDrop);
    my_id.sprite_index = sprBloodSplatSmall;
    my_id.direction = (argument0 - 20) + random(40);
    my_id.image_angle = my_id.direction;
    my_id.speed = 2 + random(3);
}
net_avatar_fall(argument0, argument1);
