/// net_on_story(buf, size, ip, port)
// КЛИЕНТ: пакет STORY. События применяются по порядку номеров, каждое один раз.
var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 4)
{
    global.net_drops += 1;
    exit;
}
if (global.net_mode != global.NET_MODE_CLIENT)
{
    exit;
}
if (global.st_sess != global.net_session)
{
    global.st_sess = global.net_session;
    global.st_last = 0;
}
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (rm != room || rm != global.net_host_room)
{
    exit;
}
for (var j = 0; j < n; j += 1)
{
    if ((buffer_tell(b) + 3) > sz)
    {
        global.net_drops += 1;
        exit;
    }
    var seq = buffer_read(b, buffer_u16);
    var kind = buffer_read(b, buffer_u8);
    var a, bb, c, d, e, f;
    if (kind == global.ST_USE || kind == global.ST_PICK)
    {
        if ((buffer_tell(b) + 12) > sz)
        {
            global.net_drops += 1;
            exit;
        }
        a = buffer_read(b, buffer_u16);
        bb = buffer_read(b, buffer_s16);
        c = buffer_read(b, buffer_s16);
        d = buffer_read(b, buffer_s16);
        e = buffer_read(b, buffer_s16);
        f = buffer_read(b, buffer_u16);
    }
    else
    {
        if ((buffer_tell(b) + 8) > sz)
        {
            global.net_drops += 1;
            exit;
        }
        a = buffer_read(b, buffer_u16);
        bb = buffer_read(b, buffer_u16);
        c = buffer_read(b, buffer_s16);
        d = buffer_read(b, buffer_s16);
        e = 0;
        f = 0;
    }
    var dd = (seq - global.st_last + 65536) % 65536;
    if (dd == 0 || dd >= 32768)
    {
        continue;
    }
    global.st_last = seq;
    net_story_apply(kind, a, bb, c, d, e, f);
}
