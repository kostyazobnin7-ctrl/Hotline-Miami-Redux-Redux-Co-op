var b = instance_place(x, y, objEBullet);
if (b != -4 && net_damage_allowed(pid, b))
{
    net_avatar_take_hit(b.direction, 1);
    with (b)
    {
        instance_destroy();
    }
}
b = instance_place(x, y, objBullet);
if (b != -4 && b != last_bullet)
{
    last_bullet = b;
    if (net_damage_allowed(pid, b))
    {
        net_avatar_take_hit(b.direction, 1);
    }
    else if (global.NET_FF_KNOCKBACK > 0)
    {
        x += lengthdir_x(global.NET_FF_KNOCKBACK, b.direction);
        y += lengthdir_y(global.NET_FF_KNOCKBACK, b.direction);
    }
}
var e = instance_place(x, y, objExplosion);
if (e != -4 && e != last_explosion)
{
    last_explosion = e;
    if (net_damage_allowed(pid, e))
    {
        net_avatar_take_hit(point_direction(e.x, e.y, x, y), 2);
        if (global.ps_state[pid] == global.NET_PS_DOWNED)
        {
            global.ps_cause[pid] = global.NET_CAUSE_EXPLODED;
        }
    }
}
