/// net_crash_init()
// v1.9: журнал сбоев. GameMaker 1.4 не умеет перехватывать ошибки, поэтому:
//  - пока игра идёт, лежит метка coop_running.flag; при нормальном выходе (Game End) она удаляется;
//  - раз в секунду в coop_context.txt пишется состояние кооператива (комната, игроки, объекты);
//  - если при запуске метка осталась — прошлый запуск вылетел: контекст копируется в
//    coop_crash_context.txt, в главном меню появляется подсказка, что прислать.
global.crash_prev = 0;
global.crash_t = 0;
var dir = working_directory + chr(92);
if (file_exists(dir + "coop_running.flag"))
{
    global.crash_prev = 1;
    if (file_exists(dir + "coop_context.txt"))
    {
        if (file_exists(dir + "coop_crash_context.txt"))
        {
            file_delete(dir + "coop_crash_context.txt");
        }
        file_copy(dir + "coop_context.txt", dir + "coop_crash_context.txt");
    }
}
var f = file_text_open_write(dir + "coop_running.flag");
file_text_write_string(f, "1");
file_text_close(f);
