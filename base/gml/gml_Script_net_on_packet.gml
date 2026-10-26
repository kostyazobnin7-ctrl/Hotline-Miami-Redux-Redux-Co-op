var typ = argument0;
var b = argument1;
var sz = argument2;
var ip = argument3;
var port = argument4;
var pidx = argument5;
if (typ == global.NET_MSG_PING)
{
    if (sz < 5)
    {
        global.net_drops += 1;
        exit;
    }
    var t = buffer_read(b, buffer_u32);
    var w = net_packet_begin(global.NET_MSG_PONG);
    buffer_write(w, buffer_u32, t);
    net_transport_send(ip, port, w, buffer_tell(w));
}
else if (typ == global.NET_MSG_PONG)
{
    if (sz < 5)
    {
        global.net_drops += 1;
        exit;
    }
    var t = buffer_read(b, buffer_u32);
    var rtt = current_time - t;
    if (rtt >= 0 && rtt < 60000)
    {
        if (global.net_peer_rtt[pidx] < 0)
        {
            global.net_peer_rtt[pidx] = rtt;
        }
        else
        {
            global.net_peer_rtt[pidx] = (global.net_peer_rtt[pidx] * 0.75) + (rtt * 0.25);
        }
    }
}
else if (typ == global.NET_MSG_HELLO)
{
    net_on_hello(b, sz, ip, port);
}
else if (typ == global.NET_MSG_WELCOME)
{
    net_on_welcome(b, sz, ip, port);
}
else if (typ == global.NET_MSG_REJECT)
{
    net_on_reject(b, sz, ip, port);
}
else if (typ == global.NET_MSG_LOBBY_STATE)
{
    net_on_lobby_state(b, sz, ip, port);
}
else if (typ == global.NET_MSG_LEAVE)
{
    net_on_leave(b, sz, ip, port);
}
else if (typ == global.NET_MSG_SLOT_REQ)
{
    net_on_slot_req(b, sz, ip, port);
}
else if (typ == global.NET_MSG_READY)
{
    net_on_ready(b, sz, ip, port);
}
else if (typ == global.NET_MSG_START)
{
    net_on_start(b, sz, ip, port);
}
else if (typ == global.NET_MSG_INPUT)
{
    net_on_input(b, sz, ip, port);
}
else if (typ == global.NET_MSG_SNAPSHOT)
{
    net_on_snapshot(b, sz, ip, port);
}
else if (typ == global.NET_MSG_WORLD)
{
    net_on_world(b, sz, ip, port);
}
else if (typ == global.NET_MSG_PEVENT)
{
    net_on_pevent(b, sz, ip, port);
}
else if (typ == global.NET_MSG_RESTART_CD)
{
    net_on_restart_cd(b, sz, ip, port);
}
else if (typ == global.NET_MSG_LEVEL_RESTART)
{
    net_on_level_restart(b, sz, ip, port);
}
else if (typ == global.NET_MSG_SPEC_STATE)
{
    net_on_spec_state(b, sz, ip, port);
}
else if (typ == global.NET_MSG_SPEC_TARGET)
{
    net_on_spec_target(b, sz, ip, port);
}
else if (typ == global.NET_MSG_ENTS)
{
    net_on_ents(b, sz, ip, port);
}
else if (typ == global.NET_MSG_HUD)
{
    net_on_hud(b, sz, ip, port);
}
else if (typ == global.NET_MSG_FX)
{
    net_on_fx(b, sz, ip, port);
}
else if (typ == global.NET_MSG_DOORS)
{
    net_on_doors(b, sz, ip, port);
}
else
{
    global.net_drops += 1;
}
