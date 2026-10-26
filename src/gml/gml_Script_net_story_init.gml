/// net_story_init()
// v1.4: сюжет в сети. Хост выполняет нажатия по сюжетным предметам (свои и клиентов) и
// рассылает события STORY; клиенты повторяют их у себя. Диалоги (scrGetMessage) у клиента
// появляются только по команде хоста.
global.st_init = 1;
global.st_run = 0;      // 1 — событие предмета выполняет net_story_try/net_story_apply (не блокировать)
global.st_replay = 0;   // 1 — клиент показывает диалог, присланный хостом
global.st_seq = 0;      // хост: номер последнего события
global.st_last = 0;     // клиент: номер последнего применённого события
global.st_sess = -1;    // клиент: сессия, к которой относится st_last
global.ST_USE = 1;      // предмет: obj, ix, iy, px, py, dir
global.ST_MSG = 2;      // диалог: номер, obj, x, y
global.ST_RING = 16;    // хост: столько последних событий хранится
global.ST_KEEP = 30;    // хост: событие повторяется в пакетах столько тиков (потери UDP)
global.ST_NEAR = 24;    // предмет учитывается, если до его рамки меньше этого
for (var k = 0; k < global.ST_RING; k += 1)
{
    global.st_r_seq[k] = 0;
    global.st_r_tick[k] = -1000;
    global.st_r_room[k] = -1;
    global.st_r_kind[k] = 0;
    global.st_r_a[k] = 0;
    global.st_r_b[k] = 0;
    global.st_r_c[k] = 0;
    global.st_r_d[k] = 0;
    global.st_r_e[k] = 0;
    global.st_r_f[k] = 0;
}
global.net_flow_room = -1;
global.net_rs_last = -1; // v1.6: комната прошлого net_room_start (пауза)
// v1.4.4: музыка (хост — состояние, клиент — что уже включил)
global.net_mus_seq = 0;
global.net_mus_on = 0;
global.net_mus_path = "";
global.net_mus_seen = -1;
global.net_mus_replay = 0;
// v1.4.4: маски игроков (255 — нет), выбор маски у клиента
for (var mi = 0; mi <= global.NET_MAX_PLAYERS; mi += 1)
{
    global.pl_mask[mi] = 255;
    global.pl_mskin[mi] = 0;
}
global.net_mask_pick = 0;
global.net_mask_menu_was = 0;
global.ST_LC = 3;      // надпись «CHAPTER CLEAR» (objLevelComplete): x, y
global.st_lc_allow = 0;
global.ST_PICK = 4;     // v1.6: особый подбор (маска с пола и т. п.): d, e = x, y; f = dir
global.ST_NEAR_CL = 48; // v1.6: радиус сюжетного предмета для клиентов
global.prog_sess = -1;
// v1.7: скины (0 Джек, 1 Байкер), настройка «выбор маски при перезапуске», передача сохранения
global.net_skin_my = 0;
global.net_opt_masks = 1;
global.lx_t = 0;
global.sv_state = 0;    // клиент: 0 ждём, 1 получаем, 2 применено
global.sv_done_t = 0;
for (var sk = 0; sk <= global.NET_MAX_PLAYERS; sk += 1)
{
    global.pl_skin[sk] = 0;
    global.pl_save_ok[sk] = 0;
    global.sv_sent_t[sk] = 0;
}  // v1.6: сессия, для которой запомнен прогресс хоста
for (var pk = 0; pk < 256; pk += 1)
{
    global.prog_base[pk] = 1;
} // хост: комната последней отправки FLOW
global.net_flow_have = 0; // клиент: получен ли FLOW от хоста
net_story_list();
