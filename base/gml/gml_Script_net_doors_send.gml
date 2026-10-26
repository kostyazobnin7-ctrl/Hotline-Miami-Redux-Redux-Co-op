var w = net_packet_begin(global.NET_MSG_DOORS);
buffer_write(w, buffer_u16, room);
var cpos = buffer_tell(w);
buffer_write(w, buffer_u8, 0);
var n = 0;
with (objDoorV)
{
    if (n < global.NET_DOORS_MAX && round(image_angle) != 0)
    {
        buffer_write(w, buffer_u32, id);
        buffer_write(w, buffer_s16, round(image_angle));
        n += 1;
    }
}
buffer_poke(w, cpos, buffer_u8, n);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
