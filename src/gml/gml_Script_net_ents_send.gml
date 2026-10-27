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
    net_ents_exec_layer();
}
// v2.2.1: казни, которые не наследуют objPlayer
with (objPKillChainsawLean)
{
    net_ents_exec_layer();
}
with (objPKillBottle2)
{
    net_ents_exec_layer();
}
global.ent_ovr_spr = -1;
net_ents_flush();
