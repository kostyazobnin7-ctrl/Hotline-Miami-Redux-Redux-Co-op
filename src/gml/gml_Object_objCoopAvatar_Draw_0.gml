x += draw_offx;
y += draw_offy;
if (legs)
{
    draw_sprite_ext(sprLegs, legindex, x + 1, y + 1, 1, 1, legdir, c_black, 0.5);
    draw_sprite_ext(sprLegs, legindex, x, y, 1, 1, legdir, c_white, 1);
}
// v1.7: скин игрока (Джек / Байкер)
var bspr = net_skin_spr(global.pl_skin[pid], sprite_index);
var bimg = image_index;
if (bspr != sprite_index)
{
    bimg = image_index mod max(1, sprite_get_number(bspr));
}
draw_sprite_ext(bspr, bimg, x + 1, y + 1, 1, left, dir, c_black, 0.5);
draw_sprite_ext(bspr, bimg, x, y, 1, left, dir, c_white, 1);
if (global.pl_skin[pid] != 1)
{
    net_mask_draw(pid); // v1.4.4: маска игрока (FLOW); у Байкера — шлем, маску не рисуем
}
var w = global.pw_wpn[pid];
if (sprite_index == sprPWalkThrow && w != global.NET_WPN_NONE && w >= 30)
{
    draw_sprite_ext(sprThrowWeapons, w - 30, x + lengthdir_x(7, dir - 90) + 1, y + 1 + lengthdir_y(7, dir - 90), 1, 1, dir, c_black, 0.5);
    draw_sprite_ext(sprThrowWeapons, w - 30, x + lengthdir_x(7, dir - 90), y + lengthdir_y(7, dir - 90), 1, 1, dir, c_white, 1);
}
if (pid != global.net_my_pid)
{
    draw_set_font(fntDate);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_set_color(c_black);
    draw_text(x + 1, y - 13, global.pl_name[pid]);
    draw_set_color(make_color_rgb(0, 230, 230));
    draw_text(x, y - 14, global.pl_name[pid]);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}
x -= draw_offx;
y -= draw_offy;
