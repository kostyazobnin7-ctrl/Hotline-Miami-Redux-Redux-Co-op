var p = pid;
var n = global.sb_n[p];
if (n == 0)
{
    exit;
}
var R = net_clock_render();
var ib = -1;
var ia = -1;
var nb = ((global.sb_h[p] - 1) + global.NET_SB) % global.NET_SB;
for (var j = 0; j < n; j += 1)
{
    var idx = ((global.sb_h[p] - 1 - j) + (global.NET_SB * 2)) % global.NET_SB;
    if (global.sb_t[p, idx] <= R)
    {
        ia = idx;
        break;
    }
    ib = idx;
}
if (ia < 0)
{
    ia = ((global.sb_h[p] - n) + (global.NET_SB * 2)) % global.NET_SB;
    ib = -1;
}
var ic;
if (ib < 0)
{
    if (ia == nb && R > (global.sb_t[p, nb] + 0.5))
    {
        global.ck_under += 1;
    }
    x = global.sb_x[p, ia];
    y = global.sb_y[p, ia];
    dir = global.sb_d[p, ia];
    ic = ia;
}
else
{
    var ta = global.sb_t[p, ia];
    var tb = global.sb_t[p, ib];
    var f = clamp((R - ta) / max(1, tb - ta), 0, 1);
    x = lerp(global.sb_x[p, ia], global.sb_x[p, ib], f);
    y = lerp(global.sb_y[p, ia], global.sb_y[p, ib], f);
    dir = global.sb_d[p, ia] - (angle_difference(global.sb_d[p, ia], global.sb_d[p, ib]) * f);
    if (f < 0.5)
    {
        ic = ia;
    }
    else
    {
        ic = ib;
    }
}
sprite_index = net_anim_sprite(global.sb_anim[p, ic]);
image_index = global.sb_frame[p, ic];
legdir = global.sb_ld[p, ic];
legindex = global.sb_lf[p, ic];
if ((global.sb_fl[p, ic] & global.NET_SF_LEFT) != 0)
{
    left = -1;
}
else
{
    left = 1;
}
legs = (global.sb_fl[p, ic] & global.NET_SF_LEGS) != 0;
