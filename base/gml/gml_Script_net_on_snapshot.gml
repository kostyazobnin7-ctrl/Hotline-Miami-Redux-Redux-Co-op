var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 6)
{
    global.net_drops += 1;
    exit;
}
if (global.net_conn != global.NET_CONN_CONNECTED)
{
    exit;
}
var tick = buffer_read(b, buffer_u16);
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (n > global.NET_MAX_PLAYERS || sz < (6 + (n * global.NET_SNAP_ENTRY)))
{
    global.net_drops += 1;
    exit;
}
if (global.net_snap_tick >= 0)
{
    var d = ((tick - global.net_snap_tick) + 65536) % 65536;
    if (d == 0 || d > 32767)
    {
        exit;
    }
}
global.net_snap_tick = tick;
global.net_snap_bytes = sz;
var u = net_clock_sample(tick);
if (rm != global.net_host_room)
{
    exit;
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.sn_present[i] = 0;
}
for (var k = 0; k < n; k += 1)
{
    var pid = buffer_read(b, buffer_u8);
    if (pid < 1 || pid > global.NET_MAX_PLAYERS)
    {
        buffer_seek(b, buffer_seek_relative, global.NET_SNAP_ENTRY - 1);
        global.net_drops += 1;
    }
    else
    {
        if (global.sn_have[pid])
        {
            global.sn_x0[pid] = global.sn_x1[pid];
            global.sn_y0[pid] = global.sn_y1[pid];
            global.sn_d0[pid] = global.sn_d1[pid];
            global.sn_t0[pid] = global.sn_t1[pid];
        }
        global.sn_x1[pid] = buffer_read(b, buffer_s16);
        global.sn_y1[pid] = buffer_read(b, buffer_s16);
        global.sn_d1[pid] = buffer_read(b, buffer_u16) / 100;
        global.sn_anim[pid] = buffer_read(b, buffer_u16);
        global.sn_frame[pid] = buffer_read(b, buffer_u8);
        global.sn_legdir[pid] = (buffer_read(b, buffer_u8) * 360) / 256;
        global.sn_legframe[pid] = buffer_read(b, buffer_u8);
        global.sn_flags[pid] = buffer_read(b, buffer_u8);
        global.ps_state[pid] = buffer_read(b, buffer_u8);
        global.ps_timer[pid] = buffer_read(b, buffer_u16);
        global.ps_rev[pid] = (buffer_read(b, buffer_u8) * global.NET_REVIVE_TICKS) / 255;
        var ow = global.pw_wpn[pid];
        var nw = buffer_read(b, buffer_u8);
        if (nw > global.NET_WPN_MAX)
        {
            nw = global.NET_WPN_NONE;
        }
        global.pw_wpn[pid] = nw;
        global.pw_ammo[pid] = buffer_read(b, buffer_u8);
        global.sn_ack[pid] = buffer_read(b, buffer_u8);
        global.sn_vx[pid] = buffer_read(b, buffer_s16) / 100;
        global.sn_vy[pid] = buffer_read(b, buffer_s16) / 100;
        if (pid == global.net_my_pid)
        {
            global.pr_sx = global.sn_x1[pid];
            global.pr_sy = global.sn_y1[pid];
            global.pr_svx = global.sn_vx[pid];
            global.pr_svy = global.sn_vy[pid];
            global.pr_ack = global.sn_ack[pid];
            global.pr_recon = 1;
        }
        if (pid == global.net_my_pid && global.sn_have[pid] && ow != nw && global.ps_state[pid] == global.NET_PS_ALIVE)
        {
            if (nw != global.NET_WPN_NONE)
            {
                audio_play_sound(sndPickupWeapon, 0, false);
            }
            else
            {
                audio_play_sound(sndThrow, 0, false);
            }
        }
        global.sn_t1[pid] = current_time;
        if (!global.sn_have[pid])
        {
            global.sn_x0[pid] = global.sn_x1[pid];
            global.sn_y0[pid] = global.sn_y1[pid];
            global.sn_d0[pid] = global.sn_d1[pid];
            global.sn_t0[pid] = current_time - 33;
            global.sn_have[pid] = 1;
            global.sb_n[pid] = 0;
        }
        global.sn_present[pid] = 1;
        net_sb_push(pid, u);
    }
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (!global.sn_present[i])
    {
        global.sn_have[i] = 0;
    }
}
