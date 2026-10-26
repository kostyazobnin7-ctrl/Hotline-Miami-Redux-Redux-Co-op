/// net_boss_drop_club(x, y)
// v1.7, ХОСТ: после добивания Байкера рядом остаётся его клюшка (оружие 2) — её может взять
// любой игрок (у клиентов это обычное оружие на полу, приходит как сущность).
if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    exit;
}
var w = instance_create(argument0 + 12, argument1 + 12, objWeapon);
w.image_index = 2;
w.image_speed = 0;
w.ammo = 0;
net_log("Байкер: клюшка на полу");
