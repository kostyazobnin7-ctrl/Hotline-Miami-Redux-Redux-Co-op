/// net_host_biker_pick()
// v1.8.1, начало scrPlayerPickUp (контекст — игрок хоста). Хост-Байкер оружие не берёт:
// особые находки (маски, буквы...) — как обычно, иначе ПКМ метает нож. 1 — дальше не идти.
if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED || global.net_mode != global.NET_MODE_HOST || !net_biker(1))
{
    return 0;
}
var ic = instance_count;
net_c_pickup_special();
if (instance_count != ic)
{
    net_log("P1 (Байкер) ПКМ: особый подбор");
    return 1;
}
if (global.pk_knives[1] > 0 && reload <= 0)
{
    global.pk_knives[1] -= 1;
    reload = 30;
    var k = instance_create(x, y, objThrowingKnife);
    global.dir = dir;
    with (k)
    {
        move_contact_solid(global.dir, 12);
    }
    k.direction = dir;
    k.image_angle = dir;
    k.speed = 12;
    net_snd(14, 0, 0);
    net_log("P1 (Байкер) метнул нож, осталось " + string(global.pk_knives[1]));
}
return 1;
