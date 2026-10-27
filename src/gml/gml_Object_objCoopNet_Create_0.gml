// v2.2: чёрный ящик журнала вылета — до всего, что может писать в журнал
global.crash_ring = ds_list_create();
global.cr_pk_h = 0;
for (var i = 0; i < 16; i += 1)
{
    global.cr_pk[i] = "";
}
net_config();
net_parse_args();
net_story_init(); // v1.4: сюжетные предметы и диалоги
// v1.9: журнал сбоев и статистика игроков
global.crash_room = -1;
global.hp_frame = 0; // v2.0.2: кэш net_hud_player
global.hp_cache = noone;
global.hp_cache_f = -1;
net_crash_init();
global.stat_en = ds_map_create();
global.stat_room = -1;
global.stat_hx = 0;
net_stats_reset();
global.net_overlay = 1;
depth = -10000;
global.net_socket = -1;
global.net_wbuf = -1;
global.net_q_buf = -1;
global.net_logf = -1;
global.pin_q_ready = 0;
global.net_exec_map = ds_map_create();
global.net_exec_tmp = ds_list_create();
global.ent_ovr_spr = -1;
global.ent_ovr_frm = 0;
global.net_exec_click = 0;
global.net_rs_list = ds_list_create();
global.net_rs_t = 0;
global.net_dummy_list = ds_list_create();
for (var pti = 0; pti <= 4; pti += 1)
{
    global.pt_armed[pti] = 0;
}
global.door_map = ds_map_create();
global.door_have = 0;
global.door_dbg_n = -1;
for (var i = 0; i <= 4; i += 1)
{
    global.pl_rtt[i] = -1; // v2.2: пинг игроков (клиент получает в LOOK)
}
global.fx_on = 0;
global.fx_n = 0;
global.net_local_port = -1;
global.net_peer_count = 0;
net_anim_init();
net_wpn_init();
global.net_spur_list = ds_list_create();
global.net_restarting = 0;
global.net_tgt_map = ds_map_create();
global.net_tgt_until = ds_map_create();
global.ent_map = ds_map_create();
global.ent_cur_u = -1000000000; // v2.1.1: время последнего кадра ENTS
global.dd_map = ds_map_create(); // v2.1.1: известные хосту тела (поиск двойников)
global.dd_new = ds_list_create();
global.dd_count = 0;
global.ent_next = 1;
global.ent_n = 0;
global.ent_cpos = 0;
global.ent_bytes = 0;
net_players_init();
net_lobby_ui_init();
cam_init();
if (global.net_mode != global.NET_MODE_OFF)
{
    net_start(global.net_mode);
}
