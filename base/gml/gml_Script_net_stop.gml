net_leave_game();
net_transport_shutdown();
global.net_mode = global.NET_MODE_OFF;
global.net_peer_count = 0;
global.net_local_port = -1;
net_players_init();
window_set_caption("Hotline Miami Redux Redux");
