/// net_hud_player()
// v1.8.1: «objPlayer.поле» в HUD игры. objPlayer. берёт первый экземпляр objPlayer или его
// дочерних объектов — во время казни клиента это мог быть объект казни (objPTigerKill...) без
// ammo -> вылет хоста в scrDrawHUD. Теперь: свой игрок (не казнь клиента, не манекен), иначе
// манекен, иначе как в оригинале.
var r = noone;
with (objPlayer)
{
    if (r == noone && id != global.net_dummy && net_exec_owner() < 2)
    {
        r = id;
    }
}
if (r == noone && global.net_dummy != -4 && instance_exists(global.net_dummy))
{
    r = global.net_dummy;
}
if (r == noone)
{
    return objPlayer;
}
return r;
