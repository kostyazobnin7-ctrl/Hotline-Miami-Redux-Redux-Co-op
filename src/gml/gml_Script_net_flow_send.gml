/// net_flow_send()
// ХОСТ, раз в 30 тиков: переменные хода сюжета, которые игра задаёт только у хоста
// (посадка в машину objPlayerCarEnter): музыка интерлюдии, следующая комната и т. п.
// Формат: song string (путь без working_directory), interlude s16, revisit u8, nextlevel s16,
//         sequence s16 (выбор главы), title string, pretitle string.
var s = global.song;
if (!is_string(s))
{
    s = "";
}
s = string_replace(s, working_directory, "");
var w = net_packet_begin(global.NET_MSG_FLOW);
buffer_write(w, buffer_string, s);
buffer_write(w, buffer_s16, clamp(round(global.interlude), -32768, 32767));
buffer_write(w, buffer_u8, clamp(round(global.revisit), 0, 255));
buffer_write(w, buffer_s16, clamp(round(global.nextlevel), -32768, 32767));
buffer_write(w, buffer_s16, clamp(round(global.sequence), -32768, 32767));
buffer_write(w, buffer_string, string(global.title));
buffer_write(w, buffer_string, string(global.pretitle));
// v1.4.4: музыка (номер смены, играет ли, путь) и маски игроков (маска u8 255 = нет, скин u8)
buffer_write(w, buffer_u16, global.net_mus_seq);
buffer_write(w, buffer_u8, global.net_mus_on);
buffer_write(w, buffer_string, global.net_mus_path);
net_mask_host_update();
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    buffer_write(w, buffer_u8, global.pl_mask[i]);
    buffer_write(w, buffer_u8, global.pl_mskin[i]);
}
global.net_flow_room = room;
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
