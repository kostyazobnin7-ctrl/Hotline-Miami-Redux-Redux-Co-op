var pid = argument0;
if (global.ps_state[pid] != global.NET_PS_DOWNED)
{
    exit;
}
global.ps_state[pid] = global.NET_PS_DEAD;
global.ps_timer[pid] = 0;
global.ps_rev[pid] = 0;
global.ps_reviver[pid] = 0;
net_log("игрок " + string(pid) + " DEAD");
net_send_pevent(global.NET_EV_DEAD, pid, 0, 0);
