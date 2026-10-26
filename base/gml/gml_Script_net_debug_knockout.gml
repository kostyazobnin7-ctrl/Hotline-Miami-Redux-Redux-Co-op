var a;
if (argument0 == 1)
{
    a = net_player_inst(1);
}
else
{
    a = global.av[argument0];
}
if (a == -4 || !instance_exists(a))
{
    exit;
}
var k = instance_create(a.x + lengthdir_x(6, a.dir), a.y + lengthdir_y(6, a.dir), objKnockedOut);
k.type = 278;
k.direction = a.dir;
k.angle = a.dir;
k.image_angle = a.dir;
k.speed = 0;
k.reload = 600;
net_log("debug: objKnockedOut под P" + string(argument0) + " (" + sprite_get_name(k.sprite_index) + ")");
