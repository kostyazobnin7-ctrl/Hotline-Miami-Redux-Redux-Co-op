var t = argument0;
if (t == -4 || !instance_exists(t))
{
    return 0;
}
if (t.object_index == objCoopAvatar)
{
    return global.ps_state[t.pid] == global.NET_PS_ALIVE && global.pl_used[t.pid];
}
return t != global.net_dummy && global.ps_state[1] == global.NET_PS_ALIVE;
