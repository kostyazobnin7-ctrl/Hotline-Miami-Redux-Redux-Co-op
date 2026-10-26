if (body_speed > 0)
{
    scrMoveSolidOn();
    if (place_free(x + lengthdir_x(body_speed, body_dir), y + lengthdir_y(body_speed, body_dir)))
    {
        x += lengthdir_x(body_speed, body_dir);
        y += lengthdir_y(body_speed, body_dir);
        body_speed = max(0, body_speed - 0.1);
    }
    else
    {
        body_speed = 0;
    }
    scrMoveSolidOff();
}
if (body_speed == 0 && !bled)
{
    bled = 1;
    var len = random(24);
    repeat (2 + floor(random(2)))
    {
        instance_create(((x + lengthdir_x(len, dir)) - 2) + random(4), ((y + lengthdir_y(len, dir)) - 2) + random(4), objBloodPool);
    }
}
