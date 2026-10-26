/// net_save_send(pid)
// v1.7, ХОСТ: сохранение хоста (saves.dat: маски, уровни, оружие, буквы, очки) клиенту pid.
// Формат SAVE: string — строки файла через chr(10) (пусто — у хоста нет сохранения).
var s = "";
var p = working_directory + chr(92) + "saves.dat";
if (file_exists(p))
{
    var f = file_text_open_read(p);
    while (!file_text_eof(f))
    {
        s += file_text_read_string(f) + chr(10);
        file_text_readln(f);
    }
    file_text_close(f);
}
var w = net_packet_begin(global.NET_MSG_SAVE);
buffer_write(w, buffer_string, s);
net_transport_send(global.pl_ip[argument0], global.pl_port[argument0], w, buffer_tell(w));
