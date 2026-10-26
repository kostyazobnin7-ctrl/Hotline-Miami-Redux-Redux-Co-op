var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var fid = argument4;
var focus = global.lb_field == fid;
if (!global.lb_drawing)
{
    if (global.lb_click && point_in_rectangle(global.lb_mx, global.lb_my, x1, y1, x2, y2))
    {
        global.lb_field = fid;
        keyboard_string = global.lb_val[fid];
    }
    exit;
}
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(x1, y1, x2, y2, false);
if (focus)
{
    draw_set_color(make_color_rgb(255, 40, 150));
}
else
{
    draw_set_color(make_color_rgb(0, 160, 160));
}
draw_rectangle(x1, y1, x2, y2, true);
var s = global.lb_val[fid];
if (focus && ((current_time div 400) % 2) == 0)
{
    s += "_";
}
net_ui_text(x1 + 12, (y1 + y2) / 2, s, 16777215, 0, 1);
