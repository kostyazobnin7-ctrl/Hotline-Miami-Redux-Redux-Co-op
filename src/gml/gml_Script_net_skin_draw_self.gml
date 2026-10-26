/// net_skin_draw_self()
// v1.7, начало Draw objPlayerMouse: хост выбрал скин Байкера — нарисовать себя Байкером.
// 1 — нарисовано (оригинальный Draw пропускается). Особые спрайты (казни...) — оригинал.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED || global.net_skin_my != 1)
{
    return 0;
}
var bs = net_skin_spr(1, sprite_index);
if (bs == sprite_index)
{
    return 0;
}
var bi = image_index mod max(1, sprite_get_number(bs));
draw_sprite_ext(sprLegs, legindex, x + 1, y + 1, 1, 1, legdir, c_black, 0.5);
draw_sprite_ext(sprLegs, legindex, x, y, 1, 1, legdir, c_white, 1);
draw_sprite_ext(bs, bi, x + 1, y + 1, 1, left, dir, c_black, 0.5);
draw_sprite_ext(bs, bi, x, y, 1, left, dir, c_white, 1);
return 1;
