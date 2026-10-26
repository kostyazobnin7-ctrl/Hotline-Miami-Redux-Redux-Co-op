if (sprite_index == sprPAttackPunch || sprite_index == sprPAttackBag || sprite_index == sprPAttackDrill)
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
            global.shake = 5;
            instance_destroy();
            net_snd(choose(22, 23), 1, 0);
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
            global.shake = 5;
            instance_destroy();
            net_snd(choose(22, 23), 1, 0);
        }
    }
    x += lengthdir_x(12, dir);
    y += lengthdir_y(12, dir);
    if (global.hardmode == 1)
    {
        if (global.maskindex == 2)
        {
            with (objEnemy)
            {
                if (object_index == objEnemyFat || object_index == objInspector || object_index == objEFatGunner)
                {
                    if (place_meeting(x, y, global.net_atk) || place_meeting(x + global.spacex, y + global.spacey, global.net_atk))
                    {
                        mask_index = sprWeaponMask;
                        if (scrCollisionLineExt(x, y, global.net_atk.lastx, global.net_atk.lasty, 4, 309, 99, 131))
                        {
                            scrMoveSolidOff();
                            mask_index = sprMask;
                            global.net_atk.x = global.net_atk.lastx;
                            global.net_atk.y = global.net_atk.lasty;
                            exit;
                        }
                        mask_index = sprMask;
                        edir = point_direction(global.net_atk.lastx, global.net_atk.lasty, x, y);
                        net_snd(12, 1, 0);
                        global.shake = 5;
                        my_id = instance_create(x, y, objFatKnockedOut);
                        my_id.type = object_index;
                        if (scrIsPolice(object_index))
                        {
                            if (object_index == objInspector)
                            {
                                my_id.sprite_index = sprEInspectorGetUp;
                            }
                            else
                            {
                                my_id.sprite_index = sprPoliceGetUp;
                            }
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
                        if (sprite_index == sprEFatWalk || sprite_index == sprEFatAttack || sprite_index == sprPInspectorWalk || sprite_index == sprPInspectorAttack || sprite_index == sprEFatGunWalk || sprite_index == sprEFatGunAttack)
                        {
                            noweapon = 1;
                        }
                        else
                        {
                            noweapon = 0;
                        }
                        if (noweapon == 0)
                        {
                            global.test = 0;
                            with (objEnemy)
                            {
                                if (alert == 1)
                                {
                                    global.test += 1;
                                }
                            }
                            my_id = instance_create(x, y - 12, objScore);
                            my_id.text = "+" + string(200 + (400 * global.factor)) + "pts";
                            global.myscore += (200 + (400 * global.factor));
                            global.boldscore += (200 + (400 * global.factor));
                            global.combotime += 100;
                            global.killx[global.kills] = x;
                            global.killy[global.kills] = y;
                            global.kills += 1;
                            my_id = instance_create(x, y, objWeaponThrow);
                            my_id.direction = (direction - 70) + random(40);
                            my_id.speed = 2 + random(2);
                            if (object_index == objEDodgerG)
                            {
                                my_id2 = instance_create(x, y, objWeaponThrow);
                                my_id2.image_index = 29;
                                my_id2.direction = (other.direction - 70) + random(40);
                                my_id2.speed = 2 + random(2);
                                my_id.image_index = 29;
                                my_id.ammo = ammo / 2;
                                my_id2.ammo = ammo / 2;
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
    }
    with (objEnemy)
    {
        if (scrCantGetHit(object_index) || (object_index == objEDodger && global.maskindex != 2) || (object_index == objEDodgerG && global.maskindex != 2))
        {
            valid = 0;
        }
        else
        {
            valid = 1;
        }
        if ((place_meeting(x, y, global.net_atk) || place_meeting(x + global.spacex, y + global.spacey, global.net_atk)) && valid == 1)
        {
            mask_index = sprWeaponMask;
            if (scrCollisionLineExt(x, y, global.net_atk.lastx, global.net_atk.lasty, 4, 309, 99, 131))
            {
                scrMoveSolidOff();
                mask_index = sprMask;
                global.net_atk.x = global.net_atk.lastx;
                global.net_atk.y = global.net_atk.lasty;
                exit;
            }
            mask_index = sprMask;
            edir = point_direction(global.net_atk.lastx, global.net_atk.lasty, x, y);
            net_snd(12, 1, 0);
            global.shake = 5;
            my_id = instance_create(x, y, objKnockedOut);
            my_id.type = object_index;
            if (scrIsPolice(object_index))
            {
                my_id.sprite_index = sprPoliceGetUp;
            }
            my_id.direction = (edir - 10) + random(20);
            my_id.angle = my_id.direction;
            with (my_id)
            {
                move_outside_solid(angle - 180, 16);
            }
            my_id.speed = 3;
            scrIdleGetEnemy();
            if (sprite_index == sprEWalkUnarmed || sprite_index == sprPoliceWalkUnarmed)
            {
                noweapon = 1;
            }
            else
            {
                noweapon = 0;
            }
            if (noweapon == 0)
            {
                global.test = 0;
                with (objEnemy)
                {
                    if (alert == 1)
                    {
                        global.test += 1;
                    }
                }
                my_id = instance_create(x, y - 12, objScore);
                my_id.text = "+" + string(200 + (400 * global.factor)) + "pts";
                global.myscore += (200 + (400 * global.factor));
                global.boldscore += (200 + (400 * global.factor));
                global.combotime += 100;
                global.killx[global.kills] = x;
                global.killy[global.kills] = y;
                global.kills += 1;
                my_id = instance_create(x, y, objWeaponThrow);
                my_id.direction = (direction - 70) + random(40);
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
    x = lastx;
    y = lasty;
}
