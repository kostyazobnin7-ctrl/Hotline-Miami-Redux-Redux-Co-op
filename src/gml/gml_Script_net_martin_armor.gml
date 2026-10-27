/// net_martin_armor(pid)
// v2.0, ХОСТ: броня Мясника (в игре objPigButcher переживал пулю — energie). Одна пуля за
// этаж поглощается. 1 — попадание поглощено (игрок не падает).
var p = argument0;
if (global.net_mode != global.NET_MODE_HOST || !global.net_started || !net_martin(p) || global.pk_armor[p] <= 0)
{
    return 0;
}
global.pk_armor[p] -= 1;
global.shake = 6;
net_log("P" + string(p) + " (Мартин) броня поглотила пулю");
return 1;
