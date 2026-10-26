var b = argument0;
if (!net_from_host(argument2, argument3) || argument1 < 6)
{
    global.net_drops += 1;
    exit;
}
var ev = buffer_read(b, buffer_u8);
var pid = buffer_read(b, buffer_u8);
var oth = buffer_read(b, buffer_u8);
var val = buffer_read(b, buffer_u16);
if (pid < 1 || pid > global.NET_MAX_PLAYERS)
{
    global.net_drops += 1;
    exit;
}
if (ev == global.NET_EV_REVIVE_PROGRESS)
{
    exit;
}
if (ev == global.NET_EV_REVIVED)
{
    global.net_ev_flash = 20;
}
net_log("событие " + string(ev) + " игрок " + string(pid) + " other " + string(oth) + " val " + string(val));
