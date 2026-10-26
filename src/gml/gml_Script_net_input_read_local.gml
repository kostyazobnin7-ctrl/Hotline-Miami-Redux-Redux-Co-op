var pid = argument0;
var m = 0;
if (keyboard_check_direct(ord(global.leftkey)))
{
    m |= global.NET_IN_LEFT;
}
if (keyboard_check_direct(ord(global.rightkey)))
{
    m |= global.NET_IN_RIGHT;
}
if (keyboard_check_direct(ord(global.upkey)))
{
    m |= global.NET_IN_UP;
}
if (keyboard_check_direct(ord(global.downkey)))
{
    m |= global.NET_IN_DOWN;
}
var b = 0;
if (mouse_check_button(mb_left))
{
    b |= global.NET_BTN_ATTACK;
}
if (mouse_check_button(mb_right))
{
    b |= global.NET_BTN_THROW;
}
if (keyboard_check(vk_space))
{
    b |= global.NET_BTN_USE;
}
if (keyboard_check(ord("E")))
{
    b |= global.NET_BTN_REVIVE;
}
if (mouse_check_button_released(mb_right) && window_has_focus())
{
    global.pin_pick[pid] = (global.pin_pick[pid] + 1) % 256;
}
if (!window_has_focus())
{
    m = 0;
    b = 0;
}
// v1.4.4: клиент выбирает маску (W/S/Enter) — персонаж стоит, как в оригинале
if (global.net_mode == global.NET_MODE_CLIENT && net_mask_menu_open())
{
    m = 0;
    b = 0;
}
var mx, my;
if (window_get_fullscreen())
{
    mx = display_mouse_get_x() - (display_get_width() * 0.5);
    my = display_mouse_get_y() - (display_get_height() * 0.5);
}
else
{
    mx = display_mouse_get_x() - window_get_x() - (window_get_width() * 0.5);
    my = display_mouse_get_y() - window_get_y() - (window_get_height() * 0.5);
}
if (mx != 0 || my != 0)
{
    global.pin_aim[pid] = point_direction(0, 0, mx, my);
}
global.pin_move[pid] = m;
global.pin_btn[pid] = b;
global.pin_t[pid] = current_time;
