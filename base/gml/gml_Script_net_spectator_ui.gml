var x1 = argument0;
var y1 = argument1;
var w = argument2;
var h = argument3;
var pid = argument4;
var cx = x1 + (w / 2);
var pink = make_color_rgb(255, 40, 150);
var cyan = make_color_rgb(0, 230, 230);
var ts = (h / 1080) * 3;
if (ts < 0.8)
{
    ts = 0.8;
}
var a = clamp(global.spec_fade[pid] / global.NET_SPEC_FADE_TICKS, 0, 1);
if (global.net_ev_flash > 0)
{
    a *= (0.75 + (0.25 * sin(current_time / 30)));
}
if (a <= 0)
{
    exit;
}
draw_set_alpha(0.6 * a);
draw_set_color(c_black);
draw_rectangle(x1, y1, x1 + w, y1 + h, false);
var e = min(w, h) * 0.06;
for (var k = 0; k < 4; k += 1)
{
    draw_set_alpha(0.2 * a);
    draw_rectangle(x1, y1, x1 + w, y1 + (e * (k + 1)), false);
    draw_rectangle(x1, (y1 + h) - (e * (k + 1)), x1 + w, y1 + h, false);
    draw_rectangle(x1, y1, x1 + (e * (k + 1)), y1 + h, false);
    draw_rectangle((x1 + w) - (e * (k + 1)), y1, x1 + w, y1 + h, false);
}
draw_set_alpha(0.12 * a);
for (yy = y1; yy < (y1 + h); yy += 4)
{
    draw_line(x1, yy, x1 + w, yy);
}
draw_set_alpha(1);
draw_sprite_ext(sprBloodSplatSmall, 0, x1 + (w * 0.06), y1 + (h * 0.1), ts * 4, ts * 4, 30, make_color_rgb(150, 0, 20), 0.6 * a);
draw_sprite_ext(sprBloodSplatSmall, 1, x1 + (w * 0.94), y1 + (h * 0.9), ts * 5, ts * 5, 200, make_color_rgb(150, 0, 20), 0.6 * a);
draw_sprite_ext(sprBloodSplatSmall, 2, x1 + (w * 0.1), y1 + (h * 0.88), ts * 3, ts * 3, 120, make_color_rgb(120, 0, 20), 0.5 * a);
draw_set_font(fntRestart);
draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_alpha(a);
draw_set_color(cyan);
draw_text_transformed(cx - 3, y1 + (h * 0.12), "ВЫ МЕРТВЫ", ts * 2.2, ts * 2.2, 0);
draw_set_color(pink);
draw_text_transformed(cx + 3, y1 + (h * 0.12), "ВЫ МЕРТВЫ", ts * 2.2, ts * 2.2, 0);
draw_set_color(c_white);
draw_text_transformed(cx, y1 + (h * 0.12), "ВЫ МЕРТВЫ", ts * 2.2, ts * 2.2, 0);
draw_set_color(make_color_rgb(220, 220, 220));
draw_text_transformed(cx, y1 + (h * 0.2), global.pl_name[pid] + " - " + net_cause_text(global.ps_cause[pid]), ts, ts, 0);
var s;
if (global.spec_mode[pid] == 1 || global.spec_target[pid] == 0)
{
    s = "СВОБОДНАЯ КАМЕРА";
}
else
{
    s = "ОБЗОР: " + global.pl_name[global.spec_target[pid]];
}
draw_set_color(cyan);
draw_text_transformed(cx, y1 + (h * 0.26), s, ts * 0.8, ts * 0.8, 0);
var nalive = 0;
var ndown = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i == pid || !(i == 1 || global.pl_used[i]))
    {
        continue;
    }
    if (global.ps_state[i] == global.NET_PS_ALIVE)
    {
        nalive += 1;
    }
    else if (global.ps_state[i] == global.NET_PS_DOWNED)
    {
        ndown += 1;
    }
}
var yy = y1 + (h * 0.72);
if (nalive > 0)
{
    draw_set_color(c_white);
    draw_text_transformed(cx, yy, "Ожидайте возрождения - союзники ещё в бою", ts, ts, 0);
    yy += (22 * ts);
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        if (i != pid && (i == 1 || global.pl_used[i]) && global.ps_state[i] == global.NET_PS_DOWNED)
        {
            draw_set_color(c_yellow);
            draw_text_transformed(cx, yy, "Спасите: " + global.pl_name[i] + " " + string_format(max(0, global.ps_timer[i]) / 60, 1, 1) + "s", ts, ts, 0);
            yy += (22 * ts);
        }
    }
}
else
{
    var sec = 3;
    if (global.net_mode == global.NET_MODE_HOST && global.net_restart_ticks >= 0)
    {
        sec = ceil(global.net_restart_ticks / 60);
    }
    else if (global.net_mode == global.NET_MODE_CLIENT && global.net_restart_sec > 0)
    {
        sec = global.net_restart_sec;
    }
    s = "УРОВЕНЬ ПЕРЕЗАПУСТИТСЯ ЧЕРЕЗ ";
    for (var k = 3; k >= 1; k -= 1)
    {
        if (k <= sec)
        {
            s += (string(k) + "... ");
        }
    }
    draw_set_color(c_red);
    draw_text_transformed(cx, yy, s, ts * 1.2, ts * 1.2, 0);
}
draw_set_color(make_color_rgb(150, 150, 170));
draw_text_transformed(cx, y1 + (h * 0.93), "[Q/E] сменить обзор     [WASD] свободная камера     [Space] режим камеры", ts * 0.7, ts * 0.7, 0);
var rowh = 26 * ts;
var px = (x1 + w) - 16 - (300 * ts);
var py = y1 + (h * 0.34);
draw_set_halign(fa_left);
var puls = 0.5 + (0.5 * sin(current_time / 120));
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (!(i == 1 || global.pl_used[i]))
    {
        continue;
    }
    var obs = i == global.spec_target[pid] && global.spec_mode[pid] == 0;
    draw_set_alpha(0.55 * a);
    draw_set_color(c_black);
    draw_rectangle(px, py, px + (295 * ts), (py + rowh) - 3, false);
    draw_set_alpha(a);
    if (obs)
    {
        draw_set_color(pink);
        draw_rectangle(px, py, px + (295 * ts), (py + rowh) - 3, true);
    }
    if (global.ps_state[i] == global.NET_PS_ALIVE)
    {
        draw_set_color(c_lime);
        draw_circle(px + (10 * ts), py + (rowh / 2), 5 * ts, 0);
        s = global.pl_name[i] + "  оружие: " + net_wpn_text(i);
    }
    else if (global.ps_state[i] == global.NET_PS_DOWNED)
    {
        draw_set_color(merge_color(c_yellow, c_red, puls));
        draw_circle(px + (10 * ts), py + (rowh / 2), (4 + (2 * puls)) * ts, 0);
        s = global.pl_name[i] + "  " + string_format(max(0, global.ps_timer[i]) / 60, 1, 1) + "s  НУЖНА ПОМОЩЬ!";
    }
    else
    {
        draw_set_color(c_red);
        draw_line_width(px + (5 * ts), (py + (rowh / 2)) - (5 * ts), px + (15 * ts), py + (rowh / 2) + (5 * ts), 2 * ts);
        draw_line_width(px + (15 * ts), (py + (rowh / 2)) - (5 * ts), px + (5 * ts), py + (rowh / 2) + (5 * ts), 2 * ts);
        s = global.pl_name[i];
    }
    if (global.ps_state[i] == global.NET_PS_DOWNED)
    {
        draw_set_color(c_yellow);
    }
    else if (global.ps_state[i] == global.NET_PS_DEAD)
    {
        draw_set_color(make_color_rgb(200, 80, 80));
    }
    else
    {
        draw_set_color(c_white);
    }
    draw_text_transformed(px + (22 * ts), py + (rowh / 2), "P" + string(i) + " " + s, ts * 0.7, ts * 0.7, 0);
    py += rowh;
}
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
