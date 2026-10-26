if (sprite_index == sprPWalkUnarmed)
{
    global.pw_wpn[pid] = global.NET_WPN_NONE;
    global.pw_ammo[pid] = 0;
}
else if (image_speed == 0)
{
    var g = net_wpn_id();
    if (g != global.NET_WPN_NONE)
    {
        global.pw_wpn[pid] = g;
    }
}
