/// net_exec_x_new()
// v2.2.1: новая (не из global.net_exec_tmp) казнь net_exec_x — её только что создал аватар.
var r = -4;
with (objPKillChainsawLean)
{
    if (r == -4 && ds_list_find_index(global.net_exec_tmp, id) < 0)
    {
        r = id;
    }
}
with (objPKillBottle2)
{
    if (r == -4 && ds_list_find_index(global.net_exec_tmp, id) < 0)
    {
        r = id;
    }
}
return r;
