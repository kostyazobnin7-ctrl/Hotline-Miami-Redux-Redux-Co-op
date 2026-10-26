/// net_zone_inst()
// Ближайший к вызывающему объекту живой игрок: objPlayer (у клиента — свой манекен)
// или аватар другого игрока. Для сюжетных зон (диалоги срабатывают от любого игрока).
var p = instance_find(objPlayer, 0);
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    return p;
}
var best = noone;
var bd = 100000000;
var me = 1;
if (global.net_mode == global.NET_MODE_CLIENT)
{
    me = global.net_my_pid;
}
if (p != noone && global.ps_state[me] == global.NET_PS_ALIVE)
{
    best = p;
    bd = point_distance(x, y, p.x, p.y);
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i == me || global.ps_state[i] != global.NET_PS_ALIVE)
    {
        continue;
    }
    var a = global.av[i];
    if (a == -4 || !instance_exists(a))
    {
        continue;
    }
    var d = point_distance(x, y, a.x, a.y);
    if (d < bd)
    {
        bd = d;
        best = a;
    }
}
if (best == noone)
{
    return p;
}
return best;
