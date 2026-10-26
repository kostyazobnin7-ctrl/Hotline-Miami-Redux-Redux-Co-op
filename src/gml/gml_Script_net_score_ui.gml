/// net_score_ui()
// v1.9, Draw GUI на экранах очков (rmScore, rmScoreDetails): итоги уровня по игрокам —
// сбито/убито врагов, казни, падения. Лучший по врагам отмечен звездой.
if (room != rmScore && room != rmScoreDetails)
{
    exit;
}
var gw = display_get_gui_width();
var gh = display_get_gui_height();
var u = gh / 1080;
draw_set_font(fntRestart);
var ts = u * 2;
var lh = string_height("A") * ts * 1.15;
var best = 0;
var bk = 0;
var n = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    n += 1;
    if (global.stat_kills[i] > bk)
    {
        bk = global.stat_kills[i];
        best = i;
    }
}
var bw = 940 * u;
var bh = lh * (n + 2.4);
var bx = gw - bw - (40 * u);
var by = gh - bh - (120 * u);
draw_set_alpha(0.75);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bw, by + bh, false);
draw_set_alpha(1);
draw_set_color(make_color_rgb(255, 40, 150));
draw_rectangle(bx, by, bx + bw, by + bh, true);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var cx0 = bx + (24 * u);
var cx1 = bx + (bw * 0.46);
var cx2 = bx + (bw * 0.63);
var cx3 = bx + (bw * 0.8);
var yy = by + (lh * 0.4);
draw_set_color(make_color_rgb(0, 230, 230));
draw_text_transformed(cx0, yy, "ИТОГИ УРОВНЯ", ts, ts, 0);
draw_text_transformed(cx1, yy, "ВРАГИ", ts, ts, 0);
draw_text_transformed(cx2, yy, "КАЗНИ", ts, ts, 0);
draw_text_transformed(cx3, yy, "ПАДЕН.", ts, ts, 0);
yy += lh * 1.2;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    var nm = "P" + string(i) + " " + net_pl_label(i);
    if (string_length(nm) > 20)
    {
        nm = string_copy(nm, 1, 20);
    }
    if (i == best)
    {
        nm = "* " + nm;
        draw_set_color(make_color_rgb(255, 220, 60));
    }
    else
    {
        draw_set_color(c_white);
    }
    draw_text_transformed(cx0, yy, nm, ts, ts, 0);
    draw_text_transformed(cx1, yy, string(global.stat_kills[i]), ts, ts, 0);
    draw_text_transformed(cx2, yy, string(global.stat_execs[i]), ts, ts, 0);
    draw_text_transformed(cx3, yy, string(global.stat_downs[i]), ts, ts, 0);
    yy += lh;
}
draw_set_color(c_white);
