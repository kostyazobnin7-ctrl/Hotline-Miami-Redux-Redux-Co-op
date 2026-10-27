// v1.8: Байкер — тесак и ножи
if (net_biker(argument0))
{
    return "Тесак  ножи " + string(global.pk_knives[argument0]);
}
var arm = "";
if (net_martin(argument0) && global.pk_armor[argument0] > 0)
{
    arm = "  броня"; // v2.0
}
var w = global.pw_wpn[argument0];
if (w == global.NET_WPN_NONE || w > global.NET_WPN_MAX)
{
    return "-" + arm;
}
if (global.pw_ammo[argument0] > 0 && global.wpn_gun[w])
{
    return global.wpn_name[w] + " " + string(global.pw_ammo[argument0]) + arm;
}
return global.wpn_name[w] + arm;
