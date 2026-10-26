if (reload > 0)
{
    reload -= 1;
}
if (light > 3)
{
    light -= 3;
}
global.net_atk = id;
ammo = global.pw_ammo[pid];
var ne0 = instance_number(objEnemy);
if ((global.pin_btn[pid] & global.NET_BTN_ATTACK) != 0 && (current_time - global.pin_t[pid]) <= global.NET_INPUT_STALE_MS)
{
    var spr0 = sprite_index;
    net_c_scrPlayerShoot(0, 0, 0, 0, 0);
    if (sprite_index != spr0)
    {
        global.net_attacks += 1;
    }
}
net_c_scrPlayerIsAttacking(0, 0, 0, 0, 0);
net_c_scrPlayerIsPunching(0, 0, 0, 0, 0);
global.pw_ammo[pid] = ammo;
global.net_atk = -4;
if (instance_number(objEnemy) < ne0)
{
    if (global.pw_wpn[pid] == global.NET_WPN_NONE)
    {
        net_log("P" + string(pid) + " сбил врага ударом (кулак)");
    }
    else
    {
        net_log("P" + string(pid) + " сбил врага ударом (" + global.wpn_name[global.pw_wpn[pid]] + ")");
    }
}
net_avatar_wpn_sync();
