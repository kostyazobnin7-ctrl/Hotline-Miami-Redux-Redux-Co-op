var gw = display_get_gui_width();
var gh = display_get_gui_height();
var sx = 1;
var sy = 1;
if (global.cam_base_wport > 0)
{
    sx = gw / global.cam_base_wport;
    sy = gh / global.cam_base_hport;
}
draw_set_font(fntRestart);
var ts = (gh / 1080) * 3;
for (var k = 0; k < global.cam_nv; k += 1)
{
    var pid = global.cam_vpid[k];
    if (pid < 1 || pid > global.NET_MAX_PLAYERS)
    {
        continue;
    }
    var x1 = global.cam_vx[k] * sx;
    var y1 = global.cam_vy[k] * sy;
    var w = global.cam_vw[k] * sx;
    var h = global.cam_vh[k] * sy;
    var cx = x1 + (w / 2);
    var cy = y1 + (h / 2);
    if (global.ps_state[pid] == global.NET_PS_DOWNED)
    {
        var e = min(w, h) * 0.08;
        for (var a = 0; a < 4; a += 1)
        {
            draw_set_alpha(0.18);
            draw_set_color(c_black);
            draw_rectangle(x1, y1, x1 + w, y1 + (e * (a + 1)), false);
            draw_rectangle(x1, (y1 + h) - (e * (a + 1)), x1 + w, y1 + h, false);
            draw_rectangle(x1, y1, x1 + (e * (a + 1)), y1 + h, false);
            draw_rectangle((x1 + w) - (e * (a + 1)), y1, x1 + w, y1 + h, false);
        }
        draw_set_alpha(0.12 + (0.06 * sin(current_time / 150)));
        draw_set_color(c_red);
        draw_rectangle(x1, y1, x1 + w, y1 + h, false);
        draw_set_alpha(1);
        var t = max(0, global.ps_timer[pid]) / 60;
        var s = string_format(t, 1, 1) + "s";
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_black);
        draw_text_transformed(cx + 3, cy + 3, s, ts * 2, ts * 2, 0);
        draw_set_color(c_red);
        draw_text_transformed(cx, cy, s, ts * 2, ts * 2, 0);
        if (global.ps_rev[pid] > 0)
        {
            draw_set_color(c_white);
            draw_text_transformed(cx, cy + (h * 0.14), "ВАС ПОДНИМАЮТ...", ts, ts, 0);
            var bw = w * 0.4;
            draw_set_color(c_black);
            draw_rectangle(cx - (bw / 2) - 2, (cy + (h * 0.2)) - 2, cx + (bw / 2) + 2, cy + (h * 0.2) + ((14 * ts) / 3) + 2, false);
            draw_set_color(c_lime);
            draw_rectangle(cx - (bw / 2), cy + (h * 0.2), (cx - (bw / 2)) + (bw * min(1, global.ps_rev[pid] / global.NET_REVIVE_TICKS)), cy + (h * 0.2) + ((14 * ts) / 3), false);
        }
        else
        {
            draw_set_color(c_white);
            draw_text_transformed(cx, cy + (h * 0.14), "ПОМОЩЬ: [E]", ts, ts, 0);
        }
    }
    else if (global.ps_state[pid] == global.NET_PS_DEAD)
    {
        net_spectator_ui(x1, y1, w, h, pid);
    }
}
var sec = 0;
if (global.net_mode == global.NET_MODE_HOST && global.net_restart_ticks >= 0)
{
    sec = ceil(global.net_restart_ticks / 60);
}
else if (global.net_mode == global.NET_MODE_CLIENT && global.net_restart_sec > 0 && (current_time - global.net_restart_t) < 1500)
{
    sec = global.net_restart_sec;
}
if (global.net_my_pid > 0 && global.ps_state[global.net_my_pid] == global.NET_PS_DEAD && !global.cam_split)
{
    sec = 0;
}
if (sec > 0)
{
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_black);
    draw_text_transformed((gw / 2) + 3, (gh * 0.8) + 3, "УРОВЕНЬ ПЕРЕЗАПУСТИТСЯ ЧЕРЕЗ " + string(sec), ts * 1.3, ts * 1.3, 0);
    draw_set_color(c_red);
    draw_text_transformed(gw / 2, gh * 0.8, "УРОВЕНЬ ПЕРЕЗАПУСТИТСЯ ЧЕРЕЗ " + string(sec), ts * 1.3, ts * 1.3, 0);
}
if (global.net_ev_flash > 0)
{
    draw_set_alpha(global.net_ev_flash / 60);
    draw_set_color(c_white);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    global.net_ev_flash -= 1;
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
