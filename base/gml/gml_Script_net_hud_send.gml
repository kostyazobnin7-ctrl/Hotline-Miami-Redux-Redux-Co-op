var w = net_packet_begin(global.NET_MSG_HUD);
buffer_write(w, buffer_s32, round(global.myscore));
buffer_write(w, buffer_s32, round(global.comboscore));
buffer_write(w, buffer_u8, clamp(round(global.combo), 0, 255));
buffer_write(w, buffer_u8, clamp(round(global.combotime), 0, 255));
buffer_write(w, buffer_u16, clamp(round(global.kills), 0, 65535));
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
