if (!global.net_started || global.net_conn != global.NET_CONN_CONNECTED)
{
    exit;
}
net_restart_check();
if (global.net_mode == global.NET_MODE_HOST)
{
    global.net_tick += 1;
    for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        var inst = global.av[i];
        if (inst != -4 && !instance_exists(inst))
        {
            inst = -4;
        }
        if (global.pl_used[i] && instance_exists(objPlayer))
        {
            if (inst == -4)
            {
                var p = instance_find(objPlayer, 0);
                inst = instance_create(p.x, p.y, objCoopAvatar);
                inst.pid = i;
                with (inst)
                {
                    net_avatar_place_free();
                }
            }
        }
        else if (inst != -4)
        {
            with (inst)
            {
                instance_destroy();
            }
            inst = -4;
        }
        global.av[i] = inst;
    }
    if (!global.net_restarting)
    {
        net_mask_pick_step(); // v1.6: хост тоже выбирает маску после перезапуска
    }
    // v1.6: на паузе (rmPause) таймеры «лежит» и проверка «все мертвы» стоят
    if (!global.net_restarting && room != rmPause && (instance_exists(objPlayer) || global.ps_state[1] != global.NET_PS_ALIVE))
    {
        net_input_read_local(1);
        net_ps_update();
    }
    net_wpn_update();
    var nen = instance_number(objEnemy);
    if (nen < global.net_enemy_n)
    {
        net_log("врагов в комнате: " + string(global.net_enemy_n) + " -> " + string(nen));
    }
    global.net_enemy_n = nen;
    net_spec_state_update();
    if (global.net_debug)
    {
        if (keyboard_check_pressed(vk_f6) && keyboard_check(vk_control))
        {
            // v1.7: зачистка этажа (проверка конца уровня при мёртвом хосте)
            with (objEnemy)
            {
                instance_destroy();
            }
            with (objKnockedOut)
            {
                instance_destroy();
            }
            net_log("debug: враги удалены");
        }
        else if (keyboard_check_pressed(vk_f6))
        {
            net_debug_shoot(208, 2);
        }
        if (keyboard_check_pressed(vk_f7))
        {
            net_debug_shoot(209, 2);
        }
        if (keyboard_check_pressed(vk_f11))
        {
            net_debug_shoot(209, 1);
        }
        if (keyboard_check_pressed(vk_f12) && keyboard_check(vk_control))
        {
            // v1.6: проверка PROG — хост «открывает» последний уровень (только в памяти)
            global.levels[10] = 1;
            net_log("debug: levels[10] = 1");
        }
        else if (keyboard_check_pressed(vk_f12))
        {
            if (keyboard_check(vk_shift))
            {
                global.net_debug_spawn_t = 120;
            }
            else
            {
                net_debug_spawn_enemy(2, 0);
            }
        }
        if (global.net_debug_spawn_t > 0)
        {
            global.net_debug_spawn_t -= 1;
            if (global.net_debug_spawn_t == 0)
            {
                net_debug_spawn_enemy(2, 1);
            }
        }
        if (keyboard_check_pressed(vk_f3) && keyboard_check(vk_control))
        {
            // v1.4.4: надпись конца уровня у хоста (у клиента должна появиться одна)
            instance_create(0, 0, objLevelComplete);
            net_log("debug: objLevelComplete");
        }
        else if (keyboard_check_pressed(vk_f3) && keyboard_check(vk_shift))
        {
            net_debug_move_p2(99);
        }
        else if (keyboard_check_pressed(vk_f3))
        {
            net_debug_knockout(2);
        }
        if (keyboard_check_pressed(vk_f1) && keyboard_check(vk_control))
        {
            // v1.4.2: интерлюдия как после машины в доме (песня, revisit, следующая комната)
            global.song = global.Crystals;
            global.revisit = 1;
            global.interlude = rmApartment1Entrance;
            net_log("debug: rmInterlude -> rmApartment1Entrance");
            room_goto(rmInterlude);
        }
        else if (keyboard_check_pressed(vk_f1) && keyboard_check(vk_shift))
        {
            var a2 = global.av[2];
            if (a2 != -4 && instance_exists(a2))
            {
                instance_create(a2.x + 8, a2.y, objBriefcase);
                net_log("debug: objBriefcase у P2");
            }
        }
        else if (keyboard_check_pressed(vk_f1))
        {
            net_log("debug: переход в rmAlley, done = 1");
            // v1.4: очки — как при обычном старте уровня (один раз), иначе экран очков хоста падает
            if (!global.net_game_init)
            {
                scrInitScore();
                global.net_game_init = 1;
            }
            global.done = 1;
            room_goto(rmAlley);
        }
        if (keyboard_check_pressed(vk_f2) && keyboard_check(vk_control))
        {
            net_debug_move_p2(objToken); // v1.6: P2 к букве
        }
        else if (keyboard_check_pressed(vk_f2) && keyboard_check(vk_shift))
        {
            if (global.done == 1 && instance_exists(objPlayerCarEnter))
            {
                net_debug_move_p2(4);
            }
            else
            {
                net_debug_move_p2(320);
            }
        }
        else if (keyboard_check_pressed(vk_f2))
        {
            net_log("debug: переход в rmTrainstationEntrance");
            room_goto(rmTrainstationEntrance);
        }
        if (keyboard_check_pressed(vk_f10))
        {
            net_debug_spawn_weapon(2 + keyboard_check(vk_control)); // Ctrl — под P3
        }
    }
    if (room != global.net_world_room || (current_time - global.net_world_t) >= global.NET_WORLD_RESEND_MS)
    {
        net_world_send();
    }
    if ((global.net_tick % global.NET_SNAPSHOT_EVERY) == 0)
    {
        net_snapshot_send();
    }
    if ((global.net_tick % global.NET_ENTS_EVERY) == 1)
    {
        net_ents_send();
    }
    if ((global.net_tick % global.NET_HUD_EVERY) == 3)
    {
        net_hud_send();
    }
    global.fx_on = instance_exists(objPlayer) || instance_exists(objCoopAvatar);
    net_fx_send();
    // v1.4: свои нажатия хоста по сюжетным предметам и рассылка сюжетных событий
    if ((mouse_check_button_pressed(mb_right) || mouse_check_button_pressed(mb_left)) && global.ps_state[1] == global.NET_PS_ALIVE && instance_exists(objPlayer))
    {
        // objPlayer может быть «наследником» (objEnemyBash и т. п. при ударах) — у него нет dir/active
        var hp = net_player_inst(1);
        if (hp != -4 && net_player_has_vars(hp.object_index))
        {
            net_story_try(hp.x, hp.y, hp.dir, 1);
        }
    }
    net_story_send();
    net_stats_update(); // v1.9
    net_host_biker_step(); // v1.8.1
    net_host_martin_step(); // v2.0
    if ((global.net_tick % 15) == 7)
    {
        net_props_send();
    }
    if ((global.net_tick % 120) == 17)
    {
        net_prog_send(); // v1.6: прогресс сюжета клиентам
    }
    if ((global.net_tick % 30) == 11 || room != global.net_flow_room)
    {
        net_flow_send();
    }
    net_party_travel();
    if ((global.net_tick % global.NET_ENTS_EVERY) == 2)
    {
        net_doors_send();
    }
}
else
{
    if (global.net_my_pid > 0)
    {
        net_input_read_local(global.net_my_pid);
        net_send_input(global.net_my_pid);
    }
    if (instance_exists(objTitle))
    {
        global.net_game_init = 0;
    }
    if (global.net_host_room >= 0 && room != global.net_host_room && room_exists(global.net_host_room) && (current_time - global.net_follow_t) >= global.NET_ROOM_FOLLOW_MS)
    {
        global.net_follow_t = current_time;
        if (!global.net_game_init)
        {
            scrInitScore();
            global.net_game_init = 1;
        }
        net_log("переход в комнату хоста " + room_get_name(global.net_host_room));
        room_goto(global.net_host_room);
        exit;
    }
    if (room != global.net_host_room)
    {
        exit;
    }
    if (!global.net_restarting)
    {
        net_client_dummy();
        net_mask_client_step(); // v1.4.4: выбор маски клиента
    }
    else
    {
        instance_deactivate_object(objPlayer);
        if (global.net_dummy != -4)
        {
            instance_activate_object(global.net_dummy);
        }
    }
    instance_deactivate_object(objEnemy);
    instance_deactivate_object(objMiscEnemy);
    instance_deactivate_object(objBoss);
    instance_deactivate_object(objKnockedOut);
    instance_deactivate_object(objECrawl);
    instance_deactivate_object(objEBullet);
    instance_deactivate_object(objDeadBody);
    instance_deactivate_object(objBodyPart);
    instance_deactivate_object(objWeapon);
    instance_deactivate_object(objWeaponThrow);
    instance_deactivate_object(objThrowingWeapon);
    for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
    {
        var inst = global.av[i];
        if (inst != -4 && !instance_exists(inst))
        {
            inst = -4;
        }
        if (global.sn_have[i])
        {
            if (inst == -4)
            {
                inst = instance_create(global.sn_x1[i], global.sn_y1[i], objCoopAvatar);
                inst.pid = i;
            }
        }
        else if (inst != -4)
        {
            with (inst)
            {
                instance_destroy();
            }
            inst = -4;
        }
        global.av[i] = inst;
    }
    if (global.net_debug && keyboard_check_pressed(vk_f4))
    {
        global.NET_PREDICT = !global.NET_PREDICT;
        net_log("предсказание: " + string(global.NET_PREDICT));
    }
    if (global.net_my_pid > 0 && net_predicting(global.net_my_pid))
    {
        with (global.av[global.net_my_pid])
        {
            net_avatar_predict();
        }
    }
}
