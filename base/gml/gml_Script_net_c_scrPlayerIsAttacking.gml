if (sprite_index == sprPAttackKnife || sprite_index == sprGriffinAttackKnife || sprite_index == sprPAttackBat || sprite_index == sprPAttackCrowbar || sprite_index == sprPAttackPan || sprite_index == sprPAttackPot || sprite_index == sprPAttackMachete || sprite_index == sprPAttackChainsaw || sprite_index == sprPAttackSledgeHammer || sprite_index == sprPigButcherAttack || sprite_index == sprPAttackNightStick || sprite_index == sprPAttackPipe || sprite_index == sprPAttackClub || sprite_index == sprPAttackSword || sprite_index == sprPAttackAxe || sprite_index == sprPAttackPool || sprite_index == sprPAttackPoolBroke || (global.maskindex == 2 && sprite_index == sprPAttackPunch) || sprite_index == sprPAttackTaser)
{
    lastx = x;
    lasty = y;
    global.spacex = lengthdir_x(12, dir);
    global.spacey = lengthdir_y(12, dir);
    x += global.spacex;
    y += global.spacey;
    global.my_id = id;
    with (objGlassPanelH)
    {
        if (place_meeting(x, y, global.my_id))
        {
            SteamIncStat("Windows", 1);
            if (global.my_id.lasty < (y + 2))
            {
                add = -1;
            }
            else
            {
                add = 1;
            }
            i = 0;
            repeat (24)
            {
                my_id = instance_create(x + (i * 1.5), y, objShard);
                my_id.speed = random(5);
                my_id.direction = ((add * 90) - 8) + random(16);
                i += 1;
            }
            instance_create(x, y, objGlassPanelHBroken);
            instance_destroy();
            net_snd(choose(22, 23), 0, 0);
            global.shake = 5;
        }
    }
    with (objGlassPanelV)
    {
        if (place_meeting(x, y, global.my_id))
        {
            SteamIncStat("Windows", 1);
            if (global.my_id.lastx < (x + 2))
            {
                add = -1;
            }
            else
            {
                add = 1;
            }
            i = 0;
            repeat (24)
            {
                my_id = instance_create(x, y + (i * 1.5), objShard);
                my_id.speed = random(5);
                my_id.direction = ((90 + (add * 90)) - 8) + random(16);
                i += 1;
            }
            instance_create(x, y, objGlassPanelVBroken);
            instance_destroy();
            net_snd(choose(22, 23), 0, 0);
            global.shake = 5;
        }
    }
    x += lengthdir_x(12, dir);
    y += lengthdir_y(12, dir);
    with (objWalrusDeadTalked)
    {
        if (place_meeting(x, y, global.net_atk) || place_meeting(x + global.spacex, y + global.spacey, global.net_atk))
        {
            if (global.net_atk.sprite_index == sprPAttackMachete || global.net_atk.sprite_index == sprPAttackSword || global.net_atk.sprite_index == sprPAttackAxe)
            {
                repeat (8)
                {
                    my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, 270), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                    my_id.image_xscale = 1 - random(0.2);
                    my_id.image_yscale = my_id.image_xscale;
                    my_id.image_angle = point_direction(x + lengthdir_x(8, 270), y + lengthdir_y(8, 270), my_id.x, my_id.y);
                    my_id.sprite_index = sprBloodSplatSmall;
                    my_id.direction = my_id.image_angle;
                    my_id.speed = 2 + random(4);
                }
                repeat (2 + random(3))
                {
                    my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, 270), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                    my_id.image_xscale = 1 - random(0.2);
                    my_id.image_yscale = my_id.image_xscale;
                    my_id.image_angle = point_direction(x + lengthdir_x(8, 270), y + lengthdir_y(8, 270), my_id.x, my_id.y);
                    my_id.direction = my_id.image_angle;
                    my_id.speed = 1 + random(5);
                }
                repeat (5 + random(5))
                {
                    my_id = instance_create(x, y, objBloodSplatTracer);
                    my_id.image_angle = point_direction(x + lengthdir_x(8, 270), y + lengthdir_y(8, 270), my_id.x, my_id.y) + random_range(-10, 10);
                    my_id.direction = my_id.image_angle;
                }
                repeat (4)
                {
                    my_id = instance_create((x - 3) + random(6) + lengthdir_x(16, 270), (y - 3) + random(6) + lengthdir_y(16, edir), objBloodSmoke);
                    my_id.image_xscale = 1.2 - random(0.2);
                    my_id.image_yscale = my_id.image_xscale;
                    my_id.image_angle = 250 + random(40);
                    my_id.direction = my_id.image_angle;
                    my_id.speed = 2 + random(1);
                    my_id.friction = 0.15;
                }
                instance_create(x, y, objWalrusDieHard);
                instance_destroy();
            }
        }
    }
    with (objEnemy)
    {
        if (place_meeting(x, y, global.net_atk) || place_meeting(x + global.spacex, y + global.spacey, global.net_atk))
        {
            if ((object_index == objEnemyFat || object_index == objInspector || object_index == objEFatGunner) && (global.net_atk.sprite_index == sprPAttackMachete || global.net_atk.sprite_index == sprPAttackSledgeHammer || global.net_atk.sprite_index == sprPAttackSword || global.net_atk.sprite_index == sprPAttackAxe) && global.maskindex == 17 && sprite_index != sprEFatDie && sprite_index != sprPInspectorDie && sprite_index != sprEFatGunDie)
            {
                mask_index = sprWeaponMask;
                edir = point_direction(global.net_atk.lastx, global.net_atk.lasty, x, y);
                if (scrCollisionLineExt(x, y, global.net_atk.lastx, global.net_atk.lasty, 4, 309, 99, 131))
                {
                    scrMoveSolidOff();
                    mask_index = sprMask;
                    global.net_atk.x = global.net_atk.lastx;
                    global.net_atk.y = global.net_atk.lasty;
                    exit;
                }
                mask_index = sprMask;
                if (global.net_atk.sprite_index != sprPAttackSledgeHammer)
                {
                    repeat (2 + random(2))
                    {
                        my_id = instance_create(x, y, objBloodSplatTracer);
                        my_id.image_angle = point_direction(x + lengthdir_x(8, 270), y + lengthdir_y(8, 270), my_id.x, my_id.y) + random_range(-10, 10);
                        my_id.direction = my_id.image_angle;
                    }
                    repeat (2)
                    {
                        my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, edir), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                        my_id.image_xscale = 1 - random(0.2);
                        my_id.image_yscale = my_id.image_xscale;
                        my_id.image_angle = point_direction(x + lengthdir_x(8, edir), y + lengthdir_y(8, edir), my_id.x, my_id.y);
                        my_id.sprite_index = sprBloodSplatSmall;
                        my_id.direction = my_id.image_angle;
                        my_id.speed = 2 + random(4);
                    }
                    repeat (2 + random(1))
                    {
                        my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, edir), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                        my_id.image_xscale = 1 - random(0.2);
                        my_id.image_yscale = my_id.image_xscale;
                        my_id.image_angle = point_direction(x + lengthdir_x(8, edir), y + lengthdir_y(8, edir), my_id.x, my_id.y);
                        my_id.direction = my_id.image_angle;
                        my_id.speed = 1 + random(5);
                    }
                    repeat (4)
                    {
                        my_id = instance_create((x - 3) + random(6) + lengthdir_x(16, edir), (y - 3) + random(6) + lengthdir_y(16, edir), objBloodSmoke);
                        my_id.image_xscale = 1.2 - random(0.2);
                        my_id.image_yscale = my_id.image_xscale;
                        my_id.image_angle = (edir - 20) + random(40);
                        my_id.direction = my_id.image_angle;
                        my_id.speed = 2 + random(1);
                        my_id.friction = 0.15;
                    }
                }
                net_snd(12, 1, 0);
                if (global.net_atk.sprite_index != sprPAttackSledgeHammer)
                {
                    net_snd(choose(9, 8), 1, 0);
                }
                global.shake = 6;
                my_id = instance_create(x, y, objFatKnockedOut);
                if (global.net_atk.sprite_index != sprPAttackSledgeHammer)
                {
                    my_id.bleed = hits + 2;
                }
                my_id.type = object_index;
                if (object_index == objInspector)
                {
                    my_id.sprite_index = sprEInspectorGetUp;
                }
                else if (object_index == objEFatGunner)
                {
                    my_id.sprite_index = sprEFatGunGetUp;
                    my_id.ammo = ammo;
                }
                my_id.direction = (edir - 10) + random(20);
                my_id.angle = my_id.direction;
                with (my_id)
                {
                    move_outside_solid(angle - 180, 16);
                }
                my_id.speed = 3;
                scrIdleGetEnemy();
                instance_destroy();
            }
            else if ((object_index == objEnemyFat || object_index == objInspector || object_index == objEFatGunner) && global.net_atk.sprite_index == sprPAttackChainsaw && 0)
            {
                dir = point_direction(global.net_atk.lastx, global.net_atk.lasty, x, y);
                my_id = instance_create(x, y, objPKillChainsawFat);
                if (object_index == objInspector)
                {
                    my_id.sprite_index = sprPKillChainsawInspector;
                    my_id1 = instance_create(x + lengthdir_x(6, direction - 180), y + lengthdir_y(6, direction - 180), objPoliceHat);
                    my_id1.direction = direction - 180;
                    my_id1.speed = 1;
                    my_id1.sprite_index = sprInspectorHat;
                }
                else if (object_index == objEFatGunner)
                {
                    my_id.sprite_index = sprPKillFatGunChainsaw;
                    my_id1 = instance_create(x + lengthdir_x(-5, image_angle + 90), y + lengthdir_y(-5, image_angle + 90), objWeaponThrow);
                    my_id1.image_index = 41;
                    my_id1.ammo = ammo;
                    my_id1.direction = direction - 90;
                    my_id1.speed = 2 + random(1);
                }
                else
                {
                    my_id.sprite_index = sprPKillChainsawFat;
                }
                my_id.direction = (dir - 10) + random(20);
                my_id.image_angle = my_id.direction;
                global.executionx = x;
                global.executiony = y;
                instance_destroy();
                with (noone)
                {
                    instance_destroy();
                }
                exit;
            }
            else
            {
                mask_index = sprWeaponMask;
                if (scrCollisionLineExt(x, y, global.net_atk.lastx, global.net_atk.lasty, 4, 309, 99, 131) || object_index == objEnemyFat || object_index == objInspector || object_index == objEFatGunner)
                {
                    nothing = 1;
                }
                else
                {
                    mask_index = sprMask;
                    global.shake = 10;
                    my_id = instance_create(x, y - 12, objScore);
                    if (object_get_parent(object_index) == 332)
                    {
                        if (room == rmTrainstationEntrance)
                        {
                            sprite_index = sprEWalkKnife;
                        }
                        else
                        {
                            sprite_index = choose(sprEWalkShotgun, sprEWalkM16, sprEWalkKalashnikov);
                        }
                    }
                    if (sprite_index == sprEWalkUnarmed || sprite_index == sprPoliceWalkUnarmed)
                    {
                        my_id.text = "+" + string(100 + (100 * global.factor)) + "pts";
                        global.myscore += (100 + (100 * global.factor));
                        global.boldscore = 100 * global.factor;
                        global.killscore += 100;
                        global.combo += 1;
                        global.combotime = 240;
                        global.killx[global.kills] = x;
                        global.killy[global.kills] = y;
                        global.kills += 1;
                        global.blink = 1;
                    }
                    else
                    {
                        my_id.text = "+" + string(200 + (200 * global.factor)) + "pts";
                        global.myscore += (200 + (200 * global.factor));
                        global.killscore += 200;
                        global.boldscore += (200 * global.factor);
                        global.combo += 1;
                        global.combotime = 240;
                        global.killx[global.kills] = x;
                        global.killy[global.kills] = y;
                        global.kills += 1;
                        global.blink = 1;
                        if (global.bonustime < (12 + (global.factor * 4)))
                        {
                            global.bonustime = 12 + (global.factor * 4);
                        }
                        if (global.factor == 2)
                        {
                            ds_list_add(global.bonuslist, "Exposure");
                        }
                        if (global.factor == 3)
                        {
                            ds_list_add(global.bonuslist, "Double Exposure");
                        }
                        if (global.factor == 4)
                        {
                            ds_list_add(global.bonuslist, "Triple Exposure");
                        }
                        if (global.factor > 4)
                        {
                            ds_list_add(global.bonuslist, "Severe Exposure");
                        }
                    }
                    edir = point_direction(global.net_atk.lastx, global.net_atk.lasty, x, y);
                    if (global.net_atk.sprite_index != sprPAttackTaser)
                    {
                        repeat (5 + random(5))
                        {
                            my_id = instance_create(x, y, objBloodSplatTracer);
                            my_id.image_angle = point_direction(x + lengthdir_x(8, 270), y + lengthdir_y(8, 270), my_id.x, my_id.y) + random_range(-10, 10);
                            my_id.direction = my_id.image_angle;
                        }
                        repeat (8)
                        {
                            my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, edir), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                            my_id.image_xscale = 1 - random(0.2);
                            my_id.image_yscale = my_id.image_xscale;
                            my_id.image_angle = point_direction(x + lengthdir_x(8, edir), y + lengthdir_y(8, edir), my_id.x, my_id.y);
                            my_id.sprite_index = sprBloodSplatSmall;
                            my_id.direction = my_id.image_angle;
                            my_id.speed = 2 + random(4);
                        }
                        repeat (2 + random(3))
                        {
                            my_id = instance_create((x - 3) + random(6) + lengthdir_x(8, edir), (y - 3) + random(6) + lengthdir_y(8, edir), objBloodDrop);
                            my_id.image_xscale = 1 - random(0.2);
                            my_id.image_yscale = my_id.image_xscale;
                            my_id.image_angle = point_direction(x + lengthdir_x(8, edir), y + lengthdir_y(8, edir), my_id.x, my_id.y);
                            my_id.direction = my_id.image_angle;
                            my_id.speed = 1 + random(5);
                        }
                        repeat (4)
                        {
                            my_id = instance_create((x - 3) + random(6) + lengthdir_x(16, edir), (y - 3) + random(6) + lengthdir_y(16, edir), objBloodSmoke);
                            my_id.image_xscale = 1.2 - random(0.2);
                            my_id.image_yscale = my_id.image_xscale;
                            my_id.image_angle = (edir - 20) + random(40);
                            my_id.direction = my_id.image_angle;
                            my_id.speed = 2 + random(1);
                            my_id.friction = 0.15;
                        }
                    }
                    my_id = instance_create(x, y, objDeadBody);
                    if (object_index == objDogPatrol)
                    {
                        SteamIncStat("Dogs", 1);
                        if (global.net_atk.sprite_index == sprPAttackClub || global.net_atk.sprite_index == sprPAttackBat || global.net_atk.sprite_index == sprPAttackCrowbar || global.net_atk.sprite_index == sprPAttackPan || global.net_atk.sprite_index == sprPAttackPot || global.net_atk.sprite_index == sprPAttackSledgeHammer || global.net_atk.sprite_index == sprPigButcherAttack || global.net_atk.sprite_index == sprPAttackPipe || global.net_atk.sprite_index == sprPAttackPool || global.net_atk.sprite_index == sprPAttackPunch)
                        {
                            net_snd(7, 0, 0);
                            global.shake = 5;
                            net_snd(17, 0, 0);
                            my_id.sprite_index = sprDogDeadBlunt;
                            my_id.image_index = 3 + floor(random(3));
                            if (global.net_atk.sprite_index == sprPAttackPool)
                            {
                                my_id1 = instance_create(global.net_atk.x + lengthdir_x(5, global.net_atk.dir), global.net_atk.y + lengthdir_y(5, global.net_atk.dir), objBrokenWeapon);
                                my_id1.direction = global.net_atk.dir - (90 * global.net_atk.left);
                                my_id1.speed = 2 + random(2);
                                my_id1.sprite_index = sprPoolBroken;
                                global.net_atk.sprite_index = sprPAttackPoolBreak;
                            }
                        }
                        else if (global.net_atk.sprite_index == sprPAttackSword || global.net_atk.sprite_index == sprPAttackAxe || global.net_atk.sprite_index == sprPAttackMachete || global.net_atk.sprite_index == sprPAttackChainsaw)
                        {
                            my_id.sprite_index = sprDogDeadPieces;
                            net_snd(choose(8, 9), 0, 0);
                            my_id.image_index = choose(1, 3);
                            if (my_id.image_index == 1)
                            {
                                part = instance_create(my_id.x + lengthdir_x(12, edir), my_id.y + lengthdir_y(8, edir), objBodyPart);
                                part.image_angle = (edir - 10) + random(20);
                                part.sprite_index = sprDogDeadPieces;
                                part.direction = part.image_angle;
                                part.speed = 3 + random(1);
                                part.image_index = 2;
                                part.image_yscale = my_id.image_yscale;
                            }
                            if (my_id.image_index == 3)
                            {
                                part = instance_create(my_id.x + lengthdir_x(16, edir), my_id.y + lengthdir_y(12, edir), objBodyPart);
                                part.image_angle = (edir - 10) + random(20);
                                part.sprite_index = sprDogDeadPieces;
                                part.direction = part.image_angle;
                                part.speed = 3 + random(1);
                                part.image_index = 4;
                                part.image_yscale = my_id.image_yscale;
                            }
                        }
                        else if (global.net_atk.sprite_index == sprPAttackPoolBroke)
                        {
                            my_id.sprite_index = sprEDogDeadPool;
                            net_snd(choose(8, 9), 0, 0);
                            my_id.image_index = floor(random(3));
                            global.net_atk.image_speed = 0;
                            global.net_atk.sprite_index = sprPWalkUnarmed;
                        }
                        else
                        {
                            my_id.sprite_index = sprDogDeadCut;
                            net_snd(choose(8, 9), 0, 0);
                            my_id.image_index = 4 + floor(random(3));
                        }
                    }
                    else
                    {
                        if (global.net_atk.sprite_index == sprPAttackTaser)
                        {
                            my_id.sprite_index = choose(sprEPoliceDeadTaser1, sprEPoliceDeadTaser2, sprEPoliceDeadTaser3);
                            my_id.image_speed = 0.25;
                            my_x = x + lengthdir_x(16, angle - (35 * global.net_atk.image_yscale));
                            my_y = y + lengthdir_y(16, angle - (35 * global.net_atk.image_yscale));
                            my_id.life = 240 + random(60);
                            i = 0;
                            sparks = 10 + floor(random(20));
                            repeat (sparks)
                            {
                                my_id1 = instance_create(my_x, my_y, objSpark1);
                                my_id1.direction = (i * 360) / sparks;
                                my_id1.speed = 1.6 + lengthdir_x(0.2, my_id1.direction * sparks * 0.25);
                                my_id1.image_angle = my_id1.direction;
                                i += 1;
                            }
                            repeat (8 + random(8))
                            {
                                my_id1 = instance_create(my_x, my_y, objSpark2);
                                my_id1.direction = random(360);
                                my_id1.speed = random(0.6);
                            }
                            instance_create(my_x, my_y, objElectricLight);
                            net_snd(47, 0, 0);
                        }
                        if (global.net_atk.sprite_index == sprPAttackClub || global.net_atk.sprite_index == sprPAttackBat || global.net_atk.sprite_index == sprPAttackCrowbar || global.net_atk.sprite_index == sprPigButcherAttack || global.net_atk.sprite_index == sprPAttackPan || global.net_atk.sprite_index == sprPAttackPot || global.net_atk.sprite_index == sprPAttackSledgeHammer || global.net_atk.sprite_index == sprPAttackPipe || global.net_atk.sprite_index == sprPAttackPool || global.net_atk.sprite_index == sprPAttackPunch)
                        {
                            net_snd(7, 0, 0);
                            global.shake = 5;
                            net_snd(17, 0, 0);
                            my_id.sprite_index = choose(sprEBackBlunt, sprEBackBlunt, sprEFrontBlunt);
                            if (object_index == objEDodger)
                            {
                                my_id.sprite_index = sprEDodgerDeadBlunt;
                            }
                            if (object_index == objEDodgerG)
                            {
                                my_id.sprite_index = sprEDodgerGunDeadBlunt;
                            }
                            my_id.image_index = 4 + floor(random(11));
                            if (global.net_atk.sprite_index == sprPAttackPool)
                            {
                                my_id1 = instance_create(global.net_atk.x + lengthdir_x(5, global.net_atk.dir), global.net_atk.y + lengthdir_y(5, global.net_atk.dir), objBrokenWeapon);
                                my_id1.direction = global.net_atk.dir - (90 * global.net_atk.left);
                                my_id1.speed = 2 + random(2);
                                my_id1.sprite_index = sprPoolBroken;
                                global.net_atk.sprite_index = sprPAttackPoolBreak;
                            }
                        }
                        if (scrIsPolice(object_index) && (global.net_atk.sprite_index == sprPAttackPunch || global.net_atk.sprite_index == sprPAttackNightStick || global.net_atk.sprite_index == sprPAttackCrowbar || global.net_atk.sprite_index == sprPAttackBat))
                        {
                            my_id1 = instance_create(x, y, objPoliceHat);
                            my_id1.direction = (edir - 10) + random(20);
                            my_id1.speed = 1 + random(2);
                            net_snd(7, 0, 0);
                            global.shake = 5;
                            my_id.sprite_index = choose(sprPoliceBackBlunt, sprPoliceBackBlunt, sprPoliceFrontBlunt);
                            my_id.image_index = floor(random(13));
                            if (my_id.sprite_index == sprPoliceBackBlunt)
                            {
                                if (my_id.image_index == 2 || my_id.image_index == 6)
                                {
                                    scrGoreBash(x, y, edir - 180, 1, 1);
                                }
                                else
                                {
                                    scrGoreBash(x, y, edir - 180, 0, 0);
                                }
                            }
                            if (my_id.sprite_index == sprPoliceFrontBlunt)
                            {
                                if (my_id.image_index == 2 || my_id.image_index == 3 || my_id.image_index == 4)
                                {
                                    scrGoreBash(x, y, edir - 180, 1, 1);
                                }
                                else
                                {
                                    scrGoreBash(x, y, edir - 180, 0, 0);
                                }
                            }
                        }
                        if (my_id.sprite_index == sprEBackBlunt || my_id.sprite_index == sprEDodgerDeadBlunt)
                        {
                            if (my_id.image_index == 6 || my_id.image_index == 12 || my_id.image_index == 14)
                            {
                                scrGoreBash(x, y, edir - 180, 1, 1);
                            }
                            else
                            {
                                scrGoreBash(x, y, edir - 180, 0, 0);
                            }
                        }
                        if (my_id.sprite_index == sprEFrontBlunt)
                        {
                            if (my_id.image_index == 6 || my_id.image_index == 7 || my_id.image_index == 8)
                            {
                                scrGoreBash(x, y, edir - 180, 1, 1);
                            }
                            else
                            {
                                scrGoreBash(x, y, edir - 180, 0, 0);
                            }
                        }
                        if (global.net_atk.sprite_index == sprPAttackKnife || global.net_atk.sprite_index == sprGriffinAttackKnife)
                        {
                            my_id.sprite_index = sprEBackCut;
                            if (object_index == objEDodger)
                            {
                                my_id.sprite_index = sprEDodgerDeadCut;
                            }
                            if (object_index == objEDodgerG)
                            {
                                my_id.sprite_index = sprEDodgerGunDeadCut;
                            }
                            net_snd(choose(8, 9), 0, 0);
                            my_id.image_index = 2 + floor(random(3));
                            if (my_id.image_index == 3 || my_id.image_index == 4)
                            {
                                scrGoreCut(x, y, edir - 180, 1, 0);
                            }
                            else
                            {
                                scrGoreCut(x, y, edir - 180, 0, 0);
                            }
                            if (scrIsPolice(object_index))
                            {
                                my_id1 = instance_create(x, y, objPoliceHat);
                                my_id1.direction = (edir - 10) + random(20);
                                my_id1.speed = 1 + random(2);
                                net_snd(7, 0, 0);
                                global.shake = 5;
                                my_id.sprite_index = sprPoliceFrontCut;
                                my_id.image_index = floor(random(13));
                                if (my_id.sprite_index == sprPoliceFrontBlunt)
                                {
                                    if (my_id.image_index == 2 || my_id.image_index == 3 || my_id.image_index == 4)
                                    {
                                        scrGoreCut(x, y, edir - 180, 1, 1);
                                    }
                                    else
                                    {
                                        scrGoreCut(x, y, edir - 180, 0, 0);
                                    }
                                }
                            }
                        }
                        if (global.net_atk.sprite_index == sprPAttackPoolBroke)
                        {
                            my_id.sprite_index = choose(sprEDeadPoolBack, sprEDeadPoolFront, sprEMafiaDieBrokenPoolNeck);
                            if (object_index == objEDodger)
                            {
                                my_id.sprite_index = sprEDodgerDeadPoolBack;
                            }
                            if (object_index == objEDodgerG)
                            {
                                my_id.sprite_index = sprEDodgerGDeadPoolBack;
                            }
                            if (my_id.sprite_index == sprEMafiaDieBrokenPoolNeck)
                            {
                                my_id.image_speed = 0.15;
                            }
                            net_snd(choose(8, 9), 0, 0);
                            my_id.image_index = random(2);
                            global.net_atk.sprite_index = sprPWalkUnarmed;
                            global.net_atk.image_speed = 0;
                        }
                        if (global.net_atk.sprite_index == sprPAttackSword || global.net_atk.sprite_index == sprPAttackAxe || global.net_atk.sprite_index == sprPAttackMachete || global.net_atk.sprite_index == sprPAttackChainsaw)
                        {
                            if (scrIsPolice(object_index))
                            {
                                my_id1 = instance_create(x, y, objPoliceHat);
                                my_id1.direction = (edir - 10) + random(20);
                                my_id1.speed = 1 + random(2);
                                net_snd(7, 0, 0);
                                global.shake = 5;
                                if (round(random(1)))
                                {
                                    my_id.sprite_index = sprEPoliceDeadSlashed;
                                }
                                else
                                {
                                    my_id.sprite_index = sprEPoliceSlashedPieces;
                                }
                                if (round(random(12)) == 1)
                                {
                                    my_id.sprite_index = sprEPoliceCrawl;
                                }
                                my_id.image_index = floor(random(4));
                                if (my_id.image_index == 1)
                                {
                                    scrGoreCut(x, y, edir - 180, 1, 0);
                                }
                                else
                                {
                                    scrGoreCut(x, y, edir - 180, 0, 0);
                                }
                                if (my_id.sprite_index == sprEPoliceSlashedPieces)
                                {
                                    if (my_id.image_index == 0)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(22, edir), my_id.y + lengthdir_y(18, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                    }
                                    if (my_id.image_index == 1)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(12, edir), my_id.y + lengthdir_y(8, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        part.sprite_index = sprEPoliceDeadPieces;
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 0;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                    if (my_id.image_index == 2)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(16, edir), my_id.y + lengthdir_y(12, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        part.sprite_index = sprEPoliceDeadPieces;
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 1;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                    if (my_id.image_index == 3)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(16, edir), my_id.y + lengthdir_y(12, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        part.sprite_index = sprEPoliceDeadPieces;
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 2;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                }
                            }
                            else
                            {
                                my_id.sprite_index = sprEBackSlashed;
                                my_id.image_index = floor(random(4));
                                if (round(random(8)) == 1)
                                {
                                    my_id.sprite_index = sprEMafiaDieGutsOut;
                                    my_id.image_index = 0;
                                    my_id.image_speed = 0.15;
                                }
                                if (object_index == objEDodger)
                                {
                                    my_id.image_speed = 0;
                                    if (round(random(1)))
                                    {
                                        my_id.sprite_index = sprEDodgerDeadSlash;
                                    }
                                    else
                                    {
                                        my_id.sprite_index = sprEDodgerSlashedPieces;
                                    }
                                    my_id.image_index = round(random(4));
                                }
                                if (object_index == objEDodgerG)
                                {
                                    my_id.image_speed = 0;
                                    if (round(random(1)))
                                    {
                                        my_id.sprite_index = sprEDodgerGunDeadSlash;
                                    }
                                    else
                                    {
                                        my_id.sprite_index = sprEDodgerGunSlashedPieces;
                                    }
                                    my_id.image_index = round(random(4));
                                }
                                if (my_id.sprite_index == sprEBackSlashed && round(random(12)) == 1)
                                {
                                    my_id.sprite_index = sprECrawl;
                                    my_id.image_speed = 0;
                                }
                                net_snd(choose(8, 9), 0, 0);
                                net_snd(7, 0, 0);
                                global.shake = 5;
                                if (my_id.image_index == 1)
                                {
                                    scrGoreCut(x, y, edir - 180, 1, 0);
                                }
                                else
                                {
                                    scrGoreCut(x, y, edir - 180, 0, 0);
                                }
                                if (my_id.sprite_index == sprEBackSlashed || my_id.sprite_index == sprEDodgerSlashedPieces || my_id.sprite_index == sprEDodgerGunSlashedPieces)
                                {
                                    if (my_id.image_index == 0)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(22, edir), my_id.y + lengthdir_y(18, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                    }
                                    if (my_id.image_index == 1)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(12, edir), my_id.y + lengthdir_y(8, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        if (object_index == objEDodger)
                                        {
                                            part.sprite_index = sprEDodgerDeadPieces;
                                        }
                                        if (object_index == objEDodgerG)
                                        {
                                            part.sprite_index = sprEDodgerGunDeadPieces;
                                        }
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 1;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                    if (my_id.image_index == 2)
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(16, edir), my_id.y + lengthdir_y(12, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        if (object_index == objEDodger)
                                        {
                                            part.sprite_index = sprEDodgerDeadPieces;
                                        }
                                        if (object_index == objEDodgerG)
                                        {
                                            part.sprite_index = sprEDodgerGunDeadPieces;
                                        }
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 2;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                    if (my_id.image_index == 3 && (my_id.sprite_index == sprEDodgerSlashedPieces || my_id.sprite_index == sprEDodgerGunSlashedPieces))
                                    {
                                        part = instance_create(my_id.x + lengthdir_x(16, edir), my_id.y + lengthdir_y(12, edir), objBodyPart);
                                        part.image_angle = (edir - 10) + random(20);
                                        if (object_index == objEDodger)
                                        {
                                            part.sprite_index = sprEDodgerDeadPieces;
                                        }
                                        if (object_index == objEDodgerG)
                                        {
                                            part.sprite_index = sprEDodgerGunDeadPieces;
                                        }
                                        part.direction = part.image_angle;
                                        part.speed = 3 + random(1);
                                        part.image_index = 3;
                                        part.image_yscale = my_id.image_yscale;
                                    }
                                }
                            }
                        }
                    }
                    my_id.direction = edir;
                    my_id.speed = 1.5 + random(1);
                    my_id.image_angle = my_id.direction;
                    if (my_id.sprite_index == sprEMafiaDieGutsOut)
                    {
                        my_id.image_angle = my_id.direction - 180;
                    }
                    if (global.pigkill == 1)
                    {
                        my_id.sprite_index = sprOscarDead;
                    }
                    global.pigkill = 0;
                    if (my_id.sprite_index == sprEBackBlunt && round(random(11)) == 2)
                    {
                        with (my_id)
                        {
                            my_id = instance_create(x, y, objECrawl);
                            my_id.direction = direction;
                            my_id.image_angle = direction;
                            global.test = 0;
                            with (my_id)
                            {
                                if (!place_free(x, y))
                                {
                                    global.test = 1;
                                    instance_destroy();
                                }
                            }
                            if (global.test == 0)
                            {
                                instance_destroy();
                            }
                        }
                    }
                    if (instance_exists(my_id))
                    {
                        if (my_id.sprite_index == sprPoliceBackBlunt && round(random(11)) == 2)
                        {
                            with (my_id)
                            {
                                my_id = instance_create(x, y, objECrawl);
                                my_id.sprite_index = sprEPoliceCrawl;
                                my_id.direction = direction;
                                my_id.image_angle = direction;
                                global.test = 0;
                                with (my_id)
                                {
                                    if (!place_free(x, y))
                                    {
                                        global.test = 1;
                                        instance_destroy();
                                    }
                                }
                                if (global.test == 0)
                                {
                                    instance_destroy();
                                }
                            }
                        }
                    }
                    if (instance_exists(my_id))
                    {
                        if (my_id.sprite_index == sprECrawl)
                        {
                            with (my_id)
                            {
                                my_id = instance_create(x, y, objECrawl);
                                my_id.direction = direction;
                                my_id.image_angle = direction;
                                global.test = 0;
                                with (my_id)
                                {
                                    if (!place_free(x, y))
                                    {
                                        global.test = 1;
                                        instance_destroy();
                                    }
                                }
                                if (global.test == 0)
                                {
                                    instance_destroy();
                                }
                            }
                        }
                        else if (my_id.sprite_index == sprEPoliceCrawl)
                        {
                            with (my_id)
                            {
                                my_id = instance_create(x, y, objECrawl);
                                my_id.sprite_index = sprEPoliceCrawl;
                                my_id.direction = direction;
                                my_id.image_angle = direction;
                                global.test = 0;
                                with (my_id)
                                {
                                    if (!place_free(x, y))
                                    {
                                        global.test = 1;
                                        instance_destroy();
                                    }
                                }
                                if (global.test == 0)
                                {
                                    instance_destroy();
                                }
                            }
                        }
                    }
                    if (instance_exists(my_id))
                    {
                        if (my_id.sprite_index == sprEBackBlunt && round(random(24)) == 2)
                        {
                            my_id.sprite_index = sprEBackCracked;
                            my_id.image_index = 0;
                        }
                    }
                    if (sprite_index == sprEWalkUnarmed || sprite_index == sprPoliceWalkUnarmed || sprite_index == sprEGiveUp || object_index == objDogPatrol)
                    {
                        noweapon = 1;
                    }
                    else
                    {
                        noweapon = 0;
                    }
                    scrIdleGetEnemy();
                    if (noweapon == 0)
                    {
                        my_id = instance_create(x, y, objWeaponThrow);
                        if (instance_exists(objVan))
                        {
                            my_id.decadenced = 1;
                        }
                        my_id.direction = (other.direction - 70) + random(40);
                        my_id.speed = 2 + random(2);
                        if (object_index == objEDodgerG)
                        {
                            my_id2 = instance_create(x, y, objWeaponThrow);
                            my_id2.image_index = 28;
                            my_id2.direction = (other.direction - 70) + random(40);
                            my_id2.speed = 2 + random(2);
                            my_id.image_index = 28;
                            my_id.ammo = round(ammo / 2);
                            my_id2.ammo = round(ammo / 2);
                        }
                        else
                        {
                            my_id.image_index = scrCurrentWeaponExt(sprite_index);
                            my_id.ammo = ammo;
                        }
                    }
                    instance_destroy();
                }
            }
        }
    }
    x = lastx;
    y = lasty;
}
