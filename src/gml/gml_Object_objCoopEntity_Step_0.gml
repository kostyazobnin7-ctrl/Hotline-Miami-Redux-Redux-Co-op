if ((current_time - seen) > (global.NET_ENT_TIMEOUT_MS + ((global.ck_delay * 1000) / 60)))
{
    instance_destroy();
    exit;
}
if (ecount == 0)
{
    exit;
}
var R = net_clock_render();
// v2.1.1: исчез с хоста — убрать в тот же момент картинки, когда появилось то, что его сменило
if (miss >= 2 && R >= gone_u)
{
    instance_destroy();
    exit;
}
// новый призрак (труп, выпавшее оружие) показываем, когда до него дошла картинка, а не сразу
visible = R >= (et[ecount - 1] - 0.5);
var a = -1;
for (var k = 0; k < ecount; k += 1)
{
    if (et[k] <= R)
    {
        a = k;
        break;
    }
}
if (a < 0)
{
    a = ecount - 1;
}
if (a == 0)
{
    x = ex[0];
    y = ey[0];
    ang = ea[0];
}
else
{
    var f = clamp((R - et[a]) / max(1, et[a - 1] - et[a]), 0, 1);
    x = lerp(ex[a], ex[a - 1], f);
    y = lerp(ey[a], ey[a - 1], f);
    ang = ea[a] - (angle_difference(ea[a], ea[a - 1]) * f);
}
