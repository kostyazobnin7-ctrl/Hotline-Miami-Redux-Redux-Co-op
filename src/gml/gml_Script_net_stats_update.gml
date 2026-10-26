/// net_stats_update()
// v1.9, ХОСТ, каждый тик: статистика игроков за уровень.
//  Враги: исчезнувший objEnemy (убит или сбит с ног) засчитывается ближайшему живому игроку
//  к его последней позиции (пули и удары у врагов не помечены, кто их нанёс).
//  Казни: у клиентов — net_avatar_execute, у хоста — его игрок сменился объектом казни.
//  Падения — net_player_down. Сброс — при входе в rmChapter (новый уровень).
if (room != global.stat_room)
{
    if (room == rmChapter)
    {
        net_stats_reset();
    }
    global.stat_room = room;
    ds_map_clear(global.stat_en);
}
var seen = ds_map_create();
with (objEnemy)
{
    ds_map_add(seen, id, (round(x) + 32768) * 65536 + (round(y) + 32768));
}
var k = ds_map_find_first(global.stat_en);
while (!is_undefined(k))
{
    if (!ds_map_exists(seen, k))
    {
        var v = ds_map_find_value(global.stat_en, k);
        var ex = (v div 65536) - 32768;
        var ey = (v mod 65536) - 32768;
        var best = 0;
        var bd = 100000000;
        for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
        {
            if (i >= 2 && !global.pl_used[i])
            {
                continue;
            }
            var p = net_player_inst(i);
            if (p == -4)
            {
                continue;
            }
            var d = point_distance(ex, ey, p.x, p.y);
            if (d < bd)
            {
                bd = d;
                best = i;
            }
        }
        if (best > 0)
        {
            global.stat_kills[best] += 1;
        }
    }
    k = ds_map_find_next(global.stat_en, k);
}
ds_map_destroy(global.stat_en);
global.stat_en = seen;
// казнь хоста: его игрок сменился объектом без полей игрока (objPKnifeKill и т. п.)
var hx = 0;
with (objPlayer)
{
    if (id != global.net_dummy && net_exec_owner() < 2 && !net_player_has_vars(object_index) && object_index != objPlayer && string_pos("Kill", object_get_name(object_index)) > 0)
    {
        hx = 1;
    }
}
if (hx && !global.stat_hx)
{
    global.stat_execs[1] += 1;
}
global.stat_hx = hx;
