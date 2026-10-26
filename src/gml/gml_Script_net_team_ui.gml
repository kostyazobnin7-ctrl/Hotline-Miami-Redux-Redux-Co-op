var inlevel = instance_exists(objCoopAvatar);
if (!inlevel)
{
    exit;
}
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
var puls = 0.5 + (0.5 * sin(current_time / 120));
for (var k = 0; k < global.cam_nv; k += 1)
{
    var pid = global.cam_vpid[k];
    if (pid < 1 || pid > global.NET_MAX_PLAYERS)
    {
        continue;
    }
    if (global.spec_active[pid])
    {
        continue;
    }
    var x1 = global.cam_vx[k] * sx;
    var y1 = global.cam_vy[k] * sy;
    var w = global.cam_vw[k] * sx;
    var h = global.cam_vh[k] * sy;
    var ts = (h / 1080) * 1.6;
    var rowh = (string_height("A") * ts) + (8 * (h / 1080));
    var n = 0;
    for (var j = 1; j <= global.NET_MAX_PLAYERS; j += 1)
    {
        if (j != pid && (j == 1 || global.pl_used[j]))
        {
            n += 1;
        }
    }
    if (global.cam_split_on)
    {
        n += 1;
    }
    if (n == 0)
    {
        continue;
    }
    var px = x1 + (16 * (h / 1080));
    var py = y1 + (h * 0.32);
    draw_set_alpha(0.45);
    draw_set_color(c_black);
    draw_rectangle(px - 6, py - 6, px + (330 * (h / 1080)), py + (n * rowh), false);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_middle);
    for (var j = 1; j <= global.NET_MAX_PLAYERS; j += 1)
    {
        if (j == pid)
        {
            if (!global.cam_split_on)
            {
                continue;
            }
        }
        else if (!(j == 1 || global.pl_used[j]))
        {
            continue;
        }
        var a = py + (rowh / 2);
        var s;
        if (global.ps_state[j] == global.NET_PS_ALIVE)
        {
            draw_set_color(c_lime);
            draw_circle(px + (6 * (h / 1080)), a, 5 * (h / 1080), 0);
            s = net_pl_label(j) + "  " + net_wpn_text(j);
        }
        else if (global.ps_state[j] == global.NET_PS_DOWNED)
        {
            draw_set_color(merge_color(c_yellow, c_red, puls));
            draw_circle(px + (6 * (h / 1080)), a, (4 + (2 * puls)) * (h / 1080), 0);
            s = net_pl_label(j) + "  " + string_format(max(0, global.ps_timer[j]) / 60, 1, 1) + "s";
        }
        else
        {
            draw_set_color(c_red);
            draw_line_width(px + (1 * (h / 1080)), a - (5 * (h / 1080)), px + (11 * (h / 1080)), a + (5 * (h / 1080)), 2);
            draw_line_width(px + (1 * (h / 1080)), a + (5 * (h / 1080)), px + (11 * (h / 1080)), a - (5 * (h / 1080)), 2);
            s = net_pl_label(j) + "  МЕРТВ";
        }
        if (j == pid)
        {
            s = "ВЫ  " + net_wpn_text(j);
        }
        draw_set_color(c_black);
        draw_text_transformed(px + (20 * (h / 1080)) + 2, a + 2, s, ts, ts, 0);
        if (j == pid)
        {
            draw_set_color(c_white);
        }
        else
        {
            draw_set_color(make_color_rgb(0, 230, 230));
        }
        draw_text_transformed(px + (20 * (h / 1080)), a, s, ts, ts, 0);
        py += rowh;
    }
}
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);
