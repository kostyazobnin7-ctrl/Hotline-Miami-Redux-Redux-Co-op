/// net_skin_spr_martin(sprite)
// v2.0: скин 2 — Мартин Браун (Мясник-свинья, objPigButcher из игры). Спрайты Джека ->
// спрайты Мясника: ходьба/удар с тем же оружием (sprPigButcherWalk*/Attack*), без оружия —
// sprPigButcher/sprPigButcherAttack, лежит/убит — sprPigDeadBlunt/sprPigDeadShot,
// казни — sprPigButcherKill (клинки, оружие) или sprPigButcherStomp (добивание).
var s = argument0;
var n = sprite_get_name(s);
if (string_pos("sprPig", n) == 1 || string_pos("sprP", n) != 1)
{
    return s;
}
if (n == "sprPWalkUnarmed")
{
    return sprPigButcher;
}
if (n == "sprPAttackPunch")
{
    return sprPigButcherAttack;
}
var w = "";
var walk = string_pos("sprPWalk", n) == 1;
var atk = string_pos("sprPAttack", n) == 1;
if (walk)
{
    w = string_delete(n, 1, 8);
}
else if (atk)
{
    w = string_delete(n, 1, 10);
}
if (walk || atk)
{
    if (w == "Kalashnikov")
    {
        w = "AK";
    }
    if (w == "NightStick")
    {
        w = "Stick";
    }
    var r = -1;
    if (walk)
    {
        r = asset_get_index("sprPigButcherWalk" + w);
    }
    else
    {
        r = asset_get_index("sprPigButcherAttack" + w);
        if (r < 0)
        {
            r = asset_get_index("sprPigButcherAttack" + w + "1");
        }
    }
    if (r >= 0 && sprite_exists(r))
    {
        return r;
    }
    if (walk)
    {
        return sprPigButcherWalkClub;
    }
    return sprPigButcherAttackClub;
}
if (string_pos("sprPBack", n) == 1 || string_pos("sprPFront", n) == 1)
{
    if (string_pos("Shotgun", n) > 0 || string_pos("Machinegun", n) > 0)
    {
        return sprPigDeadShot;
    }
    return sprPigDeadBlunt;
}
if (string_pos("Stomp", n) > 0 || string_pos("Bash", n) > 0 || string_pos("Blunt", n) > 0 || string_pos("Snap", n) > 0)
{
    return sprPigButcherStomp;
}
if (string_pos("Kill", n) > 0 || string_pos("Execute", n) > 0 || string_pos("Throat", n) > 0)
{
    return sprPigButcherKill;
}
return s;
