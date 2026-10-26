if (global.lb_open)
{
    global.lb_drawing = 1;
    net_lobby_ui();
    global.lb_drawing = 0;
}
else if (global.net_mode == global.NET_MODE_OFF && instance_exists(objTitle))
{
    draw_set_font(fntDate);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_set_color(make_color_rgb(0, 230, 230));
    var hs = (28 * display_get_gui_height()) / 1080 / max(1, string_height("A"));
    draw_text_transformed(display_get_gui_width() - 24, display_get_gui_height() - 24, "[F8] CO-OP", hs, hs, 0);
    if (global.crash_prev)
    {
        // v1.9: прошлый запуск вылетел
        draw_set_color(make_color_rgb(255, 80, 80));
        draw_text_transformed(display_get_gui_width() - 24, display_get_gui_height() - 24 - (string_height("A") * hs * 1.3), "Last game crashed: send coop_net_*.log and coop_crash_context.txt (%APPDATA%" + chr(92) + "Hotline_Miami_Redux_Redux)", hs * 0.7, hs * 0.7, 0);
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
if (global.net_mode == global.NET_MODE_OFF)
{
    exit;
}
if (global.net_started && !global.lb_open)
{
    net_team_ui();
    net_downed_ui();
    net_score_ui(); // v1.9
}
if (global.net_mode == global.NET_MODE_CLIENT && global.net_conn == global.NET_CONN_LOST && !global.lb_open)
{
    var msg;
    if (global.net_lost_reason == global.NET_LEAVE_HOST_QUIT)
    {
        msg = "HOST LEFT THE GAME";
    }
    else if (global.net_lost_reason == global.NET_LEAVE_KICKED)
    {
        msg = "YOU WERE REMOVED FROM THE GAME";
    }
    else
    {
        msg = "CONNECTION TO HOST LOST";
    }
    var gw = display_get_gui_width();
    var bw = (string_width(msg) * 2) + 40;
    var bh = (string_height(msg) * 2) + 20;
    draw_set_alpha(0.75);
    draw_set_color(c_black);
    draw_rectangle((gw - bw) / 2, 40, (gw + bw) / 2, 40 + bh, false);
    draw_set_alpha(1);
    draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_transformed(gw / 2, 50, msg, 2, 2, 0);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}
if (!global.net_overlay)
{
    exit;
}
var s;
if (global.net_mode == global.NET_MODE_HOST)
{
    s = "COOP HOST";
}
else
{
    s = "COOP CLIENT";
}
if (global.net_socket < 0)
{
    s += "#PORT NOT OPEN";
}
else
{
    s += ("  port " + string(global.net_local_port) + "  proto " + string(global.NET_PROTO));
    s += ("#out " + string(global.net_rate_out) + " B/s  in " + string(global.net_rate_in) + " B/s  drop " + string(global.net_drops));
    if (global.net_lag > 0 || global.net_jitter > 0)
    {
        s += ("#lag " + string(global.net_lag) + "+" + string(global.net_jitter) + " ms");
    }
    if (global.net_started)
    {
        s += ("#STARTED  room " + room_get_name(room) + "  snap " + string(global.net_snap_bytes) + " B  fps " + string(fps));
        if (global.cam_split)
        {
            s += "#  camera: SPLIT (debug)";
        }
        else
        {
            s += ("#  camera: single, follows P" + string(global.net_my_pid));
        }
        if (global.net_mode == global.NET_MODE_HOST)
        {
            s += ("#  FF blocked " + string(global.net_ff_blocked) + "  hits " + string(global.net_hits_taken) + "  debug shots " + string(global.net_debug_shots));
            if (instance_exists(objPlayer))
            {
                var q = instance_find(objPlayer, 0);
                s += ("#  P1 " + string(round(q.x)) + "," + string(round(q.y)));
            }
        }
        for (var k = 1; k <= global.NET_MAX_PLAYERS; k += 1)
        {
            var q = global.av[k];
            if (q != -4 && instance_exists(q))
            {
                s += ("#  P" + string(k) + " " + string(round(q.x)) + "," + string(round(q.y)) + " dir " + string(round(q.dir)));
            }
        }
        if (global.net_my_pid > 0 && global.spec_active[global.net_my_pid])
        {
            s += ("#  spec: mode " + string(global.spec_mode[global.net_my_pid]) + " target P" + string(global.spec_target[global.net_my_pid]) + " cam " + string(round(global.spec_cx[global.net_my_pid])) + "," + string(round(global.spec_cy[global.net_my_pid])) + " observers " + string(global.ps_observers[1]) + "/" + string(global.ps_observers[2]) + "/" + string(global.ps_observers[3]));
        }
        if (global.net_mode == global.NET_MODE_HOST)
        {
            var ne = instance_number(objEnemy) + instance_number(objMiscEnemy) + instance_number(objBoss);
            var tg = "";
            with (objEnemy)
            {
                var tt = ds_map_find_value(global.net_tgt_map, id);
                if (!is_undefined(tt) && tt != -4 && instance_exists(tt))
                {
                    if (tt.object_index == objCoopAvatar)
                    {
                        tg += (" P" + string(tt.pid));
                    }
                    else
                    {
                        tg += " P1";
                    }
                }
                else
                {
                    tg += " -";
                }
            }
            s += ("#  enemies " + string(ne) + " targets:" + tg);
            if (global.av[2] != -4 && instance_exists(global.av[2]))
            {
                var en = instance_nearest(global.av[2].x, global.av[2].y, objEnemy);
                if (en != -4)
                {
                    s += ("#  near P2: " + object_get_name(en.object_index) + " d " + string(round(point_distance(en.x, en.y, global.av[2].x, global.av[2].y))) + " at " + string(round(en.x)) + "," + string(round(en.y)) + " spr " + sprite_get_name(en.sprite_index) + " alert " + string(en.alert));
                }
            }
        }
        else
        {
            s += ("#  enemy copies " + string(instance_number(objCoopEntity)));
        }
        s += ("#  objPlayer " + string(instance_number(objPlayer)) + " dummies " + string(ds_list_size(global.net_dummy_list)));
        s += "#  weapons:";
        for (var k = 1; k <= global.NET_MAX_PLAYERS; k += 1)
        {
            if (k == 1 || global.pl_used[k])
            {
                s += (" P" + string(k) + "=" + net_wpn_text(k));
            }
        }
        if (global.net_mode == global.NET_MODE_HOST)
        {
            s += ("  floor " + string(instance_number(objWeapon)) + " picks " + string(global.net_pickups) + " throws " + string(global.net_throws) + " attacks " + string(global.net_attacks) + " execs " + string(global.net_execs) + " fx " + string(global.fx_sent));
        }
        if (global.net_mode == global.NET_MODE_CLIENT)
        {
            s += ("#  interp delay " + string_format(global.ck_delay, 1, 1) + "t jit " + string_format(global.ck_jit, 1, 1) + " late " + string_format(global.ck_late_max, 1, 1) + " under " + string(global.ck_under) + "#  predict " + string(global.NET_PREDICT) + " err " + string_format(global.pr_err, 1, 1) + " max " + string_format(global.pr_err_max, 1, 1) + " fx " + string(global.fx_got) + " jumps " + string(global.pr_snaps) + " unacked " + string(((global.net_in_seq - global.pr_ack) + 256) % 256));
        }
        else
        {
            s += "#  input queues:";
            for (var k = 2; k <= global.NET_MAX_PLAYERS; k += 1)
            {
                if (global.pl_used[k])
                {
                    s += (" P" + string(k) + "=" + string(ds_list_size(global.pin_q[k])));
                }
            }
        }
        s += ("#  score " + string(global.myscore) + " draw " + string(global.drawscore) + " combo " + string(global.combo) + " kills " + string(global.kills));
        s += "#  state:";
        for (var k = 1; k <= global.NET_MAX_PLAYERS; k += 1)
        {
            if (!global.pl_used[k])
            {
                continue;
            }
            if (global.ps_state[k] == global.NET_PS_ALIVE)
            {
                s += (" P" + string(k) + "=ALIVE");
            }
            else if (global.ps_state[k] == global.NET_PS_DOWNED)
            {
                s += (" P" + string(k) + "=DOWNED(" + string(global.ps_timer[k]) + "t rev " + string(round(global.ps_rev[k])) + ")");
            }
            else
            {
                s += (" P" + string(k) + "=DEAD");
            }
        }
    }
    for (var i = 0; i < global.net_peer_count; i += 1)
    {
        s += ("#" + global.net_peer_ip[i] + ":" + string(global.net_peer_port[i]));
        if (!global.net_peer_alive[i])
        {
            s += "  NO LINK";
        }
        else if (global.net_peer_rtt[i] < 0)
        {
            s += "  rtt ?";
        }
        else
        {
            s += ("  rtt " + string(round(global.net_peer_rtt[i])) + " ms");
        }
    }
    if (global.net_conn == global.NET_CONN_CONNECTING)
    {
        s += "#CONNECTING...";
    }
    else if (global.net_conn == global.NET_CONN_REJECTED)
    {
        s += "#REJECTED: ";
        if (global.net_reject_reason == global.NET_REJECT_FULL)
        {
            s += "LOBBY FULL";
        }
        else if (global.net_reject_reason == global.NET_REJECT_VERSION)
        {
            s += "VERSION MISMATCH";
        }
        else if (global.net_reject_reason == global.NET_REJECT_STARTED)
        {
            s += "GAME IN PROGRESS";
        }
        else if (global.net_reject_reason == global.NET_REJECT_TIMEOUT)
        {
            s += "NO ANSWER";
        }
        else
        {
            s += string(global.net_reject_reason);
        }
    }
    else if (global.net_conn == global.NET_CONN_LOST)
    {
        s += ("#LOST, reason " + string(global.net_lost_reason));
    }
    else if (global.net_conn == global.NET_CONN_CONNECTED)
    {
        s += ("#ME: P" + string(global.net_my_pid) + "  session " + string(global.net_session));
        for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
        {
            if (global.pl_used[i])
            {
                s += ("#P" + string(i) + " " + global.pl_name[i]);
                if (global.pl_host[i])
                {
                    s += " [HOST]";
                }
                if (i == global.net_my_pid)
                {
                    s += " <";
                }
            }
            else
            {
                s += ("#P" + string(i) + " --");
            }
        }
    }
}
draw_set_font(fntDate);
draw_set_alpha(0.6);
draw_set_color(c_black);
draw_rectangle(4, 4, 8 + string_width(s), 8 + string_height(s), false);
draw_set_alpha(1);
draw_set_color(c_lime);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(6, 6, s);
draw_set_color(c_white);
