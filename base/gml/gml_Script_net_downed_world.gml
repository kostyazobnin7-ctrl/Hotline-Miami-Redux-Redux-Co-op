if (!global.net_started)
{
    exit;
}
draw_set_font(fntSmallFonts);
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.ps_state[i] != global.NET_PS_DOWNED)
    {
        continue;
    }
    var b = -4;
    if (global.net_mode == global.NET_MODE_HOST)
    {
        b = global.ps_body[i];
    }
    else
    {
        b = global.av[i];
    }
    if (b == -4 || !instance_exists(b))
    {
        continue;
    }
    var t = max(0, global.ps_timer[i]) / 60;
    var s = string_format(t, 1, 1);
    if (i != global.net_my_pid)
    {
        s = global.pl_name[i] + " " + s + "  [E]";
    }
    draw_set_color(c_black);
    draw_text(b.x + 1, b.y - 15, s);
    if (((current_time div 250) % 2) == 0)
    {
        draw_set_color(c_yellow);
    }
    else
    {
        draw_set_color(c_red);
    }
    draw_text(b.x, b.y - 16, s);
    if (global.ps_rev[i] > 0)
    {
        var bw = 24;
        draw_set_color(c_black);
        draw_rectangle(b.x - (bw / 2) - 1, b.y - 14, b.x + (bw / 2) + 1, b.y - 11, false);
        draw_set_color(c_lime);
        draw_rectangle(b.x - (bw / 2), b.y - 13, (b.x - (bw / 2)) + (bw * min(1, global.ps_rev[i] / global.NET_REVIVE_TICKS)), b.y - 12, false);
    }
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
