/// net_crash_ui()
// v2.2, Draw GUI в главном меню: прошлый запуск вылетел — окно с просьбой прислать журнал.
// Закрывается любой клавишей или кликом (crash_show — кадры показа, с 1).
if (!global.crash_show || !instance_exists(objTitle) || global.lb_open)
{
    exit;
}
global.crash_show += 1;
if (global.crash_show > 60 && (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)))
{
    // закрыть можно не раньше чем через секунду: нажатия из заставки окно не трогают
    global.crash_show = 0;
    io_clear();
    exit;
}
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var u = gh / 1080;
draw_set_font(fntRestart);
var ts = u * 1.6;
var lh = string_height("A") * ts * 1.6;
var red = make_color_rgb(255, 70, 90);
var cyan = make_color_rgb(0, 230, 230);
var bw = 1500 * u;
var bh = lh * 6.4;
var bx = (gw - bw) / 2;
var by = (gh - bh) / 2;
draw_set_alpha(0.9);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bw, by + bh, false);
draw_set_alpha(1);
draw_set_color(red);
draw_rectangle(bx, by, bx + bw, by + bh, true);
draw_set_alpha(0.5);
draw_rectangle(bx + (4 * u), by + (4 * u), (bx + bw) - (4 * u), (by + bh) - (4 * u), true);
draw_set_alpha(0.3);
draw_rectangle(bx + 1, by + 1, (bx + bw) - 1, by + (lh * 1.4), false);
draw_set_alpha(1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var cx = bx + (bw / 2);
draw_set_color(c_white);
draw_text_transformed(cx, by + (lh * 0.7), "ПРОИЗОШЛА ОШИБКА", ts * 1.2, ts * 1.2, 0);
draw_text_transformed(cx, by + (lh * 2), "Пожалуйста, отправьте файл разработчику:", ts, ts, 0);
draw_set_color(cyan);
draw_text_transformed(cx, by + (lh * 3), "coop_crash_log.txt", ts * 1.2, ts * 1.2, 0);
draw_set_font(fntDate);
var ds = (24 * u) / max(1, string_height("A"));
draw_set_color(make_color_rgb(200, 200, 200));
draw_text_transformed(cx, by + (lh * 4.1), "%APPDATA%" + chr(92) + "Hotline_Miami_Redux_Redux" + chr(92) + "coop_crash_log.txt", ds, ds, 0);
draw_set_color(make_color_rgb(128, 128, 128));
draw_text_transformed(cx, by + (lh * 5.4), "any key - close", ds, ds, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
