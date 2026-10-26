if (keyboard_check_pressed(global.NET_LOBBY_KEY))
{
    if (global.lb_open)
    {
        net_lobby_ui_close();
    }
    else
    {
        net_lobby_ui_open();
    }
}
if (!global.lb_auto_done && global.net_mode != global.NET_MODE_OFF && instance_exists(objTitle))
{
    global.lb_auto_done = 1;
    net_lobby_ui_open();
}
if (!global.lb_open)
{
    exit;
}
var f = global.lb_field;
if (f > 0)
{
    var s = keyboard_string;
    if (f == 1)
    {
        s = string_replace_all(s, "#", "");
        if (string_length(s) > global.NET_NICK_MAX)
        {
            s = string_copy(s, 1, global.NET_NICK_MAX);
        }
    }
    else if (f == 2)
    {
        s = net_ui_filter(s, "0123456789.", 15);
    }
    else
    {
        s = net_ui_filter(s, "0123456789", 5);
    }
    keyboard_string = s;
    global.lb_val[f] = s;
}
global.lb_mx = device_mouse_x_to_gui(0);
global.lb_my = device_mouse_y_to_gui(0);
global.lb_click = mouse_check_button_pressed(mb_left);
global.lb_drawing = 0;
net_lobby_ui();
