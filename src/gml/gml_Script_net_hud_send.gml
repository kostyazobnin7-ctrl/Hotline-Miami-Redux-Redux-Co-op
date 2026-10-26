var w = net_packet_begin(global.NET_MSG_HUD);
buffer_write(w, buffer_s32, round(global.myscore));
buffer_write(w, buffer_s32, round(global.comboscore));
buffer_write(w, buffer_u8, clamp(round(global.combo), 0, 255));
buffer_write(w, buffer_u8, clamp(round(global.combotime), 0, 255));
buffer_write(w, buffer_u16, clamp(round(global.kills), 0, 65535));
// v1.4: последние убийства (номер, x, y) — у клиента массивы killx/killy иначе пусты
var k0 = max(0, global.kills - 8);
buffer_write(w, buffer_u8, global.kills - k0);
for (var k = k0; k < global.kills; k += 1)
{
    buffer_write(w, buffer_u16, clamp(k, 0, 65535));
    buffer_write(w, buffer_s16, clamp(round(global.killx[k]), -32768, 32767));
    buffer_write(w, buffer_s16, clamp(round(global.killy[k]), -32768, 32767));
}
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
