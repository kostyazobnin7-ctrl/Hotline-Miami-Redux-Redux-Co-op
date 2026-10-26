var xs = 1;
var ys = 1;
if ((flags & 1) != 0)
{
    xs = -1;
}
if ((flags & 2) != 0)
{
    ys = -1;
}
if ((flags & 4) != 0)
{
    draw_sprite_ext(sprELegs, image_index * 2, x + 1, y + 1, xs, ys, ang, c_black, 0.5);
    draw_sprite_ext(sprELegs, image_index * 2, x, y, xs, ys, ang, c_white, 1);
}
if (kind == global.NET_ENT_WEAPON)
{
    draw_set_blend_mode(bm_add);
    draw_circle_color(x, y, 14, make_color_hsv(0, 0, 30), c_black, 0);
    draw_set_blend_mode(bm_normal);
}
if (kind != global.NET_ENT_BULLET)
{
    draw_sprite_ext(sprite_index, image_index, x + 1, y + 1, xs, ys, ang, c_black, 0.5);
}
draw_sprite_ext(sprite_index, image_index, x, y, xs, ys, ang, c_white, 1);
