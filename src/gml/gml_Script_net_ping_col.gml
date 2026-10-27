/// net_ping_col(ms)
// v2.2: цвет пинга: до 80 мс зелёный, до 150 жёлтый, дальше красный; неизвестен — серый.
var r = argument0;
if (r < 0)
{
    return make_color_rgb(140, 140, 140);
}
if (r < 80)
{
    return make_color_rgb(80, 255, 120);
}
if (r < 150)
{
    return make_color_rgb(255, 220, 60);
}
return make_color_rgb(255, 80, 80);
