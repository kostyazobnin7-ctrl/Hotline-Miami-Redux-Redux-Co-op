if (keyboard_check_pressed(vk_f9))
{
    global.net_overlay = !global.net_overlay;
}
net_lobby_ui_step();
net_crash_ctx(); // v1.9
if (global.net_socket < 0)
{
    exit;
}
net_transport_flush();
net_transport_update();
net_handshake_update();
net_lobby_extra_update(); // v1.7: скины, настройки, сохранение хоста
net_game_update();
