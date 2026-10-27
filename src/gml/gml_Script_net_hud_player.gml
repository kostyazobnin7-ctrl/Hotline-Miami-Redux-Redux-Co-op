/// net_hud_player()
// «objPlayer.поле» в коде игры (v1.8.1 HUD, v2.0.1 весь код). objPlayer. берёт первый экземпляр
// objPlayer или его дочерних объектов — это бывал объект казни (objPTigerKill, objPMacheteKill,
// objPAttackThroat...) без полей игрока -> вылеты. Теперь:
//  1) сначала настоящий игрок (objPlayerMouse и т. п., net_player_has_vars), не манекен;
//  2) иначе любой объект семейства, кроме манекена и казней клиентов (своя казнь хоста);
//  3) иначе манекен; иначе как в оригинале.
// v2.0.2: результат кэшируется на кадр (вызывается ~1500 мест; без кэша — просадка FPS).
var c = global.hp_cache;
if (global.hp_cache_f == global.hp_frame && c != noone && instance_exists(c))
{
    return c;
}
var r = noone;
var r2 = noone;
with (objPlayer)
{
    if (id != global.net_dummy && net_exec_owner() < 2)
    {
        if (r == noone && net_player_has_vars(object_index))
        {
            r = id;
        }
        if (r2 == noone)
        {
            r2 = id;
        }
    }
}
if (r == noone)
{
    r = r2;
}
if (r == noone && global.net_dummy != -4 && instance_exists(global.net_dummy))
{
    r = global.net_dummy;
}
if (r == noone)
{
    return objPlayer;
}
// кэшируем только настоящего игрока: объект казни живёт недолго
if (net_player_has_vars(r.object_index))
{
    global.hp_cache = r;
    global.hp_cache_f = global.hp_frame;
}
return r;
