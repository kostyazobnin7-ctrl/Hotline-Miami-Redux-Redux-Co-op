/// net_biker_exec_draw(exec, skin)
// v1.8, ХОСТ (Draw objCoopNet; аватар во время казни скрыт): объект казни игры (с Джеком) прячется,
// вместо него — спрайт казни Байкера (sprMCKill*) на том же месте, кадр — по прогрессу казни.
// v2.1.1: у многослойных казней (objPBluntKill, objPKnifeKill и др.) net_exec_lspr — это нижний
// слой (лежащий враг), а игрок — sprite_index объекта. Раньше рисовался только нижний слой, и
// Мартин (у него почти все добивания такие) пропадал. Теперь оба слоя, каждый через скин
// (спрайты врага net_skin_spr не меняет).
var e = argument0;
e.visible = false;
var ls = -1;
var lf = 0;
var s = -1;
var f = 0;
var xs = 1;
var ys = 1;
var ang = 0;
var ex = e.x;
var ey = e.y;
with (e)
{
    ls = net_exec_lspr();
    lf = net_exec_lfrm();
    s = sprite_index;
    f = image_index;
    xs = image_xscale;
    ys = image_yscale;
    ang = image_angle;
}
if (ls >= 0 && sprite_exists(ls) && ls != s)
{
    var lb = net_skin_spr(argument1, ls);
    var lbf = lf;
    if (lb != ls)
    {
        lbf = net_skin_frame(ls, lf, lb);
    }
    draw_sprite_ext(lb, lbf, ex + 1, ey + 1, xs, ys, ang, c_black, 0.5);
    draw_sprite_ext(lb, lbf, ex, ey, xs, ys, ang, c_white, 1);
}
if (s < 0 || !sprite_exists(s))
{
    exit;
}
var bs = net_skin_spr(argument1, s);
var bf = f;
if (bs != s)
{
    bf = net_skin_frame(s, f, bs);
}
draw_sprite_ext(bs, bf, ex + 1, ey + 1, xs, ys, ang, c_black, 0.5);
draw_sprite_ext(bs, bf, ex, ey, xs, ys, ang, c_white, 1);
