var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 4)
{
    global.net_drops += 1;
    exit;
}
var rm = buffer_read(b, buffer_u16);
var n = buffer_read(b, buffer_u8);
if (rm != room || rm != global.net_host_room)
{
    exit;
}
for (var k = 0; k < n; k += 1)
{
    var pos = buffer_tell(b);
    if ((pos + 1) > sz)
    {
        global.net_drops += 1;
        exit;
    }
    var kind = buffer_read(b, buffer_u8);
    if (kind == global.NET_FX_SOUND && (pos + 3) <= sz)
    {
        var v = buffer_read(b, buffer_u16);
        if (audio_exists(v))
        {
            audio_play_sound(v, 0, false);
        }
    }
    else if (kind == global.NET_FX_SHAKE && (pos + 2) <= sz)
    {
        var v = buffer_read(b, buffer_u8);
        global.shake = max(global.shake, v);
    }
    else if (kind == global.NET_FX_SCORE && (pos + 10) <= sz)
    {
        var ox = buffer_read(b, buffer_s16);
        var oy = buffer_read(b, buffer_s16);
        var f = buffer_read(b, buffer_u8);
        var v = buffer_read(b, buffer_s32);
        var o = instance_create(ox, oy, objScore);
        if (f == 0)
        {
            o.text = "+" + string(v) + "pts";
        }
        else if (f == 1)
        {
            o.text = string(v) + "xCOMBO";
        }
        else
        {
            o.text = string(v) + "x";
        }
    }
    else
    {
        global.net_drops += 1;
        exit;
    }
    global.fx_got += 1;
}
