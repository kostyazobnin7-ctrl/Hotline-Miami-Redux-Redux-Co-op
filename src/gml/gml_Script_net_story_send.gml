/// net_story_send()
// ХОСТ, каждый тик: пакет STORY со свежими событиями этой комнаты (по возрастанию номера).
// Формат: room u16, n u8, n x (seq u16, kind u8, данные). Данные:
//   USE: obj u16, ix s16, iy s16, px s16, py s16, dir u16
//   MSG: msg u16, obj u16, x s16, y s16
var n = 0;
var first = global.st_seq - global.ST_RING + 1;
for (var s = first; s <= global.st_seq; s += 1)
{
    if (s < 1)
    {
        continue;
    }
    var k = s % global.ST_RING;
    if (global.st_r_seq[k] == s && global.st_r_room[k] == room && (global.net_tick - global.st_r_tick[k]) <= global.ST_KEEP)
    {
        n += 1;
    }
}
if (n == 0)
{
    exit;
}
var w = net_packet_begin(global.NET_MSG_STORY);
buffer_write(w, buffer_u16, room);
buffer_write(w, buffer_u8, n);
for (var s = first; s <= global.st_seq; s += 1)
{
    if (s < 1)
    {
        continue;
    }
    var k = s % global.ST_RING;
    if (global.st_r_seq[k] != s || global.st_r_room[k] != room || (global.net_tick - global.st_r_tick[k]) > global.ST_KEEP)
    {
        continue;
    }
    buffer_write(w, buffer_u16, s);
    buffer_write(w, buffer_u8, global.st_r_kind[k]);
    if (global.st_r_kind[k] == global.ST_USE || global.st_r_kind[k] == global.ST_PICK)
    {
        buffer_write(w, buffer_u16, global.st_r_a[k]);
        buffer_write(w, buffer_s16, clamp(round(global.st_r_b[k]), -32768, 32767));
        buffer_write(w, buffer_s16, clamp(round(global.st_r_c[k]), -32768, 32767));
        buffer_write(w, buffer_s16, clamp(round(global.st_r_d[k]), -32768, 32767));
        buffer_write(w, buffer_s16, clamp(round(global.st_r_e[k]), -32768, 32767));
        buffer_write(w, buffer_u16, round(((global.st_r_f[k] % 360) + 360) % 360));
    }
    else
    {
        buffer_write(w, buffer_u16, global.st_r_a[k]);
        buffer_write(w, buffer_u16, global.st_r_b[k]);
        buffer_write(w, buffer_s16, clamp(round(global.st_r_c[k]), -32768, 32767));
        buffer_write(w, buffer_s16, clamp(round(global.st_r_d[k]), -32768, 32767));
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
