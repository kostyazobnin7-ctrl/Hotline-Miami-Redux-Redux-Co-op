/// net_panther_bite()
// v1.7, в контексте objPanther: укус в сети. Цель — аватар клиента: он падает (как от
// собаки, net_enemy_melee_hit(1)), пантера остаётся и ищет следующую цель.
// Возвращает 1, если укус обработан здесь (не вызывать scrPlayerDiePantherBite).
if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    return 0;
}
var t = net_tgt();
if (t == -4 || !instance_exists(t))
{
    speed = 0;
    return 1;
}
if (t.object_index != objCoopAvatar)
{
    return 0;
}
net_enemy_melee_hit(1);
speed = 0;
return 1;
