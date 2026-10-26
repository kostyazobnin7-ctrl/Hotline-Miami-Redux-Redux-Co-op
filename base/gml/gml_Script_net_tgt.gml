if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    return instance_find(objPlayer, 0);
}
var t = ds_map_find_value(global.net_tgt_map, id);
var tuntil = ds_map_find_value(global.net_tgt_until, id);
if (!is_undefined(t) && global.net_tick < tuntil && net_tgt_alive(t))
{
    return t;
}
var best = -4;
var bestd = 100000000;
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
    var d = point_distance(x, y, p.x, p.y);
    if (d < bestd)
    {
        bestd = d;
        best = p;
    }
}
ds_map_replace(global.net_tgt_map, id, best);
ds_map_replace(global.net_tgt_until, id, global.net_tick + global.NET_TGT_REFRESH);
return best;
