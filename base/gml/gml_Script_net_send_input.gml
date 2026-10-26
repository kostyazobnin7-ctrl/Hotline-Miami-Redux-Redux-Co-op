var pid = argument0;
global.net_in_seq = (global.net_in_seq + 1) % 256;
var s = global.net_in_seq;
global.ih_move[s] = global.pin_move[pid];
global.ih_aim[s] = round(global.pin_aim[pid] * 100) % 36000;
global.ih_btn[s] = global.pin_btn[pid];
global.ih_pick[s] = global.pin_pick[pid];
global.ih_count = min(global.ih_count + 1, 255);
var n = min(global.NET_INPUT_REDUNDANCY, global.ih_count);
var w = net_packet_begin(global.NET_MSG_INPUT);
buffer_write(w, buffer_u8, n);
for (var k = 0; k < n; k += 1)
{
    s = ((global.net_in_seq - k) + 256) % 256;
    buffer_write(w, buffer_u8, s);
    buffer_write(w, buffer_u8, global.ih_move[s]);
    buffer_write(w, buffer_u16, global.ih_aim[s]);
    buffer_write(w, buffer_u8, global.ih_btn[s]);
    buffer_write(w, buffer_u8, global.ih_pick[s]);
}
net_transport_send(global.net_host_ip, global.net_port, w, buffer_tell(w));
