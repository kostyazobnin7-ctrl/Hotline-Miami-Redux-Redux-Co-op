var a = global.av[2];
if (a == -4 || !instance_exists(a))
{
    exit;
}
var t = instance_nearest(a.x, a.y, argument0);
if (t == -4)
{
    net_log("debug: нет " + object_get_name(argument0) + " в комнате");
    exit;
}
a.x = (t.bbox_left + t.bbox_right) / 2;
a.y = (t.bbox_top + t.bbox_bottom) / 2;
net_log("debug: P2 -> " + object_get_name(t.object_index) + " (" + string(round(a.x)) + "," + string(round(a.y)) + ")");
