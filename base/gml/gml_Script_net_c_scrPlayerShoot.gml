griffinspd = 0;
griffinaccuracy = 0;
if (global.net_atk.sprite_index == sprPLeaveBag || sprite_index == sprPWalkBossgun || global.net_atk.sprite_index == sprPMaskSlip || instance_exists(objMaskMenu))
{
    nothing = 1;
}
else
{
    sprite = mask_index;
    if (reload <= 0)
    {
        if (sprite_index == sprPWalkUnarmed)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPunch;
            image_index = 0;
            image_speed = 0.35;
            reload = 25;
        }
        if (sprite_index == sprPWalkBag)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackBag;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
        }
        if (sprite_index == sprPWalkPan)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPan;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
            global.usedmelee[12] = 1;
        }
        if (sprite_index == sprPWalkCrowbar)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackCrowbar;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
            global.usedmelee[9] = 1;
        }
        if (sprite_index == sprPWalkMachete)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackMachete;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
            global.usedmelee[10] = 1;
        }
        if (sprite_index == sprPWalkChainsaw)
        {
            net_snd(choose(4, 5), 0, 0);
            net_snd(74, 0, 0);
            sprite_index = sprPAttackChainsaw;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
        }
        if (sprite_index == sprPWalkPot)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPot;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
            global.usedmelee[13] = 1;
        }
        if (sprite_index == sprPWalkBoilingPot)
        {
            net_snd(choose(4, 5), 0, 0);
            global.shake = 5;
            sprite_index = sprPAttackBoilingPot;
            image_index = 1;
            image_speed = 0.35;
            repeat (3 + random(2))
            {
                my_id = instance_create(((x + lengthdir_x(11, dir)) - 2) + random(4), ((y + lengthdir_y(11, dir)) - 2) + random(4), objPWater);
                global.mydir = dir;
                with (my_id)
                {
                    move_contact_solid(global.mydir, 10);
                }
                my_id.direction = griffinaccuracy + point_direction(x, y, my_id.x, my_id.y);
                my_id.speed = 8;
                my_id.image_angle = my_id.direction;
            }
            reload = 25;
            global.usedmelee[13] = 1;
        }
        if (sprite_index == sprPigButcher)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPigButcherAttack;
            image_index = 0;
            image_speed = griffinspd + 0.5;
            reload = 20;
        }
        if (sprite_index == sprPWalkDrill)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackDrill;
            image_index = 1;
            image_speed = 0.35;
            reload = 25;
        }
        if (sprite_index == sprPWalkTrophy)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackTrophy;
            image_index = 0;
            image_speed = 0.35;
            reload = 25;
        }
        if (sprite_index == sprPWalkTaser)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackTaser;
            image_index = 0;
            image_speed = 0.5;
            reload = 25;
        }
        if (ammo > 0)
        {
            mask_index = sprBullet;
            image_angle = dir;
            if (sprite_index == sprPWalkM16)
            {
                scrSoundWhileShooting();
                net_snd(1, 0, 0);
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 3;
                global.shake = 7;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(16, dir - 7), y + lengthdir_y(16, dir - 7), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(20, dir - 1), y + myyspeed + lengthdir_y(20, dir - 1), dir, 1998, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 2) + random(4);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 6) + random(12);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 3) + random(6);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprM16Shell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackM16;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 12;
                global.usedgun[0] = 1;
            }
            if (sprite_index == sprPWalkKalashnikov)
            {
                net_snd(91, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 6;
                global.shake = 8;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(16, dir - 7), y + lengthdir_y(16, dir - 7), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(20, dir - 1), y + myyspeed + lengthdir_y(20, dir - 1), dir, 1997, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 3) + random(6);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 8) + random(16);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 6) + random(12);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprM16Shell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackKalashnikov;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 12;
            }
            if (sprite_index == sprPWalkShotgun)
            {
                net_snd(3, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 30;
                global.shake = 9;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                    with (objDoorV)
                    {
                        if (place_meeting(x + lengthdir_x(12, global.dir - 180), y + lengthdir_y(12, global.dir - 180), global.net_atk))
                        {
                            if (object_index == objDoorV)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorV2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    repeat (8)
                    {
                        my_id = instance_create(x + lengthdir_x(16, dir - 7), y + lengthdir_y(16, dir - 7), objBullet);
                        if (instance_exists(my_id))
                        {
                            if (global.maskindex == 15)
                            {
                                if (global.hardmode == 0)
                                {
                                    my_id.direction = (dir - 3) + random(10);
                                }
                                if (global.hardmode == 1)
                                {
                                    my_id.direction = (dir - 8) + random(16);
                                }
                            }
                            else
                            {
                                my_id.direction = (dir - 6) + random(12);
                            }
                            my_id.speed = 16 - random(4);
                            my_id.image_angle = my_id.direction;
                        }
                    }
                }
                scrMuzzle(x + myxspeed + lengthdir_x(20, dir - 1), y + myyspeed + lengthdir_y(20, dir - 1), dir, 2000, 1, 1);
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprShotgunShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackShotgun;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 20;
                global.usedgun[1] = 1;
            }
            if (sprite_index == sprAubreyShotgunTurn)
            {
                net_snd(3, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 30;
                global.shake = 9;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                    with (objDoorV)
                    {
                        if (place_meeting(x + lengthdir_x(12, global.dir - 180), y + lengthdir_y(12, global.dir - 180), global.net_atk))
                        {
                            if (object_index == objDoorV)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorV2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    repeat (8)
                    {
                        my_id = instance_create(x + lengthdir_x(16, dir - 1), y + lengthdir_y(16, dir - 1), objBullet);
                        if (instance_exists(my_id))
                        {
                            my_id.direction = (dir - 6) + random(12);
                            my_id.speed = 16 - random(4);
                            my_id.image_angle = my_id.direction;
                        }
                    }
                }
                scrMuzzle(x + myxspeed + lengthdir_x(20, dir - 1), y + myyspeed + lengthdir_y(20, dir - 1), dir, 2000, 1, 1);
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprShotgunShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackShotgunTurn;
                image_speed = griffinspd + 0.4;
                image_index = 0;
                light = 20;
                global.usedgun[1] = 1;
            }
            if (sprite_index == sprPWalkHuntingRifle)
            {
                net_snd(94, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 40;
                global.shake = 12;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                    with (objDoorV)
                    {
                        if (place_meeting(x + lengthdir_x(12, global.dir - 180), y + lengthdir_y(12, global.dir - 180), global.net_atk))
                        {
                            if (object_index == objDoorV)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorV2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(16, dir - 7), y + lengthdir_y(16, dir - 7), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(20, dir - 1), y + myyspeed + lengthdir_y(20, dir - 1), dir, 2000, 1, 1);
                    if (instance_exists(my_id))
                    {
                        my_id.direction = dir;
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                        my_id.caliber = 1;
                    }
                }
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprM16Shell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackHuntingRifle;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 20;
            }
            if (sprite_index == sprPWalkDoubleBarrel)
            {
                net_snd(0, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 12;
                global.shake = 14;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                    with (objDoorV)
                    {
                        if (place_meeting(x + lengthdir_x(12, global.dir - 180), y + lengthdir_y(12, global.dir - 180), global.net_atk))
                        {
                            if (object_index == objDoorV)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorV2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    repeat (16)
                    {
                        my_id = instance_create(x + lengthdir_x(16, dir - 7 - 3), y + lengthdir_y(16, dir - 7 - 3), objBullet);
                        if (instance_exists(my_id))
                        {
                            if (global.maskindex == 15)
                            {
                                if (global.hardmode == 0)
                                {
                                    my_id.direction = (dir - 6) + random(12);
                                }
                                if (global.hardmode == 1)
                                {
                                    my_id.direction = (dir - 16) + random(26);
                                }
                            }
                            else
                            {
                                my_id.direction = (dir - 10) + random(20);
                            }
                            my_id.speed = 16 - random(6);
                            my_id.image_angle = my_id.direction;
                        }
                    }
                }
                if (ammo == 1)
                {
                    sprite_index = sprPAttackDoubleBarrel1;
                }
                else
                {
                    sprite_index = sprPAttackDoubleBarrel2;
                }
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 25;
                global.usedgun[2] = 1;
            }
            if (sprite_index == sprJacketWalkShorty)
            {
                net_snd(0, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 12;
                global.shake = 14;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                    with (objDoorV)
                    {
                        if (place_meeting(x + lengthdir_x(12, global.dir - 180), y + lengthdir_y(12, global.dir - 180), global.net_atk))
                        {
                            if (object_index == objDoorV)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed += lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorV2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_x(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                            if (object_index == objDoorH2)
                            {
                                if (solid == 0)
                                {
                                    if (abs(swingspeed) < 8)
                                    {
                                        swingspeed -= lengthdir_y(16, global.dir);
                                        if (abs(swingspeed) > 3.5)
                                        {
                                            swinger = 1;
                                        }
                                    }
                                    if (abs(swingspeed) > 8)
                                    {
                                        swingspeed = sign(swingspeed) * 8;
                                    }
                                }
                            }
                        }
                    }
                }
                else
                {
                    repeat (16)
                    {
                        my_id = instance_create(x + lengthdir_x(16, dir - 7 - 3), y + lengthdir_y(16, dir - 7 - 3), objBullet);
                        if (instance_exists(my_id))
                        {
                            my_id.direction = (dir - 10) + random(20);
                            my_id.speed = 16 - random(6);
                            my_id.image_angle = my_id.direction;
                        }
                    }
                }
                if (ammo == 1)
                {
                    sprite_index = sprJacketAttackShorty1;
                }
                else
                {
                    sprite_index = sprJacketAttackShorty2;
                }
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 25;
                global.usedgun[2] = 1;
            }
            if (sprite_index == sprPWalkSilencer)
            {
                net_snd(16, 0, 0);
                scrSoundWhileShooting();
                ammo -= 1;
                reload = 12;
                global.shake = 2;
                if (place_meeting(x + lengthdir_x(9, dir), y + lengthdir_y(9, dir), objSolid) || place_meeting(x + lengthdir_x(9, dir), y + lengthdir_y(9, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 3), y + lengthdir_y(20, dir - 3), objBullet);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 6) + random(12);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 2) + random(4);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackSilencer;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 12;
                global.usedgun[3] = 1;
            }
            if (sprite_index == sprPWalk9mm)
            {
                net_snd(2, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 14;
                global.shake = 5;
                if (place_meeting(x + lengthdir_x(11, dir), y + lengthdir_y(11, dir), objSolid) || place_meeting(x + lengthdir_x(11, dir), y + lengthdir_y(11, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 2), y + lengthdir_y(20, dir - 2), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(24, dir - 1), y + myyspeed + lengthdir_y(24, dir - 1), dir, 2001, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 6) + random(12);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 3) + random(6);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttack9mm;
                image_speed = griffinspd + 0.5;
                image_index = 0;
                light = 12;
            }
            if (sprite_index == sprPWalkUzi)
            {
                net_snd(26, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 3;
                global.shake = 6;
                if (place_meeting(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), objSolid) || place_meeting(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 7), y + lengthdir_y(20, dir - 7), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(26, dir - 1), y + myyspeed + lengthdir_y(26, dir - 1), dir, 2002, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 8) + random(16);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 5) + random(10);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackUzi;
                image_speed = griffinspd + 1;
                image_index = 0;
                light = 12;
                global.usedgun[4] = 1;
            }
            if (sprite_index == sprPWalkM60)
            {
                net_snd(101, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 4 + round(random(2));
                global.shake = 9;
                if (place_meeting(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), objSolid) || place_meeting(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(18, dir - 8), y + lengthdir_y(18, dir - 8), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(32, dir - 3), y + myyspeed + lengthdir_y(32, dir - 3), dir, 1999, 1, 1);
                    if (instance_exists(my_id))
                    {
                        my_id.direction = (dir - 3) + random(6);
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(5, dir - (5 * left)), y + lengthdir_y(5, dir - (5 * left)), objShell);
                my_id.sprite_index = sprM16Shell;
                my_id.image_angle = dir;
                my_id.direction = (dir - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackM60;
                image_speed = 0.55;
                image_index = 0;
                light = 12;
                global.usedgun[0] = 1;
            }
            if (sprite_index == sprPWalkSilencedUzi)
            {
                net_snd(72, 0, 0);
                scrSoundWhileShooting();
                ammo -= 1;
                reload = 3;
                global.shake = 5;
                if (place_meeting(x + lengthdir_x(11, dir), y + lengthdir_y(11, dir), objSolid) || place_meeting(x + lengthdir_x(11, dir), y + lengthdir_y(11, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir + 2), y + lengthdir_y(20, dir + 2), objBullet);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 8) + random(16);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 4) + random(8);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackSilencedUzi;
                image_speed = griffinspd + 1;
                image_index = 0;
                light = 12;
                global.usedgun[8] = 1;
            }
            if (sprite_index == sprPWalkAks)
            {
                net_snd(91, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 6;
                global.shake = 6;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(26, dir - 1), y + lengthdir_y(26, dir - 1), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(40, dir - 1), y + myyspeed + lengthdir_y(40, dir - 1), dir, 1998, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 8) + random(16);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 6) + random(12);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackAks;
                image_speed = griffinspd + 1;
                image_index = 0;
                light = 12;
                global.usedgun[7] = 1;
            }
            if (sprite_index == sprPWalkMP5)
            {
                net_snd(32, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 4;
                global.shake = 6;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 1), y + lengthdir_y(20, dir - 1), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(32, dir - 1), y + myyspeed + lengthdir_y(32, dir - 1), dir, 1998, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 8) + random(16);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 4) + random(8);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackMP5;
                image_speed = griffinspd + 1;
                image_index = 0;
                light = 12;
                global.usedgun[7] = 1;
            }
            if (sprite_index == sprPigButcherWalkMP5)
            {
                image_index = 0;
                sprite_index = sprPigButcherShoot;
            }
            if (sprite_index == sprPigButcherShoot)
            {
                if (image_index < 2)
                {
                    image_index += 0.25;
                }
                else
                {
                    image_index = 2;
                    net_snd(32, 0, 0);
                    scrSoundWhileShooting();
                    ammo -= 1;
                    reload = 5;
                    global.shake = 5;
                    if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                    {
                        my_id = instance_create(x, y, objSmokeHit);
                        my_id.image_angle = image_angle;
                        global.dir = dir;
                        with (my_id)
                        {
                            move_contact_solid(global.dir, 16);
                        }
                    }
                    else
                    {
                        my_id = instance_create(x + lengthdir_x(20, dir - 18), y + lengthdir_y(20, dir - 18), objBullet);
                        if (instance_exists(my_id))
                        {
                            my_id.direction = ((griffinaccuracy + dir) - 5) + random(10);
                            my_id.speed = 16;
                            my_id.image_angle = my_id.direction;
                        }
                    }
                    my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                    my_id.sprite_index = sprUziShell;
                    my_id.image_angle = dir;
                    my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                    my_id.speed = 1 + random(3);
                    image_speed = griffinspd + 0;
                    light = 12;
                }
            }
            if (sprite_index == sprPWalkMagnum)
            {
                net_snd(25, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 14;
                global.shake = 10;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 7), y + lengthdir_y(20, dir - 7), objBullet);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 1) + random(2);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 6) + random(12);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 3) + random(6);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                        my_id.caliber = 1;
                    }
                }
                sprite_index = sprPAttackMagnum;
                image_speed = griffinspd + 0.4;
                image_index = 0;
                light = 12;
                global.usedgun[5] = 1;
            }
            if (sprite_index == sprPWalkScorpion)
            {
                net_snd(27, 0, 0);
                scrSoundWhileShooting();
                net_c_scrHearPlayer();
                ammo -= 1;
                reload = 3;
                global.shake = 6;
                if (place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objSolid) || place_meeting(x + lengthdir_x(10, dir), y + lengthdir_y(10, dir), objDoorV))
                {
                    my_id = instance_create(x, y, objSmokeHit);
                    my_id.image_angle = image_angle;
                    global.dir = dir;
                    with (my_id)
                    {
                        move_contact_solid(global.dir, 16);
                    }
                }
                else
                {
                    my_id = instance_create(x + lengthdir_x(20, dir - 7), y + lengthdir_y(20, dir - 7), objBullet);
                    scrMuzzle(x + myxspeed + lengthdir_x(30, dir - 1), y + myyspeed + lengthdir_y(30, dir - 1), dir, 2002, 1, 1);
                    if (instance_exists(my_id))
                    {
                        if (global.maskindex == 15)
                        {
                            if (global.hardmode == 0)
                            {
                                my_id.direction = (dir - 2) + random(4);
                            }
                            if (global.hardmode == 1)
                            {
                                my_id.direction = (dir - 7) + random(14);
                            }
                        }
                        else
                        {
                            my_id.direction = (dir - 3) + random(8);
                        }
                        my_id.speed = 16;
                        my_id.image_angle = my_id.direction;
                    }
                }
                my_id = instance_create(x + lengthdir_x(16, dir - 7 - (4 * left)), y + lengthdir_y(16, dir - 7 - (4 * left)), objShell);
                my_id.sprite_index = sprUziShell;
                my_id.image_angle = dir;
                my_id.direction = ((griffinaccuracy + dir) - (90 * left) - 20) + random(30);
                my_id.speed = 1 + random(3);
                sprite_index = sprPAttackScorpion;
                image_speed = griffinspd + 1;
                image_index = 0;
                light = 12;
                global.usedgun[6] = 1;
            }
            scrCheckUsedGuns();
        }
        if (sprite_index == sprPWalkThrow)
        {
            my_id = instance_create(x + lengthdir_x(14, dir + (left * -35)), y + lengthdir_y(12, dir + (left * -35)), objThrowingWeapon);
            net_snd(14, 0, 0);
            my_id.speed = 12;
            my_id.direction = ((griffinaccuracy + dir) - 2) + random(4);
            my_id.image_index = throwindex;
            global.usedthrow[throwindex] = 1;
            reload = 20;
            image_speed = griffinspd + 0.5;
            image_index = 1;
            sprite_index = sprPAttackThrow;
            left = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkSword)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackSword;
            image_speed = 0.35;
            image_index = 0;
            reload = 32;
            global.usedmelee[4] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkKnife)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackKnife;
            image_speed = 0.6;
            image_index = 0;
            reload = 16;
            global.usedmelee[3] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprGriffinWalk)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprGriffinAttackKnife;
            image_speed = griffinspd + 1;
            image_index = 0;
            reload = 10;
            global.usedmelee[3] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkClub)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackClub;
            image_speed = 0.35;
            image_index = 1;
            reload = 32;
            global.usedmelee[0] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkNightStick)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackNightStick;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
            global.usedmelee[8] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkPipe)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPipe;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
            global.usedmelee[1] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkBat)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackBat;
            image_speed = 0.35;
            image_index = 1;
            reload = 30;
            global.usedmelee[2] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkAxe)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackAxe;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
            global.usedmelee[7] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkSledgeHammer)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackSledgeHammer;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
            global.usedmelee[11] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkPool)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPool;
            image_speed = 0.35;
            image_index = 1;
            reload = 25;
            global.usedmelee[5] = 1;
            global.shake = 0;
        }
        if (sprite_index == sprPWalkPoolBroke)
        {
            net_snd(choose(4, 5), 0, 0);
            sprite_index = sprPAttackPoolBroke;
            image_speed = 0.6;
            image_index = 1;
            reload = 16;
            global.usedmelee[6] = 1;
            global.shake = 0;
        }
        mask_index = sprite;
        image_angle = 0;
    }
}
scrCheckUsedGuns();
scrCheckUsedMelee();
scrCheckUsedThrows();
