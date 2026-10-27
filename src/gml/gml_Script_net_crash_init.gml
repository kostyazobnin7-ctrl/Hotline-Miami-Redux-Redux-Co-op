/// net_crash_init()
// v1.9: журнал сбоев. GameMaker 1.4 не умеет перехватывать ошибки, поэтому:
//  - пока игра идёт, лежит метка coop_running.flag; при нормальном выходе (Game End) она удаляется;
//  - раз в секунду в coop_context.txt пишется состояние кооператива (комната, игроки, объекты);
//  - если при запуске метка осталась — прошлый запуск вылетел.
// v2.2: после вылета собирается coop_crash_log.txt: версия, время, снимок состояния, последние
// события и пакеты; в главном меню — окно с просьбой прислать файл. Если игра запущена через
// «Играть в кооп.bat» (coop-launch.ps1, ключ движка -output), журнал с текстом ошибки и стеком
// собирает лаунчер сразу после вылета и снимает метку.
global.crash_prev = 0;
global.crash_show = 0;
global.crash_t = 0;
var dir = working_directory + chr(92);
if (file_exists(dir + "coop_running.flag"))
{
    global.crash_prev = 1;
    global.crash_show = 1;
    var out = file_text_open_write(dir + "coop_crash_log.txt");
    file_text_write_string(out, "HLMR-R CO-OP — журнал вылета");
    file_text_writeln(out);
    file_text_write_string(out, "мод " + global.COOP_VERSION + ", протокол " + string(global.NET_PROTO) + ", вылет обнаружен " + date_datetime_string(date_current_datetime()));
    file_text_writeln(out);
    file_text_writeln(out);
    file_text_write_string(out, "=== текст ошибки ===");
    file_text_writeln(out);
    // текст ошибки сюда не попадает: его пишет движок (-output), а журнал с ним собирает лаунчер
    // «Играть в кооп.bat» сразу после вылета и снимает метку — тогда этот код не выполняется.
    file_text_write_string(out, "(игра была запущена не через «Играть в кооп.bat», текст ошибки движок не сохранил.");
    file_text_writeln(out);
    file_text_write_string(out, " Скопируйте его из окна ошибки GameMaker кнопкой Copy и пришлите вместе с этим файлом.)");
    file_text_writeln(out);
    file_text_writeln(out);
    file_text_write_string(out, "=== состояние перед вылетом ===");
    file_text_writeln(out);
    if (file_exists(dir + "coop_context.txt"))
    {
        var cf = file_text_open_read(dir + "coop_context.txt");
        while (!file_text_eof(cf))
        {
            file_text_write_string(out, file_text_read_string(cf));
            file_text_writeln(out);
            file_text_readln(cf);
        }
        file_text_close(cf);
    }
    else
    {
        file_text_write_string(out, "(нет — вылет до начала записи)");
        file_text_writeln(out);
    }
    file_text_close(out);
}
var f = file_text_open_write(dir + "coop_running.flag");
file_text_write_string(f, "1");
file_text_close(f);
