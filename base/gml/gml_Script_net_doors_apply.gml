if (!global.door_have)
{
    exit;
}
with (objDoorV)
{
    var a = ds_map_find_value(global.door_map, id);
    if (is_undefined(a))
    {
        a = 0;
    }
    image_angle = a;
    swingspeed = 0;
}
