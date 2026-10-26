/// net_zone_y()
// y ближайшего живого игрока (см. net_zone_inst); если игроков нет — далеко от объекта.
var t = net_zone_inst();
if (t == noone)
{
    return y - global.NET_TGT_NONE_DIST;
}
return t.y;
