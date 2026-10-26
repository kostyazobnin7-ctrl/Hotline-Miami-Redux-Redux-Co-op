/// net_save_bar_draw(x, y, w, h, u)
// v1.7, КЛИЕНТ (лобби, Draw GUI): «Передача сохранения от хоста: <имя>» и полоса.
// 0 — ждём пакет (полоса медленно ползёт до 30%), 2 — применено (доходит до 100%).
var bx = argument0;
var by = argument1;
var bw = argument2;
var bh = argument3;
var me = global.net_my_pid;
var p;
if (global.sv_state == 2)
{
    p = min(1, 0.3 + ((current_time - global.sv_done_t) / 800));
}
else
{
    p = 0.3 * (1 - (1 / (1 + ((current_time mod 100000) / 3000))));
}
var t = "Передача сохранения от хоста: " + string(global.pl_name[me]);
if (global.sv_state == 2 && p >= 1)
{
    t = "Сохранение хоста получено: " + string(global.pl_name[me]);
}
draw_set_font(fntRestart);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);
draw_set_color(c_black);
draw_text(bx + 1, by - 3, t);
draw_set_color(c_white);
draw_text(bx, by - 4, t);
draw_set_color(make_color_rgb(20, 20, 30));
draw_rectangle(bx, by, bx + bw, by + bh, false);
draw_set_color(make_color_rgb(255, 40, 150));
draw_rectangle(bx, by, bx + (bw * p), by + bh, false);
draw_set_color(make_color_rgb(0, 230, 230));
draw_rectangle(bx, by, bx + bw, by + bh, true);
draw_set_font(fntDate);
draw_set_valign(fa_top);
