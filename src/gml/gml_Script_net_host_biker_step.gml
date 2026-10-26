/// net_host_biker_step()
// v1.8.1, ХОСТ: хост-Байкер всегда с тесаком (мачете), как objPlayerBiker в оригинале.
// Казни хоста рисуются Байкером (net_biker_exec_draw) — объект казни игры прячется.
if (!net_biker(1))
{
    exit;
}
var p = net_player_inst(1);
if (p == -4)
{
    exit;
}
if (net_player_has_vars(p.object_index))
{
    with (p)
    {
        if (string_pos("sprPWalk", sprite_get_name(sprite_index)) == 1 && sprite_index != sprPWalkMachete)
        {
            sprite_index = sprPWalkMachete;
            ammo = 0;
        }
    }
}
