var p = net_exec_owner();
var a = global.av[p];
var bd = other.direction;
with (other)
{
    instance_destroy();
}
if (a != -4 && instance_exists(a) && global.ps_state[p] == global.NET_PS_ALIVE)
{
    a.x = x;
    a.y = y;
    with (a)
    {
        net_avatar_fall(bd, 1);
    }
}
