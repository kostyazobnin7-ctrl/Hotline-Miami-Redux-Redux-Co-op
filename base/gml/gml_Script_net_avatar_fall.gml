if (argument1 > 1)
{
    sprite_index = sprPBackShotgun;
}
else
{
    sprite_index = sprPBackMachinegun;
}
image_index = 1 + floor(random(4));
image_speed = 0;
body_dir = argument0;
body_speed = 1.5 + random(1) + (argument1 * 0.15);
bled = 0;
dir = body_dir;
myxspeed = 0;
myyspeed = 0;
legs = 0;
net_player_down(pid, id);
