var p = pid;
var ax = x;
var ay = y;
var old = global.pw_wpn[p];
var oldam = global.pw_ammo[p];
var got = 0;
var best = -4;
var bestd = global.NET_PICK_RADIUS;
with (objWeapon)
{
    var d = point_distance(x, y, ax, ay);
    if (d < bestd)
    {
        best = id;
        bestd = d;
    }
}
if (best != -4)
{
    var g = round(best.image_index);
    var am = best.ammo;
    if (global.hardmode == 1 && !instance_exists(objEffectorInstant))
    {
        var mx;
        with (best)
        {
            mx = scrGunIndexGetMaxAmmo();
        }
        if (am > (mx / 2) && g != 39 && g != 27 && g != 25 && g != 40)
        {
            if (global.maskindex == 17)
            {
                am = round(am / 4);
            }
            else
            {
                am = round(am / 2);
            }
        }
    }
    with (best)
    {
        instance_destroy();
    }
    if (g >= 0 && g <= global.NET_WPN_MAX)
    {
        global.pw_wpn[p] = g;
        global.pw_ammo[p] = am;
        got = 1;
        global.net_pickups += 1;
        audio_play_sound(sndPickupWeapon, 0, false);
        net_log("P" + string(p) + " взял " + global.wpn_name[g] + " (" + string(am) + ")");
    }
}
if (old != global.NET_WPN_NONE)
{
    var t;
    if (old > 30 && old < 39)
    {
        var td = dir + (left * -20);
        t = instance_create(x, y, objThrowingWeapon);
        with (t)
        {
            move_contact_solid(td, 12);
        }
        t.speed = 11;
        t.image_index = old - 30;
    }
    else
    {
        var td = dir;
        t = instance_create(x, y, objWeaponThrow);
        with (t)
        {
            move_contact_solid(td, 12);
        }
        t.speed = 10;
        t.image_index = old;
    }
    t.direction = (dir - 5) + random(10);
    t.ammo = oldam;
    if (!got)
    {
        global.pw_wpn[p] = global.NET_WPN_NONE;
        global.pw_ammo[p] = 0;
    }
    global.net_throws += 1;
    audio_play_sound(sndThrow, 0, false);
    net_log("P" + string(p) + " бросил " + global.wpn_name[old]);
}
if (got || old != global.NET_WPN_NONE)
{
    global.pw_reload[p] = global.NET_PICK_RELOAD;
}
