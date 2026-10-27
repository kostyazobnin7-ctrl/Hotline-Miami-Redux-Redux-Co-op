var n = ds_list_size(global.pin_q[pid]);
// v2.1: ввод клиента опоздал (джиттер) — не замираем, а повторяем последний шаг «в долг»;
// когда ввод догонит, столько же лишних шагов пропускаем (кнопки из них всё равно читаются).
while (global.pin_debt[pid] > 0 && n > 1)
{
    net_input_pop(pid);
    global.pin_debt[pid] -= 1;
    n -= 1;
}
var guess = 0;
if (n == 0 && global.pin_seq[pid] >= 0 && global.pin_debt[pid] < 3)
{
    guess = 1;
    global.pin_debt[pid] += 1;
}
var steps = 0;
if (n > 0)
{
    steps = 1;
}
if (n > 3)
{
    steps = 2;
}
if (n > 8)
{
    steps = 3;
}
dir = global.pin_aim[pid];
if (image_speed == 0)
{
    if (global.pw_wpn[pid] == global.NET_WPN_NONE)
    {
        sprite_index = sprPWalkUnarmed;
    }
    else
    {
        sprite_index = global.wpn_walk[global.pw_wpn[pid]];
        if (global.pw_wpn[pid] >= 30)
        {
            throwindex = global.pw_wpn[pid] - 30;
        }
    }
}
for (var k = 0; k < steps; k += 1)
{
    net_input_pop(pid);
    dir = global.pin_aim[pid];
    net_avatar_move(global.pin_move[pid]);
}
if (guess)
{
    net_avatar_move(global.pin_move[pid]);
}
