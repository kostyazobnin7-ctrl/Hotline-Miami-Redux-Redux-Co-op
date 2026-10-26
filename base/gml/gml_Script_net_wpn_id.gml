var g = scrCurrentWeaponExt(sprite_index);
if (g < 0 || g > global.NET_WPN_MAX)
{
    return global.NET_WPN_NONE;
}
return g;
