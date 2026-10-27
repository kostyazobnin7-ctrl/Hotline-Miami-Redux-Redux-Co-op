if (!global.door_have)
{
    exit;
}
with (objDoorV)
{
    var a = ds_map_find_value(global.door_map, ((round(x) + 32768) * 65536) + (round(y) + 32768));
    if (is_undefined(a))
    {
        a = 0;
    }
    // v2.1.1: плавно к углу хоста (пакеты 30 раз в секунду, без рывков между ними)
    var dd = angle_difference(a, image_angle);
    if (abs(dd) < 1.5)
    {
        image_angle = a;
    }
    else
    {
        image_angle += dd * 0.55;
    }
    swingspeed = 0;
}
