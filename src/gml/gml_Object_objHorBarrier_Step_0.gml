// v1.4.3: закрывается, только когда прошли все живые игроки (см. net_barrier_closed)
if (!instance_exists(objPlayer))
{
    exit;
}
solid = net_barrier_closed(0, ylimit);
if (global.done == 1 && !instance_exists(objBoss))
{
    solid = 0;
}
