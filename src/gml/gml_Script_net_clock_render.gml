// v2.1: плавные часы рендера. Цель, пересчитанная по снапшотам, на каждом пакете сдвигается
// на доли тика — раньше картинка от этого мелко дёргалась. Теперь часы идут ровно со скоростью
// хоста и мягко подтягиваются к цели (~0.25 с); большой разрыв (пауза, сворачивание) — сразу.
var tgt = (global.ck_base_u + (global.ck_rate * (current_time - global.ck_base_t))) - global.ck_delay;
if (!global.ck_valid)
{
    return tgt;
}
var dt = current_time - global.ck_rend_t;
if (!global.ck_rend_ok || dt < 0 || dt > 250)
{
    global.ck_rend = tgt;
    global.ck_rend_ok = 1;
}
else if (dt > 0)
{
    var r = global.ck_rend + (global.ck_rate * dt);
    var e = tgt - r;
    if (abs(e) > 8)
    {
        r = tgt;
    }
    else
    {
        r += e * min(1, dt / 250);
    }
    global.ck_rend = r;
}
global.ck_rend_t = current_time;
return global.ck_rend;
