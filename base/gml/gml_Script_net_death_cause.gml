var b = argument0;
if (b == -4 || !instance_exists(b))
{
    return global.NET_CAUSE_KILLED;
}
if (b.object_index == objPlayerBombDead)
{
    return global.NET_CAUSE_EXPLODED;
}
var nm = sprite_get_name(b.sprite_index);
if (string_pos("Shotgun", nm) > 0 || string_pos("Machinegun", nm) > 0 || string_pos("MachineGun", nm) > 0 || string_pos("Shot", nm) > 0)
{
    return global.NET_CAUSE_SHOT;
}
if (string_pos("Cut", nm) > 0 || string_pos("Knife", nm) > 0)
{
    return global.NET_CAUSE_CUT;
}
if (string_pos("Blunt", nm) > 0)
{
    return global.NET_CAUSE_BEATEN;
}
return global.NET_CAUSE_KILLED;
