/// net_on_save_ack(buf, size, ip, port)
// v1.7, ХОСТ: клиент применил сохранение — можно начинать игру.
if (global.net_mode != global.NET_MODE_HOST)
{
    exit;
}
var pid = net_player_find(argument2, argument3);
if (pid < 2)
{
    global.net_drops += 1;
    exit;
}
if (!global.pl_save_ok[pid])
{
    net_log("P" + string(pid) + ": сохранение передано");
}
global.pl_save_ok[pid] = 1;
