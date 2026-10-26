/// net_tgt_is_host()
// v1.7: цель врага (net_tgt) — сам хост, а не аватар клиента. Для сцен, где игра
// заменяет objPlayer хоста (добивание Байкера и т. п.).
var t = net_tgt();
if (t == -4 || !instance_exists(t))
{
    return 0;
}
return t.object_index != objCoopAvatar;
