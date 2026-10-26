/// net_on_look(buf, size, ip, port)
// v1.7, КЛИЕНТ: настройка масок хоста, скины игроков, кому передано сохранение.
var b = argument0;
if (!net_from_host(argument2, argument3) || global.net_mode != global.NET_MODE_CLIENT || argument1 < 2)
{
    global.net_drops += 1;
    exit;
}
global.net_opt_masks = buffer_read(b, buffer_u8);
for (var i = 1; i <= global.NET_MAX_PLAYERS && (buffer_tell(b) + 2) <= argument1; i += 1)
{
    var sk = buffer_read(b, buffer_u8);
    var ok = buffer_read(b, buffer_u8);
    if (i != global.net_my_pid)
    {
        global.pl_skin[i] = sk;
    }
    global.pl_save_ok[i] = ok;
}
for (var i = 1; i <= global.NET_MAX_PLAYERS && (buffer_tell(b) + 1) <= argument1; i += 1)
{
    global.pk_knives[i] = buffer_read(b, buffer_u8); // v1.8
}
for (var i = 1; i <= global.NET_MAX_PLAYERS && (buffer_tell(b) + 6) <= argument1; i += 1)
{
    global.stat_kills[i] = buffer_read(b, buffer_u16); // v1.9
    global.stat_execs[i] = buffer_read(b, buffer_u16);
    global.stat_downs[i] = buffer_read(b, buffer_u16);
}
