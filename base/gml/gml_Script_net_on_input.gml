var b = argument0;
if (global.net_mode != global.NET_MODE_HOST || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
var pid = net_player_find(argument2, argument3);
if (pid == 0)
{
    global.net_drops += 1;
    exit;
}
var n = buffer_read(b, buffer_u8);
if (n < 1 || n > global.NET_INPUT_REDUNDANCY || argument1 < (2 + (n * global.NET_INPUT_ENTRY)))
{
    global.net_drops += 1;
    exit;
}
var first = global.pin_seq[pid] < 0;
var base = buffer_tell(b);
var k = n - 1;
while (k >= 0)
{
    buffer_seek(b, buffer_seek_start, base + (k * global.NET_INPUT_ENTRY));
    var seq = buffer_read(b, buffer_u8);
    var mv = buffer_read(b, buffer_u8) & 15;
    var aim = buffer_read(b, buffer_u16) % 36000;
    var btn = buffer_read(b, buffer_u8);
    var pick = buffer_read(b, buffer_u8);
    var last = global.pin_seq[pid];
    if (last >= 0 && ((((seq - last) + 256) % 256) == 0 || (((seq - last) + 256) % 256) > 127))
    {
    }
    else
    {
        global.pin_seq[pid] = seq;
        ds_list_add(global.pin_q[pid], seq + (mv * 256) + (btn * 4096) + (pick * 1048576) + (aim * 268435456));
        if (first)
        {
            global.pin_pick[pid] = pick;
            global.pin_pick_done[pid] = pick;
            first = 0;
        }
    }
    k -= 1;
}
while (ds_list_size(global.pin_q[pid]) > global.NET_INQ_MAX)
{
    ds_list_delete(global.pin_q[pid], 0);
}
global.pin_t[pid] = current_time;
