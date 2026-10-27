/// net_biker_exec_draw(exec, skin)
// v1.8, ХОСТ (Draw objCoopNet; аватар во время казни скрыт): объект казни игры (с Джеком) прячется,
// вместо него — спрайт казни Байкера (sprMCKill*) на том же месте, кадр — по прогрессу казни.
var e = argument0;
e.visible = false;
var s = -1;
var f = 0;
var xs = 1;
var ys = 1;
var ang = 0;
var ex = e.x;
var ey = e.y;
with (e)
{
    s = net_exec_lspr();
    f = net_exec_lfrm();
    if (s < 0 || !sprite_exists(s))
    {
        // обычная казнь: сам объект и есть спрайт игрока
        s = sprite_index;
        f = image_index;
    }
    xs = image_xscale;
    ys = image_yscale;
    ang = image_angle;
    if (s >= 0 && sprite_exists(s))
    {
        f = (f / max(1, sprite_get_number(s)));
    }
}
if (s < 0 || !sprite_exists(s))
{
    exit;
}
var bs = net_skin_spr(argument1, s);
var bf = floor(f * sprite_get_number(bs)) mod max(1, sprite_get_number(bs));
draw_sprite_ext(bs, bf, ex + 1, ey + 1, xs, ys, ang, c_black, 0.5);
draw_sprite_ext(bs, bf, ex, ey, xs, ys, ang, c_white, 1);
