/// net_mask_pick_step()
// v1.6: после перезапуска уровня в сети (хост и клиенты) — выбор маски, как в начале уровня.
// Вызывается, когда перезапуск уже закончился (net_restarting = 0) и в новой комнате есть эффектор.
if (global.net_mask_pick && (instance_exists(objEffector) || instance_exists(objEffectorHospital)))
{
    global.net_mask_pick = 0;
    if (!instance_exists(objMaskMenu))
    {
        global.maskonsaved = 0;
        instance_create(0, 0, objMaskMenu);
        net_log("маска: выбор после перезапуска");
    }
}
