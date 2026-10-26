if (!global.fx_on)
{
    global.fx_n = 0;
    global.fx_shake_seen = global.shake;
    exit;
}
if (global.shake > (global.fx_shake_seen + 0.5))
{
    net_fx_add(global.NET_FX_SHAKE, clamp(round(global.shake), 1, 255), 0, 0, 0);
}
global.fx_shake_seen = global.shake;
var mx = global.fx_score_maxid;
with (objScore)
{
    if (id > global.fx_score_maxid)
    {
        mx = max(mx, id);
        var t = string(text);
        var f = -1;
        if (string_char_at(t, 1) == "+" && string_pos("pts", t) == (string_length(t) - 2))
        {
            f = 0;
        }
        else if (string_pos("xCOMBO", t) > 0)
        {
            f = 1;
        }
        else if (string_length(t) > 1 && string_char_at(t, string_length(t)) == "x")
        {
            f = 2;
        }
        if (f >= 0 && string_digits(t) != "")
        {
            net_fx_add(global.NET_FX_SCORE, x, y, f, real(string_digits(t)));
        }
    }
}
global.fx_score_maxid = mx;
if (global.fx_n == 0)
{
    exit;
}
var w = net_packet_begin(global.NET_MSG_FX);
buffer_write(w, buffer_u16, room);
buffer_write(w, buffer_u8, global.fx_n);
for (var k = 0; k < global.fx_n; k += 1)
{
    buffer_write(w, buffer_u8, global.fx_kind[k]);
    if (global.fx_kind[k] == global.NET_FX_SOUND)
    {
        buffer_write(w, buffer_u16, global.fx_a[k]);
    }
    else if (global.fx_kind[k] == global.NET_FX_SHAKE)
    {
        buffer_write(w, buffer_u8, global.fx_a[k]);
    }
    else
    {
        buffer_write(w, buffer_s16, clamp(round(global.fx_a[k]), -32768, 32767));
        buffer_write(w, buffer_s16, clamp(round(global.fx_b[k]), -32768, 32767));
        buffer_write(w, buffer_u8, global.fx_c[k]);
        buffer_write(w, buffer_s32, global.fx_d[k]);
    }
}
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.fx_sent += global.fx_n;
global.fx_n = 0;
