if (!global.net_started || global.net_mode != global.NET_MODE_HOST)
{
    return 0;
}
var p = ds_map_find_value(global.net_exec_map, id);
if (is_undefined(p))
{
    return 0;
}
return p;
