var q = global.pin_q[argument0];
if (ds_list_size(q) == 0)
{
    exit;
}
var v = ds_list_find_value(q, 0);
ds_list_delete(q, 0);
global.pin_ack[argument0] = v % 256;
global.pin_move[argument0] = (v div 256) % 16;
var nb = (v div 4096) % 256;
if ((nb & global.NET_BTN_USE) != 0 && (global.pin_btn[argument0] & global.NET_BTN_USE) == 0)
{
    global.pin_use_edge[argument0] = 1;
}
if ((nb & global.NET_BTN_ATTACK) != 0 && (global.pin_btn[argument0] & global.NET_BTN_ATTACK) == 0)
{
    global.pin_atk_edge[argument0] = 1;
}
global.pin_btn[argument0] = nb;
global.pin_pick[argument0] = (v div 1048576) % 256;
global.pin_aim[argument0] = (v div 268435456) / 100;
