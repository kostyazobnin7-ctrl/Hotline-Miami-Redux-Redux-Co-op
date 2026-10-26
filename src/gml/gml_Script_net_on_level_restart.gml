if (!net_from_host(argument2, argument3) || argument1 < 3)
{
    global.net_drops += 1;
    exit;
}
if (buffer_read(argument0, buffer_u16) != room || global.net_restarting)
{
    exit;
}
net_log("хост перезапускает уровень");
global.net_mask_pick = 1; // v1.4.4: после перезапуска — выбор маски у клиента
global.net_restart_sec = 0;
net_effector_restart();
