var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var en = argument5;
var hover = point_in_rectangle(global.lb_mx, global.lb_my, x1, y1, x2, y2);
if (!global.lb_drawing)
{
    return en && hover && global.lb_click;
}
var col;
if (!en)
{
    col = make_color_rgb(60, 60, 70);
}
else if (hover)
{
    col = make_color_rgb(255, 40, 150);
}
else
{
    col = make_color_rgb(110, 20, 80);
}
draw_set_alpha(1);
draw_set_color(col);
draw_rectangle(x1, y1, x2, y2, false);
draw_set_color(make_color_rgb(0, 230, 230));
draw_rectangle(x1, y1, x2, y2, true);
if (en)
{
    net_ui_text((x1 + x2) / 2, (y1 + y2) / 2, argument4, 16777215, 1, 1);
}
else
{
    net_ui_text((x1 + x2) / 2, (y1 + y2) / 2, argument4, 8421504, 1, 1);
}
return 0;
