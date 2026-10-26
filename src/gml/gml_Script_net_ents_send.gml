global.ent_n = 0;
with (objEnemy)
{
    net_ents_add(global.NET_ENT_ENEMY);
}
with (objMiscEnemy)
{
    net_ents_add(global.NET_ENT_ENEMY);
}
with (objBoss)
{
    net_ents_add(global.NET_ENT_ENEMY);
}
with (objKnockedOut)
{
    net_ents_add(global.NET_ENT_BODY);
}
with (objECrawl)
{
    net_ents_add(global.NET_ENT_BODY);
}
with (objDeadBody)
{
    net_ents_add(global.NET_ENT_BODY);
}
with (objBodyPart)
{
    net_ents_add(global.NET_ENT_BODY);
}
with (objEBullet)
{
    net_ents_add(global.NET_ENT_BULLET);
}
with (objBullet)
{
    net_ents_add(global.NET_ENT_BULLET);
}
with (objWeapon)
{
    net_ents_add(global.NET_ENT_WEAPON);
}
with (objWeaponThrow)
{
    net_ents_add(global.NET_ENT_WEAPON);
}
with (objThrowingWeapon)
{
    net_ents_add(global.NET_ENT_WEAPON);
}
with (objPlayer)
{
    global.ent_ovr_spr = net_exec_lspr();
    if (net_exec_owner() >= 2 && net_biker(net_exec_owner()) && (global.ent_ovr_spr < 0 || !sprite_exists(global.ent_ovr_spr)))
    {
        // v1.8: обычная казнь Байкера — объект казни и есть спрайт игрока (у клиента подменится)
        global.ent_ovr_spr = sprite_index;
    }
    if (global.ent_ovr_spr >= 0 && sprite_exists(global.ent_ovr_spr) && net_exec_owner() >= 2 && net_biker(net_exec_owner()))
    {
        // v1.8: казнь Байкера — его спрайт (sprMCKill*), кадр в пределах его анимации
        var bs = net_skin_spr(1, global.ent_ovr_spr);
        var bf0 = net_exec_lfrm();
        if (global.ent_ovr_spr == sprite_index)
        {
            bf0 = image_index;
        }
        global.ent_ovr_frm = floor((bf0 / max(1, sprite_get_number(global.ent_ovr_spr))) * sprite_get_number(bs)) mod max(1, sprite_get_number(bs));
        global.ent_ovr_spr = bs;
        net_ents_add(global.NET_ENT_BODY);
    }
    else if (global.ent_ovr_spr >= 0 && sprite_exists(global.ent_ovr_spr))
    {
        global.ent_ovr_frm = net_exec_lfrm();
        net_ents_add(global.NET_ENT_BODY);
    }
}
global.ent_ovr_spr = -1;
net_ents_flush();
