/// net_draw_sprite_ext(spr, img, x, y, xs, ys, rot, col, alpha)
// v1.8.2: draw_sprite_ext без ошибки «Trying to draw non-existing sprite» (несуществующий
// спрайт просто не рисуется). Подставляется в Draw objPlayerMouse и scrDrawMask.
if (argument0 < 0 || !sprite_exists(argument0))
{
    exit;
}
draw_sprite_ext(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8);
