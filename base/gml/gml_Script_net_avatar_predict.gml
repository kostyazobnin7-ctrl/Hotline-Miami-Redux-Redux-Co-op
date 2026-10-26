var me = global.net_my_pid;
if (global.pr_recon)
{
    global.pr_recon = 0;
    var ox = x;
    var oy = y;
    x = global.pr_sx;
    y = global.pr_sy;
    myxspeed = global.pr_svx;
    myyspeed = global.pr_svy;
    var n = ((global.net_in_seq - global.pr_ack) + 256) % 256;
    if (n > 120)
    {
        n = 0;
    }
    for (var k = 1; k <= n; k += 1)
    {
        var s = (global.pr_ack + k) % 256;
        net_avatar_move(global.ih_move[s]);
    }
    var e = point_distance(ox, oy, x, y);
    global.pr_err = e;
    global.pr_err_max = max(global.pr_err_max * 0.995, e);
    if (e < 48)
    {
        draw_offx += (ox - x);
        draw_offy += (oy - y);
    }
    else
    {
        draw_offx = 0;
        draw_offy = 0;
    }
    if (e > 16)
    {
        global.pr_snaps += 1;
    }
}
else
{
    net_avatar_move(global.ih_move[global.net_in_seq]);
}
draw_offx *= 0.8;
draw_offy *= 0.8;
if (abs(draw_offx) < 0.1)
{
    draw_offx = 0;
}
if (abs(draw_offy) < 0.1)
{
    draw_offy = 0;
}
dir = global.pin_aim[me];
sprite_index = net_anim_sprite(global.sn_anim[me]);
image_index = global.sn_frame[me];
if ((global.sn_flags[me] & global.NET_SF_LEFT) != 0)
{
    left = -1;
}
else
{
    left = 1;
}
legs = 1;
