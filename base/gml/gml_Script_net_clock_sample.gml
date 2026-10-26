var t = argument0;
var u;
if (!global.ck_valid)
{
    u = t;
}
else
{
    u = (global.ck_last_u + (((t - (global.ck_last_u % 65536)) + 65536 + 32768) % 65536)) - 32768;
}
if (!global.ck_valid || u > global.ck_last_u)
{
    global.ck_last_u = u;
}
global.ck_valid = 1;
var h = global.ck_h;
global.ck_rt[h] = current_time;
global.ck_ru[h] = u;
global.ck_h = (h + 1) % global.NET_CK_WIN;
global.ck_n = min(global.ck_n + 1, global.NET_CK_WIN);
var n = global.ck_n;
var io = ((global.ck_h - n) + global.NET_CK_WIN) % global.NET_CK_WIN;
var inew = h;
var rate = 0.06;
if ((global.ck_rt[inew] - global.ck_rt[io]) >= 300)
{
    rate = clamp((global.ck_ru[inew] - global.ck_ru[io]) / (global.ck_rt[inew] - global.ck_rt[io]), 0.02, 0.08);
}
var est = -100000000;
for (var k = 0; k < n; k += 1)
{
    var p = global.ck_ru[k] + (rate * (current_time - global.ck_rt[k]));
    if (p > est)
    {
        est = p;
    }
}
var sum = 0;
var lmax = 0;
for (var k = 0; k < n; k += 1)
{
    var late = est - (global.ck_ru[k] + (rate * (current_time - global.ck_rt[k])));
    sum += late;
    lmax = max(lmax, late);
}
global.ck_rate = rate;
global.ck_base_t = current_time;
global.ck_base_u = est;
global.ck_jit = sum / n;
global.ck_late_max = lmax;
var target = clamp(global.NET_SNAPSHOT_EVERY + 1 + (global.ck_jit * 2.5), 3, 30);
if (n < 4)
{
    global.ck_delay = target;
}
else
{
    global.ck_delay += clamp(target - global.ck_delay, -0.2, 0.2);
}
return u;
