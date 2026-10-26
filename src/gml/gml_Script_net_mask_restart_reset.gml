/// net_mask_restart_reset()
// v1.7: вместо «global.maskonsaved = 0» при перезапуске уровня (objEffector Step, objEffectorHouse Draw).
// Настройка лобби «MASK PICK ON RESTART» выключена — маска остаётся (maskload), выбора нет.
// Включена или одиночная игра — как в оригинале.
if (global.net_started && global.net_conn == global.NET_CONN_CONNECTED && !global.net_opt_masks)
{
    global.maskload = 1;
}
else
{
    global.maskonsaved = 0;
}
