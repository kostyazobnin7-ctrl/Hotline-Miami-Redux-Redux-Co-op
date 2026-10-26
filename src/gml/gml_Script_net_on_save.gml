/// net_on_save(buf, size, ip, port)
// v1.7, КЛИЕНТ: сохранение хоста. Своё сохранение один раз копируется в
// saves_before_coop.dat, затем saves.dat хоста записывается и загружается (scrLoadUnlocked) —
// у всех одинаковый прогресс сюжета. Ответ SAVE_ACK (повторяется на каждый SAVE).
if (!net_from_host(argument2, argument3) || global.net_mode != global.NET_MODE_CLIENT || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
var s = buffer_read(argument0, buffer_string);
if (global.sv_state != 2)
{
    global.sv_state = 1;
    if (s != "")
    {
        var p = working_directory + chr(92) + "saves.dat";
        var bk = working_directory + chr(92) + "saves_before_coop.dat";
        if (file_exists(p) && !file_exists(bk))
        {
            file_copy(p, bk);
        }
        var f = file_text_open_write(p);
        var rest = s;
        while (rest != "")
        {
            var k = string_pos(chr(10), rest);
            if (k == 0)
            {
                file_text_write_string(f, rest);
                rest = "";
            }
            else
            {
                file_text_write_string(f, string_copy(rest, 1, k - 1));
                file_text_writeln(f);
                rest = string_delete(rest, 1, k);
            }
        }
        file_text_close(f);
        with (objCoopNet)
        {
            scrLoadUnlocked();
        }
        net_log("сохранение хоста получено и загружено (" + string(string_length(s)) + " байт)");
    }
    else
    {
        net_log("у хоста нет сохранения — своё не трогаем");
    }
    global.sv_state = 2;
    global.sv_done_t = current_time;
}
var w = net_packet_begin(global.NET_MSG_SAVE_ACK);
buffer_write(w, buffer_u8, 1);
net_transport_send(global.net_host_ip, global.net_port, w, buffer_tell(w));
