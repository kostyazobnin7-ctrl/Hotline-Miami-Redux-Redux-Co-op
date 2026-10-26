if (global.lb_open || !instance_exists(objTitle))
{
    exit;
}
global.lb_open = 1;
instance_deactivate_object(objTitle);
instance_deactivate_object(objSpread);
instance_deactivate_object(objPalmTree);
global.lb_title_off = 1;
global.lb_field = 0;
global.lb_err = "";
keyboard_string = "";
