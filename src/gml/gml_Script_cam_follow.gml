var v = argument0;
var pid = argument1;
cam_player_target(pid);
if (!global.cam_seen[pid])
{
    exit;
}
var tx = global.cam_px[pid] + lengthdir_x(24, global.cam_pdir[pid]);
var ty = global.cam_py[pid] + lengthdir_y(24, global.cam_pdir[pid]);
// v1.7: Shift — взгляд к курсору, как у objPlayerMouse в оригинале (aimfar)
if (pid == global.net_my_pid && window_has_focus() && keyboard_check_direct(vk_shift))
{
    var mdx, mdy;
    if (window_get_fullscreen())
    {
        mdx = (display_mouse_get_x() - (display_get_width() * 0.5)) / display_get_width();
        mdy = (display_mouse_get_y() - (display_get_height() * 0.5)) / display_get_height();
    }
    else
    {
        mdx = (display_mouse_get_x() - window_get_x() - (window_get_width() * 0.5)) / max(1, window_get_width());
        mdy = (display_mouse_get_y() - window_get_y() - (window_get_height() * 0.5)) / max(1, window_get_height());
    }
    tx = global.cam_px[pid] + (mdx * view_wview[v]);
    ty = global.cam_py[pid] + (mdy * view_hview[v]);
}
var cx = view_xview[v] + (view_wview[v] / 2);
var cy = view_yview[v] + (view_hview[v] / 2);
if (point_distance(cx, cy, tx, ty) > view_wview[v])
{
    view_xview[v] = tx - (view_wview[v] / 2);
    view_yview[v] = ty - (view_hview[v] / 2);
}
else
{
    view_xview[v] += (tx - cx) * 0.1;
    view_yview[v] += (ty - cy) * 0.1;
}
if (argument2)
{
    var vd = point_distance(global.cam_px[pid], global.cam_py[pid], room_width / 2, room_height / 2);
    var vdir = point_direction(room_width / 2, room_height / 2, global.cam_px[pid], global.cam_py[pid]);
    view_angle[v] = lengthdir_y(vd * 0.00625, vdir * 2);
}
else
{
    view_angle[v] = 0;
}
