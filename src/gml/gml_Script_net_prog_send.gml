/// net_prog_send()
// v1.6, ХОСТ, раз в 2 с: открытые уровни, маски, оружие, буквы (как в saves.dat).
// Формат: 4 блока: n u8, n x u8 (0/1) — levels[24], masks[27], newgun[16], letter[16].
var w = net_packet_begin(global.NET_MSG_PROG);
for (var blk = 0; blk < 4; blk += 1)
{
    var n = net_prog_len(blk);
    buffer_write(w, buffer_u8, n);
    for (var k = 0; k < n; k += 1)
    {
        buffer_write(w, buffer_u8, net_prog_get(blk, k) != 0);
    }
}
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
