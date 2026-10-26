var w = net_packet_begin(global.NET_MSG_WORLD);
buffer_write(w, buffer_u16, room);
buffer_write(w, buffer_u8, global.NET_WORLD_COUNT);
for (var i = 0; i < global.NET_WORLD_COUNT; i += 1)
{
    var v = net_world_get(i);
    if (!is_real(v))
    {
        v = 0;
    }
    buffer_write(w, buffer_s16, clamp(round(v), -32768, 32767));
}
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.net_world_room = room;
global.net_world_t = current_time;
