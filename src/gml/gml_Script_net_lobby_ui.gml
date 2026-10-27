var gw = display_get_gui_width();
var gh = display_get_gui_height();
var u = gh / 1080;
var d = global.lb_drawing;
var pink = make_color_rgb(255, 40, 150);
var cyan = make_color_rgb(0, 230, 230);
if (d)
{
    draw_set_font(fntDate);
    global.lb_ts = (30 * u) / max(1, string_height("A"));
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
}
var pw = 1100 * u;
var px = (gw - pw) / 2;
var py = 120 * u;
var rh = 70 * u;
var bw = 330 * u;
var bh = 56 * u;
net_ui_text(gw / 2, py, "HLMR-R  CO-OP", pink, 1, 2);
net_ui_text(gw / 2, py + (60 * u), "[F8] close lobby", 8421504, 1, 0.7);
var ry = py + (140 * u);
if (global.net_mode == global.NET_MODE_OFF)
{
    net_ui_text(px, ry + (bh / 2), "NICK", cyan, 0, 1);
    net_ui_field(px + (260 * u), ry, px + pw, ry + bh, 1);
    ry += rh;
    net_ui_text(px, ry + (bh / 2), "HOST IP", cyan, 0, 1);
    net_ui_field(px + (260 * u), ry, px + (760 * u), ry + bh, 2);
    net_ui_text(px + (800 * u), ry + (bh / 2), "PORT", cyan, 0, 1);
    net_ui_field(px + (940 * u), ry, px + pw, ry + bh, 3);
    ry += (rh * 1.5);
    if (net_ui_button(px, ry, px + bw, ry + bh, "CREATE GAME", 1))
    {
        net_lobby_ui_connect(global.NET_MODE_HOST);
    }
    if (net_ui_button(px + ((pw - bw) / 2), ry, px + ((pw + bw) / 2), ry + bh, "JOIN GAME", 1))
    {
        net_lobby_ui_connect(global.NET_MODE_CLIENT);
    }
    if (net_ui_button((px + pw) - bw, ry, px + pw, ry + bh, "CLOSE", 1))
    {
        net_lobby_ui_close();
    }
    ry += (rh * 1.3);
    if (global.lb_err != "")
    {
        net_ui_text(gw / 2, ry, global.lb_err, 255, 1, 1);
    }
    // v1.4.1: вставка IP хоста из буфера обмена (из Radmin VPN / ZeroTier / мессенджера)
    if (net_ui_button(px + ((pw - (bw * 1.4)) / 2), ry + (rh * 0.6), px + ((pw + (bw * 1.4)) / 2), ry + (rh * 0.6) + bh, "PASTE IP (CTRL+V)", 1))
    {
        if (clipboard_has_text())
        {
            var cb = net_ui_filter(clipboard_get_text(), "0123456789.", 15);
            if (cb != "")
            {
                global.lb_val[2] = cb;
                global.lb_field = 2;
                keyboard_string = cb;
            }
        }
    }
    net_ui_text(gw / 2, ry + (rh * 2), "LAN / Radmin VPN / ZeroTier via IP. Ctrl+V pastes, Ctrl+C copies a field.", 8421504, 1, 0.7);
}
else if (global.net_mode == global.NET_MODE_CLIENT && global.net_conn != global.NET_CONN_CONNECTED)
{
    var s;
    if (global.net_conn == global.NET_CONN_CONNECTING)
    {
        s = "CONNECTING TO " + global.net_host_ip + ":" + string(global.net_port) + "...";
    }
    else if (global.net_conn == global.NET_CONN_REJECTED)
    {
        s = "REJECTED: " + net_ui_reason_text(1, global.net_reject_reason);
    }
    else
    {
        s = net_ui_reason_text(0, global.net_lost_reason);
    }
    var col;
    if (global.net_conn == global.NET_CONN_CONNECTING)
    {
        col = 16777215;
    }
    else
    {
        col = 255;
    }
    net_ui_text(gw / 2, ry + (bh / 2), s, col, 1, 1.2);
    ry += (rh * 2);
    if (net_ui_button((gw - bw) / 2, ry, (gw + bw) / 2, ry + bh, "BACK", 1))
    {
        net_stop();
    }
}
else
{
    var me = global.net_my_pid;
    var s;
    if (global.net_mode == global.NET_MODE_HOST)
    {
        s = "YOU ARE HOST (P1)   port " + string(global.net_local_port);
    }
    else
    {
        s = "YOU ARE P" + string(me) + "   host " + global.net_host_ip + ":" + string(global.net_port);
    }
    net_ui_text(px, ry, s, cyan, 0, 1);
    ry += rh;
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        var canpick = global.net_mode == global.NET_MODE_CLIENT && !global.net_started && i >= 2 && !global.pl_used[i];
        var hover = canpick && point_in_rectangle(global.lb_mx, global.lb_my, px, ry, px + pw, ry + bh);
        if (!d)
        {
            if (hover && global.lb_click)
            {
                global.net_want_slot = i;
                global.net_req_t = 0;
            }
        }
        else
        {
            if (i == me)
            {
                draw_set_color(make_color_rgb(70, 10, 50));
            }
            else if (hover)
            {
                draw_set_color(make_color_rgb(40, 40, 60));
            }
            else
            {
                draw_set_color(make_color_rgb(20, 20, 30));
            }
            draw_rectangle(px, ry, px + pw, ry + bh, false);
            draw_set_color(cyan);
            draw_rectangle(px, ry, px + pw, ry + bh, true);
            net_ui_text(px + (20 * u), ry + (bh / 2), "P" + string(i), pink, 0, 1.2);
            if (global.pl_used[i])
            {
                s = global.pl_name[i];
                if (i == me)
                {
                    s += "  (YOU)";
                }
                // v1.7: скин и передача сохранения
                if (global.pl_skin[i] == 1)
                {
                    s += "  [BIKER]";
                }
                else if (global.pl_skin[i] == 2)
                {
                    s += "  [MARTIN]";
                }
                if (i >= 2 && !global.pl_save_ok[i])
                {
                    s += "  (save...)";
                }
                net_ui_text(px + (120 * u), ry + (bh / 2), s, 16777215, 0, 1);
                if (global.pl_host[i])
                {
                    net_ui_text((px + pw) - (20 * u), ry + (bh / 2), "HOST", cyan, 2, 1);
                }
                else if (global.pl_ready[i])
                {
                    net_ui_text((px + pw) - (20 * u), ry + (bh / 2), "READY", 65280, 2, 1);
                }
                else
                {
                    net_ui_text((px + pw) - (20 * u), ry + (bh / 2), "NOT READY", 4235519, 2, 1);
                }
            }
            else if (canpick)
            {
                if (global.net_want_slot == i)
                {
                    net_ui_text(px + (120 * u), ry + (bh / 2), "requesting...", 65535, 0, 1);
                }
                else
                {
                    net_ui_text(px + (120 * u), ry + (bh / 2), "free  - click to take this slot", 8421504, 0, 1);
                }
            }
            else
            {
                net_ui_text(px + (120 * u), ry + (bh / 2), "free", 8421504, 0, 1);
            }
        }
        ry += rh;
    }
    ry += (rh * 0.3);
    if (global.net_started)
    {
        net_ui_text(gw / 2, ry + (bh / 2), "GAME STARTED. Level sync comes in milestone 2.", 65535, 1, 1);
        ry += rh;
    }
    if (global.net_mode == global.NET_MODE_CLIENT)
    {
        var rd = me > 0 && global.pl_ready[me];
        if (global.net_want_ready != -1)
        {
            rd = global.net_want_ready;
        }
        if (rd)
        {
            s = "NOT READY";
        }
        else
        {
            s = "READY";
        }
        if (net_ui_button(px, ry, px + bw, ry + bh, s, !global.net_started))
        {
            global.net_want_ready = !rd;
            global.net_req_t = 0;
        }
    }
    else if (net_ui_button(px, ry, px + bw, ry + bh, "START", net_host_can_start()))
    {
        if (net_host_start())
        {
            net_lobby_ui_close();
        }
    }
    if (net_ui_button(px + ((pw - bw) / 2), ry, px + ((pw + bw) / 2), ry + bh, "LEAVE", 1))
    {
        net_stop();
    }
    if (net_ui_button((px + pw) - bw, ry, px + pw, ry + bh, "CLOSE", 1))
    {
        net_lobby_ui_close();
    }
    if (d && global.net_mode == global.NET_MODE_HOST && !global.net_started && !net_host_can_start())
    {
        net_ui_text(gw / 2, ry + (rh * 1.2), "waiting for all players to be READY and get the save", 8421504, 1, 0.8);
    }
    // v1.7: скин (все) и настройка выбора маски при перезапуске (хост)
    ry += (rh * 2);
    var sks = "SKIN: JACKET";
    if (global.net_skin_my == 1)
    {
        sks = "SKIN: BIKER";
    }
    else if (global.net_skin_my == 2)
    {
        sks = "SKIN: MARTIN";
    }
    if (net_ui_button(px, ry, px + bw, ry + bh, sks, !global.net_started))
    {
        global.net_skin_my = (global.net_skin_my + 1) mod 3; // v2.0: Джек / Байкер / Мартин
    }
    var mos = "MASK PICK ON RESTART: ON";
    if (!global.net_opt_masks)
    {
        mos = "MASK PICK ON RESTART: OFF";
    }
    if (net_ui_button((px + pw) - (bw * 1.9), ry, px + pw, ry + bh, mos, global.net_mode == global.NET_MODE_HOST))
    {
        global.net_opt_masks = !global.net_opt_masks;
    }
    // v1.7: клиент — полоса передачи сохранения хоста
    if (d && global.net_mode == global.NET_MODE_CLIENT && me > 0)
    {
        net_save_bar_draw(px, ry + (rh * 1.4), pw, bh * 0.5, u);
    }
}
if (d)
{
    draw_set_color(c_white);
    draw_triangle(global.lb_mx, global.lb_my, global.lb_mx + (18 * u), global.lb_my + (10 * u), global.lb_mx + (8 * u), global.lb_my + (20 * u), 0);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
