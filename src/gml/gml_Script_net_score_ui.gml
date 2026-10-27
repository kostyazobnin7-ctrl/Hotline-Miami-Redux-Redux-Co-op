/// net_score_ui()
// v1.9, Draw GUI на экранах очков (rmScore, rmScoreDetails): итоги уровня по игрокам —
// сбито/убито врагов, казни, падения.
// v2.1: таблица — шапка, колонка персонажа, ник обрезается по ширине (раньше «[BIKER]» залезал
// на цифры), числа по центру колонок, полосы строк, лучший по врагам подсвечен, строка «ВСЕГО».
if (room != rmScore && room != rmScoreDetails)
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
var best = 0;
var bk = 0;
var n = 0;
var sk = 0;
var se = 0;
var sd = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    n += 1;
    sk += global.stat_kills[i];
    se += global.stat_execs[i];
    sd += global.stat_downs[i];
    if (global.stat_kills[i] > bk)
    {
        bk = global.stat_kills[i];
        best = i;
    }
}
var pink = make_color_rgb(255, 40, 150);
var cyan = make_color_rgb(0, 230, 230);
var gold = make_color_rgb(255, 220, 60);
var pad = 28 * u;
var bw = 1100 * u;
var bh = (rh * 1.3) + (rh * 1.1) + (rh * n) + (rh * 1.15) + (pad * 0.6);
var bx = gw - bw - (40 * u);
var by = gh - bh - (120 * u);
// колонки: ник, персонаж, три числа (x — центр числовых колонок)
var c_name = bx + pad + (36 * u);
var c_hero = bx + (bw * 0.42);
var c_k = bx + (bw * 0.64);
var c_e = bx + (bw * 0.775);
var c_d = bx + (bw * 0.905);
var name_w = (c_hero - c_name) - (20 * u);
// фон и двойная рамка
draw_set_alpha(0.82);
draw_set_color(c_black);
draw_rectangle(bx, by, bx + bw, by + bh, false);
draw_set_alpha(1);
draw_set_color(pink);
draw_rectangle(bx, by, bx + bw, by + bh, true);
draw_set_alpha(0.45);
draw_rectangle(bx + (4 * u), by + (4 * u), (bx + bw) - (4 * u), (by + bh) - (4 * u), true);
// полоса заголовка
var yy = by;
draw_set_alpha(0.35);
draw_rectangle(bx + 1, yy + 1, (bx + bw) - 1, yy + (rh * 1.3), false);
draw_set_alpha(1);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(bx + (bw / 2), yy + (rh * 0.65), "ИТОГИ УРОВНЯ", ts, ts, 0);
yy += rh * 1.3;
// шапка колонок
var ym = yy + (rh * 0.55);
draw_set_color(cyan);
draw_set_halign(fa_left);
draw_text_transformed(c_name, ym, "ИГРОК", ts, ts, 0);
draw_text_transformed(c_hero, ym, "ГЕРОЙ", ts, ts, 0);
draw_set_halign(fa_center);
draw_text_transformed(c_k, ym, "ВРАГИ", ts, ts, 0);
draw_text_transformed(c_e, ym, "КАЗНИ", ts, ts, 0);
draw_text_transformed(c_d, ym, "УПАЛ", ts, ts, 0);
yy += rh * 1.1;
draw_set_color(cyan);
draw_set_alpha(0.6);
draw_line_width(bx + pad, yy, (bx + bw) - pad, yy, max(1, 2 * u));
draw_set_alpha(1);
// строки игроков
var row = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    var ry = yy + (rh * row);
    ym = ry + (rh / 2);
    if (i == best)
    {
        draw_set_color(gold);
        draw_set_alpha(0.16);
        draw_rectangle(bx + pad, ry + 1, (bx + bw) - pad, (ry + rh) - 1, false);
        draw_set_alpha(1);
        var mk = 7 * u;
        draw_rectangle((bx + pad) + (4 * u), ym - mk, (bx + pad) + (4 * u) + (mk * 2), ym + mk, false);
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
    var hero = "JACKET"; // латиница, как в лобби: «Д» в шрифте игры похожа на «А»
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
    var tc = c_white;
    if (i == best)
    {
        tc = gold;
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
    row += 1;
}
yy += rh * n;
// итог по команде
draw_set_color(pink);
draw_set_alpha(0.6);
draw_line_width(bx + pad, yy, (bx + bw) - pad, yy, max(1, 2 * u));
draw_set_alpha(1);
ym = yy + (rh * 0.6);
draw_set_halign(fa_left);
draw_set_color(cyan);
draw_text_transformed(c_name, ym, "ВСЕГО", ts, ts, 0);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text_transformed(c_k, ym, string(sk), ts, ts, 0);
draw_text_transformed(c_e, ym, string(se), ts, ts, 0);
draw_text_transformed(c_d, ym, string(sd), ts, ts, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
