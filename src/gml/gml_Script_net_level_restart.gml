net_log("перезапуск уровня");
global.net_mask_pick = 1; // v1.6: после перезапуска хост тоже выбирает маску
var w = net_packet_begin(global.NET_MSG_LEVEL_RESTART);
buffer_write(w, buffer_u16, room);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        for (var k = 0; k < 3; k += 1)
        {
            net_udp_send(global.pl_ip[i], global.pl_port[i], w, size);
        }
    }
}
global.net_restart_ticks = -1;
net_effector_restart();
