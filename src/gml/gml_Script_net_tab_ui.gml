/// net_tab_ui()
// v2.2, Draw GUI: пока зажат Tab — таблица игроков по центру экрана: ник, персонаж, враги,
// казни, падения (те же счётчики, что в итогах уровня, клиентам приходят в LOOK) и пинг.
// Draw GUI рисуется один раз на окно, поверх всех видов — в сплите тоже одна таблица на экран,
// а каждый игрок видит свою в своём окне.
if (!keyboard_check(vk_tab) || !global.net_started || global.lb_open)
{
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTED || room == rmScore || room == rmScoreDetails)
{
    exit;
}
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var u = gh / 1080;
draw_set_font(fntRestart);
var ts = u * 2;
var th = string_height("A") * ts;
var rh = th * 1.5;
var n = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i == 1 || global.pl_used[i])
    {
        n += 1;
    }
}
var pink = make_color_rgb(255, 40, 150);
var cyan = make_color_rgb(0, 230, 230);
var pad = 28 * u;
var bw = 1300 * u;
var bh = (rh * 1.3) + (rh * 1.1) + (rh * n) + (pad * 0.6);
var bx = (gw - bw) / 2;
var by = (gh - bh) / 2;
var c_name = bx + pad + (12 * u);
var c_hero = bx + (bw * 0.36);
var c_k = bx + (bw * 0.555);
var c_e = bx + (bw * 0.665);
var c_d = bx + (bw * 0.775);
var c_p = bx + (bw * 0.9);
var name_w = (c_hero - c_name) - (20 * u);
draw_set_alpha(0.86);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bw, by + bh, false);
draw_set_alpha(1);
draw_set_color(pink);
draw_rectangle(bx, by, bx + bw, by + bh, true);
draw_set_alpha(0.45);
draw_rectangle(bx + (4 * u), by + (4 * u), (bx + bw) - (4 * u), (by + bh) - (4 * u), true);
var yy = by;
draw_set_alpha(0.35);
draw_rectangle(bx + 1, yy + 1, (bx + bw) - 1, yy + (rh * 1.3), false);
draw_set_alpha(1);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(bx + (bw / 2), yy + (rh * 0.65), "ИГРОКИ", ts, ts, 0);
yy += rh * 1.3;
var ym = yy + (rh * 0.55);
draw_set_color(cyan);
draw_set_halign(fa_left);
draw_text_transformed(c_name, ym, "ИГРОК", ts, ts, 0);
draw_text_transformed(c_hero, ym, "ГЕРОЙ", ts, ts, 0);
draw_set_halign(fa_center);
draw_text_transformed(c_k, ym, "ВРАГИ", ts, ts, 0);
draw_text_transformed(c_e, ym, "КАЗНИ", ts, ts, 0);
draw_text_transformed(c_d, ym, "УПАЛ", ts, ts, 0);
draw_text_transformed(c_p, ym, "PING", ts, ts, 0);
yy += rh * 1.1;
draw_set_alpha(0.6);
draw_line_width(bx + pad, yy, (bx + bw) - pad, yy, max(1, 2 * u));
draw_set_alpha(1);
var row = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    var ry = yy + (rh * row);
    ym = ry + (rh / 2);
    if (i == global.net_my_pid)
    {
        draw_set_color(pink);
        draw_set_alpha(0.18);
        draw_rectangle(bx + pad, ry + 1, (bx + bw) - pad, (ry + rh) - 1, false);
        draw_set_alpha(1);
    }
    else if ((row % 2) == 1)
    {
        draw_set_color(c_white);
        draw_set_alpha(0.06);
        draw_rectangle(bx + pad, ry + 1, (bx + bw) - pad, (ry + rh) - 1, false);
        draw_set_alpha(1);
    }
    var nm = global.pl_name[i];
    if (nm == "")
    {
        nm = "Player";
    }
    nm = "P" + string(i) + " " + nm;
    if ((string_width(nm) * ts) > name_w)
    {
        while (string_length(nm) > 1 && (string_width(nm + "..") * ts) > name_w)
        {
            nm = string_copy(nm, 1, string_length(nm) - 1);
        }
        nm += "..";
    }
    // состояние: лежит — оранжевый, погиб — серый
    var tc = c_white;
    if (global.ps_state[i] == global.NET_PS_DOWNED)
    {
        tc = make_color_rgb(255, 150, 40);
    }
    else if (global.ps_state[i] == global.NET_PS_DEAD)
    {
        tc = make_color_rgb(120, 120, 120);
    }
    var hero = "JACKET";
    var hc = make_color_rgb(200, 200, 200);
    if (global.pl_skin[i] == 1)
    {
        hero = "BIKER";
        hc = make_color_rgb(255, 150, 40);
    }
    else if (global.pl_skin[i] == 2)
    {
        hero = "MARTIN";
        hc = make_color_rgb(255, 110, 170);
    }
    draw_set_halign(fa_left);
    draw_set_color(tc);
    draw_text_transformed(c_name, ym, nm, ts, ts, 0);
    draw_set_color(hc);
    draw_text_transformed(c_hero, ym, hero, ts, ts, 0);
    draw_set_halign(fa_center);
    draw_set_color(tc);
    draw_text_transformed(c_k, ym, string(global.stat_kills[i]), ts, ts, 0);
    draw_text_transformed(c_e, ym, string(global.stat_execs[i]), ts, ts, 0);
    draw_text_transformed(c_d, ym, string(global.stat_downs[i]), ts, ts, 0);
    var rt = net_pl_rtt(i);
    var rs = "--";
    if (global.net_mode == global.NET_MODE_HOST && i == 1)
    {
        rs = "HOST";
    }
    else if (rt >= 0)
    {
        rs = string(rt);
    }
    draw_set_color(net_ping_col(rt));
    if (rs == "HOST")
    {
        draw_set_color(cyan);
    }
    draw_text_transformed(c_p, ym, rs, ts, ts, 0);
    row += 1;
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
