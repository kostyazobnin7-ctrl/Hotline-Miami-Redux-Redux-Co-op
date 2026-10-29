/// cam_update()
// Из base/dump + v2.2.2 / bug2: при выходе из DEAD сбрасываем spec_active
// (cam_spectate ставит его в 1 и сам не снимает).
if (global.net_debug && keyboard_check_pressed(vk_f5))
{
    global.cam_split = !global.cam_split;
    net_log("камеры: сплит " + string(global.cam_split));
}
global.cam_nv = 0;
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    exit;
}
if (global.net_mode == global.NET_MODE_CLIENT && room != global.net_host_room)
{
    exit;
}
if (global.cam_room != room)
{
    global.cam_room = room;
    global.cam_split_on = 0;
    global.cam_base_wport = view_wport[0];
    global.cam_base_hport = view_hport[0];
    global.cam_base_wview = view_wview[0];
    global.cam_base_hview = view_hview[0];
}
if (!global.cam_split)
{
    if (global.cam_split_on)
    {
        for (var i = 1; i < 4; i += 1)
        {
            view_visible[i] = false;
        }
        view_xport[0] = 0;
        view_yport[0] = 0;
        view_wport[0] = global.cam_base_wport;
        view_hport[0] = global.cam_base_hport;
        view_wview[0] = global.cam_base_wview;
        view_hview[0] = global.cam_base_hview;
        global.cam_split_on = 0;
    }
    if (global.net_my_pid > 0 && global.ps_state[global.net_my_pid] == global.NET_PS_DEAD)
    {
        cam_spectate(0, global.net_my_pid, 1);
    }
    else
    {
        if (global.net_my_pid > 0 && global.spec_active[global.net_my_pid])
        {
            global.spec_active[global.net_my_pid] = 0;
            global.spec_fade[global.net_my_pid] = 0;
            global.spec_target_of[global.net_my_pid] = 0;
            global.spec_sent_target = -1;
        }
        if (global.net_mode == global.NET_MODE_CLIENT && global.net_my_pid > 0)
        {
            cam_follow(0, global.net_my_pid, 1);
        }
    }
    global.cam_nv = 1;
    global.cam_vpid[0] = global.net_my_pid;
    global.cam_vx[0] = 0;
    global.cam_vy[0] = 0;
    global.cam_vw[0] = global.cam_base_wport;
    global.cam_vh[0] = global.cam_base_hport;
    exit;
}
var n = 0;
var pids;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        pids[n] = i;
        n += 1;
    }
}
if (n < 1)
{
    exit;
}
var gw = global.cam_base_wport;
var gh = global.cam_base_hport;
for (var k = 0; k < 4; k += 1)
{
    if (k >= n)
    {
        view_visible[k] = false;
    }
    else
    {
        var x1, y1, w, h;
        if (n == 1)
        {
            x1 = 0;
            y1 = 0;
            w = gw;
            h = gh;
        }
        else if (n == 2)
        {
            x1 = (gw / 2) * k;
            y1 = 0;
            w = gw / 2;
            h = gh;
        }
        else if (n == 3)
        {
            if (k < 2)
            {
                x1 = (gw / 2) * k;
                y1 = 0;
                w = gw / 2;
                h = gh / 2;
            }
            else
            {
                x1 = 0;
                y1 = gh / 2;
                w = gw;
                h = gh / 2;
            }
        }
        else
        {
            x1 = (gw / 2) * (k % 2);
            y1 = (gh / 2) * (k div 2);
            w = gw / 2;
            h = gh / 2;
        }
        view_visible[k] = true;
        view_xport[k] = x1;
        view_yport[k] = y1;
        view_wport[k] = w;
        view_hport[k] = h;
        view_wview[k] = (global.cam_base_wview * w) / gw;
        view_hview[k] = (global.cam_base_hview * h) / gh;
        if (global.ps_state[pids[k]] == global.NET_PS_DEAD)
        {
            cam_spectate(k, pids[k], pids[k] == global.net_my_pid);
        }
        else
        {
            if (global.spec_active[pids[k]])
            {
                global.spec_active[pids[k]] = 0;
                global.spec_fade[pids[k]] = 0;
                global.spec_target_of[pids[k]] = 0;
            }
            cam_follow(k, pids[k], 0);
        }
        global.cam_vpid[k] = pids[k];
        global.cam_vx[k] = x1;
        global.cam_vy[k] = y1;
        global.cam_vw[k] = w;
        global.cam_vh[k] = h;
    }
}
global.cam_nv = min(n, 4);
global.cam_split_on = 1;
