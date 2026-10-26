var pid = argument0;
if (global.ps_state[pid] != global.NET_PS_ALIVE)
{
    return -4;
}
var r = -4;
if (pid == 1)
{
    with (objPlayer)
    {
        if (r == -4 && id != global.net_dummy && net_exec_owner() < 2)
        {
            r = id;
        }
    }
    return r;
}
r = global.av[pid];
if (r != -4 && instance_exists(r))
{
    return r;
}
return -4;
