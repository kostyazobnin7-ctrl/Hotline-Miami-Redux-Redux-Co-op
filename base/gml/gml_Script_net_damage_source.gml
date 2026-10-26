if (!instance_exists(argument0))
{
    return global.NET_SRC_WORLD;
}
var o = argument0.object_index;
if (o == 98 || object_is_ancestor(o, objPlayer) || o == 1202 || o == 208 || o == 148 || o == 150 || o == 61 || o == 946 || o == 945)
{
    return global.NET_SRC_PLAYER;
}
if (o == 209 || o == 275 || object_is_ancestor(o, objEnemy) || o == 310 || object_is_ancestor(o, objBoss) || o == 316 || object_is_ancestor(o, objMiscEnemy))
{
    return global.NET_SRC_ENEMY;
}
return global.NET_SRC_WORLD;
