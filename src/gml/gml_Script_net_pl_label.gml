/// net_pl_label(pid)
// Имя игрока для панелей, с персонажем: «Ник [BIKER]», «Ник [MARTIN]».
var s = global.pl_name[argument0];
if (global.pl_skin[argument0] == 1)
{
    s += " [BIKER]";
}
else if (global.pl_skin[argument0] == 2)
{
    s += " [MARTIN]";
}
return s;
