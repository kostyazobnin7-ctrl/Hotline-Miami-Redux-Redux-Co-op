/// net_on_pevent(buf, size, ip, port)
// v2.2.2 / bug2: клиент сразу применяет DOWN / DEAD / REVIVED к ps_state
// (раньше только вспышка на REVIVED — prediction и spectator ждали SNAP/SPEC).
var b = argument0;
if (!net_from_host(argument2, argument3) || argument1 < 6)
{
    global.net_drops += 1;
    exit;
}
var ev = buffer_read(b, buffer_u8);
var pid = buffer_read(b, buffer_u8);
var oth = buffer_read(b, buffer_u8);
var val = buffer_read(b, buffer_u16);
if (pid < 1 || pid > global.NET_MAX_PLAYERS)
{
    global.net_drops += 1;
    exit;
}
if (ev == global.NET_EV_REVIVE_PROGRESS)
{
    // полоска подъёма — без смены состояния
    if (global.ps_state[pid] == global.NET_PS_DOWNED)
    {
        global.ps_reviver[pid] = oth;
        global.ps_rev[pid] = (val * global.NET_REVIVE_TICKS) / 255;
    }
    exit;
}
if (ev == global.NET_EV_DOWN)
{
    global.ps_state[pid] = global.NET_PS_DOWNED;
    global.ps_cause[pid] = oth;
    global.ps_timer[pid] = val;
    global.ps_rev[pid] = 0;
    global.ps_reviver[pid] = 0;
}
else if (ev == global.NET_EV_DEAD)
{
    global.ps_state[pid] = global.NET_PS_DEAD;
    global.ps_timer[pid] = 0;
    global.ps_rev[pid] = 0;
    global.ps_reviver[pid] = 0;
}
else if (ev == global.NET_EV_REVIVED)
{
    global.ps_state[pid] = global.NET_PS_ALIVE;
    global.ps_timer[pid] = 0;
    global.ps_rev[pid] = 0;
    global.ps_reviver[pid] = 0;
    global.ps_body[pid] = -4;
    global.ps_cause[pid] = 0;
    // spectator (cam_spectate) ставит spec_active=1 при DEAD и сам не снимает
    global.spec_active[pid] = 0;
    global.spec_fade[pid] = 0;
    global.spec_target_of[pid] = 0;
    if (pid == global.net_my_pid)
    {
        global.spec_sent_target = -1;
    }
    var a = global.av[pid];
    if (a != -4 && instance_exists(a))
    {
        with (a)
        {
            net_avatar_stand_up();
        }
    }
    global.net_ev_flash = 20;
}
else if (ev == global.NET_EV_REVIVE_CANCEL)
{
    if (global.ps_state[pid] == global.NET_PS_DOWNED)
    {
        global.ps_rev[pid] = 0;
        global.ps_reviver[pid] = 0;
    }
}
net_log("событие " + string(ev) + " игрок " + string(pid) + " other " + string(oth) + " val " + string(val));
