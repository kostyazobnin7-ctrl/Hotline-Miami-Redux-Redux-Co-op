if (sprite_index == sprPWalkBag || sprite_index == sprPAttackBag)
{
    nothing = 1;
}
else
{
    global.test = 0;
    if (place_meeting(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), objEnemy))
    {
        with (objEnemy)
        {
            if (object_index == objDogPatrol || object_index == objEnemyFat || object_index == objInspector || object_index == objEFatGunner || object_index == objEDodger || object_index == objEDodgerG || global.test > 0)
            {
                nothing = 1;
            }
            else if (place_meeting(x - lengthdir_x(12, global.net_atk.dir), y - lengthdir_y(12, global.net_atk.dir), global.net_atk))
            {
                my_id = instance_create(global.net_atk.x + lengthdir_x(7, global.net_atk.dir), global.net_atk.y + lengthdir_y(7, global.net_atk.dir), objPAttackThroat);
                my_id.maskindex = global.net_atk.maskindex;
                my_id.maskon = 1;
                if (scrIsPolice(object_index))
                {
                    my_id.sprite_index = sprPKillThroatPolice;
                }
                my_id.image_angle = global.net_atk.dir;
                instance_destroy();
                net_snd(14, 0, 0);
                net_snd(15, 0, 0);
                global.test = 1;
                if (sprite_index == sprEWalkUnarmed || sprite_index == sprEGiveUp || global.maskindex == 11)
                {
                    noweapon = 1;
                }
                else
                {
                    noweapon = 0;
                }
                if (noweapon == 0)
                {
                    my_id = instance_create(x, y, objWeaponThrow);
                    my_id.direction = (direction - 115) + random(50);
                    my_id.speed = 2 + random(1);
                    my_id.image_index = scrCurrentWeaponExt(sprite_index);
                    my_id.ammo = ammo;
                }
                if (global.maskindex == 11)
                {
                    if (scrCurrentWeaponExt(sprite_index) > 0)
                    {
                        global.gun = scrIndexToWeapon(scrCurrentWeaponExt(sprite_index));
                    }
                    else
                    {
                        global.gun = 45;
                    }
                }
            }
        }
        if (global.test == 1)
        {
            if (sprite_index == sprPWalkUnarmed || (global.maskindex == 6 && global.hardmode == 1))
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
            global.test = 3;
            instance_destroy();
            exit;
        }
    }
}
