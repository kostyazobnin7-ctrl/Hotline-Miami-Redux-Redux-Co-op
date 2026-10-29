/// net_mask_pick_step()
// v1.6: после перезапуска уровня в сети (хост и клиенты) — выбор маски, как в начале уровня.
// Вызывается, когда перезапуск уже закончился (net_restarting = 0) и в новой комнате есть эффектор.
// v2.2.2 / bug3: перед Create выставляем global.maskindex из pl_mask[me], чтобы меню
// открылось на уже выбранной маске (objMaskMenu Create: select = global.maskindex).
if (global.net_mask_pick && global.net_opt_masks && (instance_exists(objEffector) || instance_exists(objEffectorHospital)))
{
    global.net_mask_pick = 0;
    if (!instance_exists(objMaskMenu))
    {
        var me = global.net_my_pid;
        if (me < 1)
        {
            me = 1;
        }
        if (global.pl_mask[me] != 255)
        {
            global.maskindex = clamp(round(global.pl_mask[me]), 0, 254);
        }
        global.maskonsaved = 0;
        instance_create(0, 0, objMaskMenu);
        // Create обнуляет global.maskindex — вернём select/dummy из pl_mask
        if (global.pl_mask[me] != 255)
        {
            var mk = clamp(round(global.pl_mask[me]), 0, 254);
            with (objMaskMenu)
            {
                select = mk;
            }
            var d = global.net_dummy;
            if (d != -4 && instance_exists(d))
            {
                d.maskindex = mk;
            }
        }
        net_log("маска: выбор после перезапуска");
    }
}
