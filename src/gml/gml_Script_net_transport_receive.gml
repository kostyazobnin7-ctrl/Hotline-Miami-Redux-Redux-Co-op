if (global.net_socket < 0)
{
    exit;
}
var t = ds_map_find_value(async_load, "type");
if (t != 3)
{
    exit;
}
if (ds_map_find_value(async_load, "id") != global.net_socket)
{
    exit;
}
var b = ds_map_find_value(async_load, "buffer");
var sz = ds_map_find_value(async_load, "size");
var ip = ds_map_find_value(async_load, "ip");
var port = ds_map_find_value(async_load, "port");
global.net_bytes_in += sz;
global.net_rate_in_acc += sz;
if (sz < 1 || sz > global.NET_MAX_PACKET)
{
    global.net_drops += 1;
    exit;
}
buffer_seek(b, buffer_seek_start, 0);
var typ = buffer_read(b, buffer_u8);
net_crash_pkt("<", typ, sz); // v2.2
if (net_peer_find(ip, port) < 0 && !(global.net_mode == global.NET_MODE_HOST && typ == global.NET_MSG_HELLO))
{
    global.net_drops += 1;
    exit;
}
var pidx = net_peer_touch(ip, port, 1);
if (pidx < 0)
{
    global.net_drops += 1;
    exit;
}
net_on_packet(typ, b, sz, ip, port, pidx);
