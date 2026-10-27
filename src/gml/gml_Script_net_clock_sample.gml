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
// v2.1: скорость часов хоста сглаживаем — оценка по окну в ~1 с шумная
if (n < 4)
{
    global.ck_rate = rate;
}
else
{
    global.ck_rate = lerp(global.ck_rate, rate, 0.1);
}
rate = global.ck_rate;
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
global.ck_base_t = current_time;
global.ck_base_u = est;
global.ck_jit = sum / n;
global.ck_late_max = lmax;
// v2.1: запас задержки считаем от самого редкого потока (враги), иначе они «догоняют» рывками.
// Растёт быстро (пришёл скачок пинга), уменьшается медленно — без ускорений и замедлений картинки.
var target = clamp(max(global.NET_SNAPSHOT_EVERY, global.NET_ENTS_EVERY) + 1.5 + (global.ck_jit * 2.5), 3.5, 30);
if (n < 4)
{
    global.ck_delay = target;
}
else
{
    global.ck_delay += clamp(target - global.ck_delay, -0.03, 0.25);
}
return u;
