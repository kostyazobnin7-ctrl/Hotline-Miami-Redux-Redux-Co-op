/// net_crash_clean_exit()
// v1.9: нормальный выход из игры (Game End) — метку «игра идёт» убрать.
var p = working_directory + chr(92) + "coop_running.flag";
if (file_exists(p))
{
    file_delete(p);
}
