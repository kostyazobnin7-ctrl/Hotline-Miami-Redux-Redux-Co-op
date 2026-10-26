/// net_barrier_closed(axis, limit)
// v1.4.3: барьер за спиной (objHorBarrier/objVertBarrier). В оригинале он закрывается, как только
// objPlayer прошёл мимо; в коопе так закрывался перед клиентами, если первым шёл хост.
// Теперь закрыт, только если ВСЕ живые игроки уже по ту сторону и никто не стоит в барьере.
// axis 0 — по y (ylimit), 1 — по x (xlimit); limit < 0 — «прошли» в сторону меньших координат.
// limit == 0 — как в оригинале, solid не меняется.
var lim = argument1;
if (lim == 0)
{
    return solid;
}
var n = 0;
var closed = 1;
var me = 1;
var net = global.net_started && global.net_conn == global.NET_CONN_CONNECTED;
if (net && global.net_mode == global.NET_MODE_CLIENT)
{
    me = global.net_my_pid;
}
for (var i = 0; i <= global.NET_MAX_PLAYERS && closed; i += 1)
{
    var p = noone;
    if (i == 0)
    {
        // objPlayer: у хоста — сам хост, у клиента — свой манекен
        if (!net || global.ps_state[me] == global.NET_PS_ALIVE)
        {
            p = instance_find(objPlayer, 0);
        }
    }
    else if (net && i != me && global.ps_state[i] == global.NET_PS_ALIVE)
    {
        p = global.av[i];
        if (p == -4 || !instance_exists(p))
        {
            p = noone;
        }
    }
    if (p == noone)
    {
        continue;
    }
    n += 1;
    var c;
    if (argument0 == 0)
    {
        c = p.y;
    }
    else
    {
        c = p.x;
    }
    var v;
    if (argument0 == 0)
    {
        v = y;
    }
    else
    {
        v = x;
    }
    var past = (lim < 0 && c < v) || (lim > 0 && c > v);
    if (!past || place_meeting(x, y, p))
    {
        closed = 0;
    }
}
if (n == 0)
{
    return solid;
}
return closed;
