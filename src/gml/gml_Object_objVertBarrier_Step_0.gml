// v1.4.3: закрывается, только когда прошли все живые игроки (см. net_barrier_closed)
if (!instance_exists(objPlayer))
{
    exit;
}
solid = net_barrier_closed(1, xlimit);
if (global.done == 1)
{
    solid = 0;
}
