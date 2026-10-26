/// net_props_send()
// ХОСТ, раз в 15 тиков: где лежат сюжетные предметы. Часть их создают враги
// (кейс в метро), а у клиента враги выключены — без этого пакета предмета у клиента нет.
// Формат: room u16, n u8, n x (obj u16, x s16, y s16).
var w = net_packet_begin(global.NET_MSG_PROPS);
buffer_write(w, buffer_u16, room);
var npos = buffer_tell(w);
buffer_write(w, buffer_u8, 0);
var n = 0;
for (var k = 0; k < global.st_nobj; k += 1)
{
    with (global.st_obj[k])
    {
        if (object_index == global.st_obj[k] && n < 60)
        {
            buffer_write(w, buffer_u16, object_index);
            buffer_write(w, buffer_s16, clamp(round(x), -32768, 32767));
            buffer_write(w, buffer_s16, clamp(round(y), -32768, 32767));
            n += 1;
        }
    }
}
var size = buffer_tell(w);
buffer_poke(w, npos, buffer_u8, n);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
