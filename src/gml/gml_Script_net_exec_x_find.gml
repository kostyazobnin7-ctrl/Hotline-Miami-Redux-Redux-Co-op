/// net_exec_x_find(owner)
// v2.2.1, ХОСТ: экземпляр «внешней» казни (net_exec_x) владельца owner (1 — хост, т. е. без
// записи в net_exec_map; 2..4 — клиент). -4 — нет.
var want = argument0;
var r = -4;
with (objPKillChainsawLean)
{
    if (r == -4 && max(1, net_exec_owner()) == want)
    {
        r = id;
    }
}
with (objPKillBottle2)
{
    if (r == -4 && max(1, net_exec_owner()) == want)
    {
        r = id;
    }
}
return r;
