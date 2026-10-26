var pid = argument0;
if (global.net_mode != global.NET_MODE_HOST || global.ps_state[pid] != global.NET_PS_ALIVE)
{
    exit;
}
global.ps_state[pid] = global.NET_PS_DOWNED;
global.ps_timer[pid] = global.NET_DOWN_TICKS;
global.ps_rev[pid] = 0;
global.ps_reviver[pid] = 0;
global.ps_body[pid] = argument1;
global.ps_cause[pid] = net_death_cause(argument1);
if (pid >= 2)
{
    net_exec_abort(pid);
}
global.pw_wpn[pid] = global.NET_WPN_NONE;
global.pw_ammo[pid] = 0;
net_log("игрок " + string(pid) + " DOWNED, таймер " + string(global.NET_DOWN_TICKS) + " тиков, причина " + string(global.ps_cause[pid]));
net_send_pevent(global.NET_EV_DOWN, pid, global.ps_cause[pid], global.NET_DOWN_TICKS);
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.ps_reviver[i] == pid && global.ps_rev[i] > 0)
    {
        global.ps_rev[i] = 0;
        global.ps_reviver[i] = 0;
        net_send_pevent(global.NET_EV_REVIVE_CANCEL, i, global.NET_CANCEL_DOWNED, 0);
    }
}
