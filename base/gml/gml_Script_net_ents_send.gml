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
    if (global.ent_ovr_spr >= 0 && sprite_exists(global.ent_ovr_spr))
    {
        global.ent_ovr_frm = net_exec_lfrm();
        net_ents_add(global.NET_ENT_BODY);
    }
}
global.ent_ovr_spr = -1;
net_ents_flush();
