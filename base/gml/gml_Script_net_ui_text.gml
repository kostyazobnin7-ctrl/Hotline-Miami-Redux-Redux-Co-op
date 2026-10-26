if (!global.lb_drawing)
{
    exit;
}
draw_set_font(fntDate);
draw_set_halign(argument4);
draw_set_valign(fa_middle);
draw_set_color(argument3);
draw_text_transformed(argument0, argument1, argument2, global.lb_ts * argument5, global.lb_ts * argument5, 0);
