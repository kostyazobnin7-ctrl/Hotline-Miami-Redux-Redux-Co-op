for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.ps_observers[i] = 0;
}
for (var j = 1; j <= global.NET_MAX_PLAYERS; j += 1)
{
    if ((j == 1 || global.pl_used[j]) && global.ps_state[j] == global.NET_PS_DEAD)
    {
        var i = global.spec_target_of[j];
        if (i >= 1 && i <= global.NET_MAX_PLAYERS)
        {
            global.ps_observers[i] |= 1 << (j - 1);
        }
    }
}
var sig = "";
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i == 1 || global.pl_used[i])
    {
        sig += (string(i) + ":" + string(global.ps_state[i]) + ":" + string(global.ps_observers[i]) + ":" + string(global.ps_cause[i]) + ";");
    }
}
if (sig == global.spec_sig && (current_time - global.spec_t) < global.NET_SPEC_RESEND_MS)
{
    exit;
}
global.spec_sig = sig;
global.spec_t = current_time;
var w = net_packet_begin(global.NET_MSG_SPEC_STATE);
var cpos = buffer_tell(w);
buffer_write(w, buffer_u8, 0);
var n = 0;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i == 1 || global.pl_used[i])
    {
        buffer_write(w, buffer_u8, i);
        buffer_write(w, buffer_u8, global.ps_state[i]);
        buffer_write(w, buffer_u16, clamp(global.ps_timer[i], 0, 65535));
        buffer_write(w, buffer_u8, global.ps_observers[i]);
        buffer_write(w, buffer_u8, global.ps_cause[i]);
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
