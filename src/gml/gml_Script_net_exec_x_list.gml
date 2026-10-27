/// net_exec_x_list()
// v2.2.1: добавить в global.net_exec_tmp уже существующие казни net_exec_x (до казни аватара).
with (objPKillChainsawLean)
{
    ds_list_add(global.net_exec_tmp, id);
}
with (objPKillBottle2)
{
    ds_list_add(global.net_exec_tmp, id);
}
