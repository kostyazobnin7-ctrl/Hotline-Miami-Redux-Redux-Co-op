if (global.ent_n == 0)
{
    exit;
}
var w = global.net_wbuf;
buffer_poke(w, global.ent_cpos, buffer_u8, global.ent_n);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.ent_bytes += size;
global.ent_n = 0;
