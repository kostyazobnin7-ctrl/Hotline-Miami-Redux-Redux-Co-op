if (global.net_mode == global.NET_MODE_CLIENT)
{
    return 0;
}
var cat = net_damage_source(argument1);
if (cat == global.NET_SRC_PLAYER && !global.NET_FF_ENABLED)
{
    global.net_ff_blocked += 1;
    return 0;
}
return 1;
