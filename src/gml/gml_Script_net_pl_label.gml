/// net_pl_label(pid)
// v1.8: имя игрока для панелей, с персонажем: «Ник [BIKER]».
var s = global.pl_name[argument0];
if (net_biker(argument0))
{
    s += " [BIKER]";
}
return s;
