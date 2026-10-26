for (var i = 0; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.ps_state[i] = global.NET_PS_ALIVE;
    global.ps_timer[i] = 0;
    global.ps_rev[i] = 0;
    global.ps_reviver[i] = 0;
    global.ps_iframes[i] = 0;
    global.ps_body[i] = -4;
    global.ps_cause[i] = 0;
    global.ps_observers[i] = 0;
    global.spec_target_of[i] = 0;
    global.spec_active[i] = 0;
    global.spec_mode[i] = 0;
    global.spec_target[i] = 0;
    global.spec_cx[i] = 0;
    global.spec_cy[i] = 0;
    global.spec_fade[i] = 0;
}
global.spec_sent_target = -1;
global.spec_sig = "";
global.spec_t = 0;
global.ps_p1_obj = 0;
global.ps_god_saved = 0;
global.net_restart_ticks = -1;
global.net_restart_sec = 0;
global.net_restart_t = 0;
global.net_ev_flash = 0;
