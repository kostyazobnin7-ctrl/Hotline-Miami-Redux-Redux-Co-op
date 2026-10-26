/// net_mask_restart_reset()
// v1.4.4: вместо «global.maskonsaved = 0» при перезапуске уровня (objEffector).
// Хост в сетевой игре маску не выбирает заново — она загружается снова (maskload);
// клиенты и одиночная игра — как в оригинале.
if (global.net_started && global.net_conn == global.NET_CONN_CONNECTED && global.net_mode == global.NET_MODE_HOST)
{
    global.maskload = 1;
}
else
{
    global.maskonsaved = 0;
}
