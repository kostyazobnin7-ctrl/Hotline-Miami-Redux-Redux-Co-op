/// net_zone_x()
// x ближайшего живого игрока (см. net_zone_inst); если игроков нет — далеко от объекта.
var t = net_zone_inst();
if (t == noone)
{
    return x - global.NET_TGT_NONE_DIST;
}
return t.x;
