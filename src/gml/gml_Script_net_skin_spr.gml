/// net_skin_spr(skin, sprite)
// Скин 1 — Байкер (v1.8: полный набор). Спрайты Джека -> спрайты Байкера из игры:
//  ходьба (любая) -> sprBoss2WalkCleaver (тесак всегда в руке), удар -> sprBoss2AttackCleaver,
//  лежит/убит sprPBack*/sprPFront* -> sprMCBack*/sprMCFront* (те же позы у Байкера),
//  казни -> sprMCKillCut (клинки), sprMCKillChop (топор/тесак), sprMCKillStomp (остальное).
// Собственные спрайты Байкера (sprBiker*, sprMC*, sprBoss2*) — как есть.
if (argument0 != 1 || !sprite_exists(argument1))
{
    return argument1;
}
var n = sprite_get_name(argument1);
if (string_pos("sprP", n) != 1)
{
    return argument1;
}
if (string_pos("sprPAttack", n) == 1)
{
    return sprBoss2AttackCleaver;
}
if (string_pos("sprPWalk", n) == 1)
{
    return sprBoss2WalkCleaver;
}
if (string_pos("sprPBack", n) == 1 || string_pos("sprPFront", n) == 1)
{
    var mc = asset_get_index("sprMC" + string_delete(n, 1, 4));
    if (mc >= 0 && sprite_exists(mc))
    {
        return mc;
    }
    if (string_pos("sprPFront", n) == 1)
    {
        return sprMCFrontBlunt;
    }
    return sprMCBackBlunt;
}
if (string_pos("Machete", n) > 0 || string_pos("Knife", n) > 0 || string_pos("Sword", n) > 0 || string_pos("Scissor", n) > 0 || string_pos("Cut", n) > 0 || string_pos("Bottle", n) > 0 || string_pos("Throat", n) > 0)
{
    return sprMCKillCut;
}
if (string_pos("Axe", n) > 0 || string_pos("Chop", n) > 0 || string_pos("Cleaver", n) > 0 || string_pos("Chainsaw", n) > 0)
{
    return sprMCKillChop;
}
if (string_pos("Kill", n) > 0 || string_pos("Execute", n) > 0 || string_pos("Bash", n) > 0 || string_pos("Stomp", n) > 0 || string_pos("Snap", n) > 0 || string_pos("Blunt", n) > 0)
{
    return sprMCKillStomp;
}
return argument1;
