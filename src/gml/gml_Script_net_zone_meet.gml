/// net_zone_meet(x, y)
// place_meeting(x, y, objPlayer) с учётом аватаров живых игроков.
if (place_meeting(argument0, argument1, objPlayer))
{
    return 1;
}
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return 0;
}
var a = instance_place(argument0, argument1, objCoopAvatar);
if (a == noone)
{
    return 0;
}
return global.ps_state[a.pid] == global.NET_PS_ALIVE;
