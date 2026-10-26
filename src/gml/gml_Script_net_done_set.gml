/// net_done_set()
// v1.4.4: вместо «global.done = 1;» во всём коде игры. Уровень пройден — решает хост
// (у клиента враги выключены, и его проверки считали этаж зачищенным сразу; done
// сбрасывался WORLD-пакетом и ставился снова — надпись «CHAPTER CLEAR» повторялась).
if (global.net_started && global.net_conn == global.NET_CONN_CONNECTED && global.net_mode == global.NET_MODE_CLIENT)
{
    exit;
}
global.done = 1;
