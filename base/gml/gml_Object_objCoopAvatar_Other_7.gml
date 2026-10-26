if (global.net_mode == global.NET_MODE_HOST && global.ps_state[pid] == global.NET_PS_ALIVE)
{
    scrPlayerAnimationEnd(0, 0, 0, 0, 0);
    net_avatar_wpn_sync();
}
