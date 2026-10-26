var w = global.pw_wpn[argument0];
if (w == global.NET_WPN_NONE || w > global.NET_WPN_MAX)
{
    return "-";
}
if (global.pw_ammo[argument0] > 0 && global.wpn_gun[w])
{
    return global.wpn_name[w] + " " + string(global.pw_ammo[argument0]);
}
return global.wpn_name[w];
