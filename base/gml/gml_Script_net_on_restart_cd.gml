if (!net_from_host(argument2, argument3) || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
global.net_restart_sec = buffer_read(argument0, buffer_u8);
global.net_restart_t = current_time;
