/// net_skin_spr(skin, sprite)
// v1.7: косметический скин. 1 — Байкер: спрайты Джека заменяются спрайтами Байкера
// (ходьба без оружия, ходьба с оружием, удар); прочие (казни, смерть) — как есть.
if (argument0 != 1 || !sprite_exists(argument1))
{
    return argument1;
}
var n = sprite_get_name(argument1);
if (string_pos("sprPAttack", n) == 1)
{
    return sprBoss2AttackCleaver;
}
if (n == "sprPWalkUnarmed")
{
    return sprBoss2Walk;
}
if (string_pos("sprPWalk", n) == 1)
{
    return sprBoss2WalkCleaver;
}
return argument1;
