if (!global.lb_open)
{
    exit;
}
global.lb_open = 0;
global.lb_field = 0;
if (global.lb_title_off)
{
    instance_activate_object(objTitle);
    instance_activate_object(objSpread);
    instance_activate_object(objPalmTree);
    global.lb_title_off = 0;
}
keyboard_string = "";
