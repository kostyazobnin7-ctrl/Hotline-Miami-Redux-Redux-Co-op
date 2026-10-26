if (reload > 0)
{
    exit;
}
if (sprite_index == sprPLeaveBag || sprite_index == sprPTakePhone)
{
    exit;
}
lastweapon = net_c_scrCurrentWeapon();
lastammo = ammo;
global.executionx = x;
global.executiony = y;
if (global.maskindex != 2)
{
    net_c_scrThroatEnemy();
}
if (global.test == 3)
{
    exit;
}
global.exposed = 0;
release = 0;
with (objKnockedOut)
{
    image_xscale = 3;
    image_yscale = 3;
}
if (ammo > 0)
{
    if (global.maskindex != 3)
    {
        if (sprite_index == sprPWalkScorpion || sprite_index == sprPWalkMP5 || sprite_index == sprPWalkMagnum || sprite_index == sprPWalkDoubleBarrel || sprite_index == sprPWalkUzi || sprite_index == sprPWalkSilencer || sprite_index == sprPWalkSilencedUzi || sprite_index == sprPWalkAks)
        {
            if (place_meeting(x, y, objKnockedOut))
            {
                my_id = instance_create(x, y, objPlayerShieldMouse);
                my_id.dir = dir;
                my_id.ammo = ammo;
                switch (sprite_index)
                {
                    case sprPWalkScorpion:
                        my_id.sprite_index = sprPHumanShieldScorpion;
                        break;
                    case sprPWalkMagnum:
                        my_id.sprite_index = sprPHumanShieldMagnum;
                        break;
                    case sprPWalkDoubleBarrel:
                        my_id.sprite_index = sprPHumanShieldDoubleBarrel;
                        break;
                    case sprPWalkSilencer:
                        my_id.sprite_index = sprPHumanShieldSilencer;
                        break;
                    case sprPWalkMP5:
                        my_id.sprite_index = sprPHumanShieldMP5;
                        break;
                    case sprPWalkUzi:
                        my_id.sprite_index = sprPHumanShieldUzi;
                        break;
                    case sprPWalkSilencedUzi:
                        my_id.sprite_index = sprPWalkHumanShieldSilencedUzi;
                        break;
                    case sprPWalkAks:
                        my_id.sprite_index = sprPWalkHumanShieldAks;
                        break;
                }
                global.test = 0;
                with (objKnockedOut)
                {
                    if (global.test == 0)
                    {
                        if (place_meeting(x, y, global.net_atk))
                        {
                            if (sprite_index == sprPoliceGetUp)
                            {
                                global.test = 2;
                            }
                            else
                            {
                                global.test = 1;
                                instance_destroy();
                            }
                        }
                    }
                }
                if (global.test == 2)
                {
                    with (my_id)
                    {
                        instance_destroy();
                    }
                }
                else
                {
                    instance_destroy();
                }
                with (objKnockedOut)
                {
                    image_xscale = 1;
                    image_yscale = 1;
                }
                exit;
            }
        }
    }
}
global.test = 0;
global.drop = 1;
if (place_meeting(x, y, objKnockedOut) && global.exposed == 0)
{
    with (objKnockedOut)
    {
        if (object_index != objFatKnockedOut)
        {
            image_xscale = 3;
            image_yscale = 3;
            if (place_meeting(x, y, global.net_atk) && global.test == 0)
            {
                global.test = 2;
                if (sprite_index == sprEGetUp || sprite_index == sprPoliceGetUp)
                {
                    my_id = instance_create(x, y, net_c_scrGetKill(global.net_atk.sprite_index));
                }
                if (sprite_index == sprEGetUpLean)
                {
                    if (global.net_atk.sprite_index == sprPWalkChainsaw || global.net_atk.sprite_index == sprPAttackChainsaw)
                    {
                        my_id = instance_create(x, y, objPKillChainsawLean);
                    }
                    else
                    {
                        my_id = instance_create(x, y, objEnemyHeadKick);
                    }
                    if (global.net_atk.sprite_index == sprPWalkBag || global.net_atk.sprite_index == sprPAttackBag)
                    {
                        my_id.bag = 1;
                    }
                    else
                    {
                        my_id.bag = 0;
                    }
                    global.test = 1;
                }
                if (sprite_index == sprPoliceGetUpLean)
                {
                    if (global.net_atk.sprite_index == sprPWalkChainsaw || global.net_atk.sprite_index == sprPAttackChainsaw)
                    {
                        my_id = instance_create(x, y, objPKillChainsawLean);
                    }
                    else
                    {
                        my_id = instance_create(x, y, objEnemyHeadKick);
                        my_id.sprite_index = sprPKillPoliceLean;
                    }
                    if (global.net_atk.sprite_index == sprPWalkBag || global.net_atk.sprite_index == sprPAttackBag)
                    {
                        my_id.bag = 1;
                    }
                    else
                    {
                        my_id.bag = 0;
                    }
                    global.test = 1;
                }
                if (my_id.object_index == objPBluntKill)
                {
                    if (global.net_atk.sprite_index == sprPWalkCrowbar || global.net_atk.sprite_index == sprPAttackCrowbar)
                    {
                        global.usedkill[9] = 1;
                        my_id.sprite_index = sprPKillCrowbar;
                    }
                    if (global.net_atk.sprite_index == sprPWalkBat || global.net_atk.sprite_index == sprPAttackBat)
                    {
                        global.usedkill[2] = 1;
                        my_id.sprite_index = sprPBatKill;
                    }
                    if (global.net_atk.sprite_index == sprPWalkPipe || global.net_atk.sprite_index == sprPAttackPipe)
                    {
                        global.usedkill[1] = 1;
                        my_id.sprite_index = sprPPipeKill;
                    }
                    if (global.net_atk.sprite_index == sprPWalkClub || global.net_atk.sprite_index == sprPAttackClub)
                    {
                        global.usedkill[0] = 1;
                        my_id.sprite_index = sprPClubKill;
                    }
                    if (global.net_atk.sprite_index == sprPWalkBag || global.net_atk.sprite_index == sprPAttackBag)
                    {
                        my_id.sprite_index = sprPBagKill;
                    }
                    if (global.net_atk.sprite_index == sprPWalkPot || global.net_atk.sprite_index == sprPAttackPot)
                    {
                        global.usedkill[15] = 1;
                        my_id.sprite_index = sprPKillPot;
                    }
                    if (global.net_atk.sprite_index == sprPWalkPan || global.net_atk.sprite_index == sprPAttackPan)
                    {
                        global.usedkill[13] = 1;
                        my_id.sprite_index = sprPKillPan;
                    }
                    if (global.net_atk.sprite_index == sprPWalkNightStick || global.net_atk.sprite_index == sprPAttackNightStick)
                    {
                        my_id.sprite_index = sprPNightStickKill;
                    }
                    if (sprite_index == sprPoliceGetUp)
                    {
                        my_id.image_angle = angle;
                        my_id1 = instance_create(x + lengthdir_x(22, my_id.image_angle), y + lengthdir_x(22, my_id.image_angle), objPoliceHat);
                        my_id1.direction = (my_id.image_angle - 10) + random(20);
                        my_id1.speed = 2 + random(1);
                        my_id.bottom = 1348;
                    }
                }
                my_id.image_angle = angle;
                if (my_id.object_index == objEnemyBash && sprite_index == sprPoliceGetUp)
                {
                    my_id1 = instance_create(x + lengthdir_x(22, my_id.image_angle), y + lengthdir_x(22, my_id.image_angle), objPoliceHat);
                    my_id1.direction = (my_id.image_angle - 10) + random(20);
                    my_id1.speed = 1 + random(2);
                    my_id.sprite_index = sprPAttackBashPolice;
                    my_id.maskindex = global.maskindex;
                }
                if (my_id.object_index == objPDrillKill && sprite_index == sprPoliceGetUp)
                {
                    my_id.sprite_index = sprPDrillKillPolice;
                    my_id1 = instance_create(x + lengthdir_x(22, my_id.image_angle), y + lengthdir_x(22, my_id.image_angle), objPoliceHat);
                    my_id1.direction = (my_id.image_angle - 10) + random(20);
                    my_id1.speed = 1 + random(2);
                }
                if (my_id.object_index == objPMacheteKill && sprite_index == sprPoliceGetUp)
                {
                    my_id1 = instance_create(x + lengthdir_x(22, my_id.image_angle), y + lengthdir_x(22, my_id.image_angle), objPoliceHat);
                    my_id1.direction = (my_id.image_angle - 10) + random(20);
                    my_id1.speed = 2 + random(1);
                    my_id.sprite_index = sprPJacketKillPoliceMachete;
                }
                if (my_id.object_index == objPAxeKill && sprite_index == sprPoliceGetUp)
                {
                    my_id.sprite = 2147;
                }
                my_id.maskon = global.maskon;
                instance_destroy();
            }
            image_xscale = 1;
            image_yscale = 1;
            scrCheckUsedKills();
        }
        else
        {
            image_xscale = 3;
            image_yscale = 3;
            if (place_meeting(x, y, global.net_atk) && global.test == 0)
            {
                if (global.net_atk.sprite_index == sprPAttackAxe || global.net_atk.sprite_index == sprPWalkAxe)
                {
                    if (place_meeting(x, y, global.net_atk))
                    {
                        global.test = 2;
                        my_id = instance_create(x, y, objPKillFatAxe);
                        if (sprite_index == sprEFatGunGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillFatGunAxe;
                        }
                        else if (sprite_index == sprEInspectorGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillInspectorAxe;
                        }
                        my_id.ammo = ammo;
                        my_id.maskindex = global.maskindex;
                        my_id.maskon = global.maskon;
                        my_id.image_angle = angle;
                        instance_destroy();
                    }
                }
                if (global.net_atk.sprite_index == sprPWalkSledgeHammer || global.net_atk.sprite_index == sprPAttackSledgeHammer)
                {
                    if (place_meeting(x, y, global.net_atk))
                    {
                        global.test = 2;
                        my_id = instance_create(x, y, objPKillFatSledgeHammer);
                        if (sprite_index == sprEFatGunGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillFatGunSledgeHammer;
                        }
                        my_id.ammo = ammo;
                        my_id.maskindex = global.maskindex;
                        my_id.maskon = global.maskon;
                        my_id.image_angle = angle;
                        instance_destroy();
                    }
                }
                if (global.net_atk.sprite_index == sprPWalkSword || global.net_atk.sprite_index == sprPAttackSword)
                {
                    if (place_meeting(x, y, global.net_atk))
                    {
                        global.test = 2;
                        my_id = instance_create(x, y, objPKillFatKatana);
                        if (sprite_index == sprEFatGunGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillFatGunKatana;
                        }
                        my_id.ammo = ammo;
                        my_id.maskindex = global.maskindex;
                        my_id.maskon = global.maskon;
                        my_id.image_angle = angle;
                        instance_destroy();
                    }
                }
                if (global.net_atk.sprite_index == sprPWalkMachete || global.net_atk.sprite_index == sprPAttackMachete)
                {
                    if (place_meeting(x, y, global.net_atk))
                    {
                        global.test = 2;
                        my_id = instance_create(x, y, objPKillFatMachete);
                        if (sprite_index == sprEFatGunGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillFatGunMachete;
                        }
                        else if (sprite_index == sprEInspectorGetUp)
                        {
                            my_id.sprite_index = sprPJacketKillInspectorMachete;
                        }
                        my_id.ammo = ammo;
                        my_id.maskindex = global.maskindex;
                        my_id.maskon = global.maskon;
                        my_id.image_angle = angle;
                        instance_destroy();
                    }
                }
            }
        }
    }
    with (objKnockedOut)
    {
        image_xscale = 1;
        image_yscale = 1;
    }
    if (global.test == 1)
    {
        if (sprite_index == sprPWalkUnarmed || sprite_index == sprPWalkBag || sprite_index == sprPAttackBag || sprite_index == sprPWalkChainsaw || sprite_index == sprPAttackChainsaw || (global.hardmode == 1 && global.maskindex == 6))
        {
            nothing = 1;
        }
        else
        {
            my_id = instance_create(global.net_atk.x + lengthdir_x(8, global.net_atk.dir + 90), global.net_atk.y + lengthdir_y(8, global.net_atk.dir + 90), objWeaponThrow);
            my_id.image_index = lastweapon;
            my_id.direction = dir + 70 + random(40);
            my_id.speed = 1 + random(2);
            my_id.ammo = lastammo;
        }
        instance_destroy();
        exit;
    }
    if (global.test == 2)
    {
        with (objKnockedOut)
        {
            image_xscale = 1;
            image_yscale = 1;
        }
        instance_destroy();
        exit;
    }
}
if (place_meeting(x, y, objFatKnockedOut))
{
    with (objFatKnockedOut)
    {
        image_xscale = 3;
        image_yscale = 3;
        if (global.maskindex == 2)
        {
            if (place_meeting(x, y, global.net_atk) && global.test == 0 && global.exposed == 0)
            {
                global.test = 2;
                my_id = instance_create(x, y, objPKillFat);
                my_id.maskindex = global.maskindex;
                my_id.maskon = global.maskon;
                my_id.image_angle = angle;
                if (sprite_index == sprEInspectorGetUp)
                {
                    my_id.sprite = 1981;
                }
                else if (sprite_index == sprEFatGunGetUp)
                {
                    my_id.sprite = 2087;
                    my_id.ammo = ammo;
                }
                instance_destroy();
            }
        }
    }
}
if (global.test == 1)
{
    if (sprite_index == sprPWalkUnarmed || sprite_index == sprPWalkBag || sprite_index == sprPAttackBag || sprite_index == sprPWalkChainsaw || sprite_index == sprPAttackChainsaw || (global.hardmode == 1 && global.maskindex == 6))
    {
        nothing = 1;
    }
    else
    {
        my_id = instance_create(global.net_atk.x + lengthdir_x(8, global.net_atk.dir + 90), global.net_atk.y + lengthdir_y(8, global.net_atk.dir + 90), objWeaponThrow);
        my_id.image_index = lastweapon;
        my_id.direction = dir + 70 + random(40);
        my_id.speed = 1 + random(2);
        my_id.ammo = lastammo;
    }
    instance_destroy();
    exit;
}
if (global.test == 2)
{
    with (objKnockedOut)
    {
        image_xscale = 1;
        image_yscale = 1;
    }
    with (objFatKnockedOut)
    {
        image_xscale = 1;
        image_yscale = 1;
    }
    instance_destroy();
    exit;
}
with (objKnockedOut)
{
    image_xscale = 1;
    image_yscale = 1;
}
