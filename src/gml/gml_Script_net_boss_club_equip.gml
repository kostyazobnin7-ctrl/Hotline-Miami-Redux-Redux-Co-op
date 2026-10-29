/// net_boss_club_equip(inst)
// v2.2.2 / bug1: после objPClubBoss2 (my_id.sprite_index = sprPWalkClub) — выставить pw_wpn.
// Хост-Jacket и так подхватит через net_wpn_id(); клиентский аватар иначе на следующем
// тике net_avatar_simulate сбросит спрайт в unarmed (pw_wpn оставался NONE).
// Скин Байкера: оружие с пола/казни не берёт (тесак 18) — см. net_wpn_update / NOTES v1.8.
if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    exit;
}
var inst = argument0;
if (inst == -4 || !instance_exists(inst))
{
    exit;
}
var pid = 0;
if (inst.object_index == objCoopAvatar)
{
    pid = inst.pid;
}
else if (net_player_has_vars(inst.object_index))
{
    pid = 1;
}
if (pid < 1 || pid > global.NET_MAX_PLAYERS)
{
    exit;
}
if (net_biker(pid))
{
    // намеренно: Байкер всегда с тесаком; клюшка на полу — для остальных (net_boss_drop_club)
    net_log("P" + string(pid) + " (Байкер): клюшку казни не экипируем");
    exit;
}
global.pw_wpn[pid] = 2;
global.pw_ammo[pid] = 0;
if (inst.object_index == objCoopAvatar)
{
    inst.sprite_index = sprPWalkClub;
    inst.image_index = 0;
    inst.image_speed = 0;
}
net_log("P" + string(pid) + " экипировал клюшку Байкера (казнь)");
