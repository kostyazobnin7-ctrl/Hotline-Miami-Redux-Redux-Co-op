/// net_skin_draw_self()
// Начало Draw objPlayerMouse: хост выбрал Байкера — нарисовать себя Байкером.
// 1 — нарисовано (оригинальный Draw пропускается). Особые спрайты (казни...) — оригинал.
// v1.8.1: оригинальный Draw не только рисует, но и ведёт состояние игрока — прицел (dir),
// перезарядку (reload), свет; без этого хост-Байкер не бил и не подбирал (reload застревал).
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED || global.net_skin_my != 1)
{
    return 0;
}
if (persistent == true)
{
    return 0;
}
var bs = net_skin_spr(1, sprite_index);
if (bs == sprite_index)
{
    return 0;
}
if (!(!instance_exists(objEffectorInstant) && instance_exists(objEffector) && objEffector.playeroncareffector == 1))
{
    draw_set_blend_mode(bm_add);
    draw_circle_color(x, y, 48 + random(6) + light, make_color_hsv(0, 0, 30 + (light * 2)), c_black, 0);
    draw_set_blend_mode(bm_normal);
}
if (global.xbox == 1)
{
    dir = scrXboxPlayerLook();
}
else
{
    dir = point_direction(x, y, global.mousex, global.mousey);
}
var bi = image_index mod max(1, sprite_get_number(bs));
draw_sprite_ext(sprBikerLegs, legindex, x + 1, y + 1, 1, 1, legdir, c_black, 0.5);
draw_sprite_ext(sprBikerLegs, legindex, x, y, 1, 1, legdir, c_white, 1);
draw_sprite_ext(bs, bi, x + 1, y + 1, 1, left, dir, c_black, 0.5);
draw_sprite_ext(bs, bi, x, y, 1, left, dir, c_white, 1);
if (reload > 0)
{
    reload -= 1;
}
if (light > 3)
{
    light -= 3;
}
return 1;
