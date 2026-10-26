var line = string(current_time) + " " + string(argument0);
show_debug_message("[COOP] " + line);
if (global.net_logf >= 0)
{
    file_text_write_string(global.net_logf, line);
    file_text_writeln(global.net_logf);
    file_text_close(global.net_logf);
    global.net_logf = file_text_open_append(global.net_logname);
}
