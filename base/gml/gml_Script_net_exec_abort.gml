var p = argument0;
var e = global.pe_exec[p];
global.pe_exec[p] = -4;
if (e != -4)
{
    instance_activate_object(e);
}
if (e != -4 && instance_exists(e))
{
    ds_map_delete(global.net_exec_map, e);
    with (e)
    {
        instance_destroy();
    }
}
if (global.av[p] != -4 && instance_exists(global.av[p]))
{
    global.av[p].visible = true;
}
