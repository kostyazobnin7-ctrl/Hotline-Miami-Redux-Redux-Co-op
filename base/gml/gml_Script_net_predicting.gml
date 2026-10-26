var p = argument0;
return global.NET_PREDICT && global.net_mode == global.NET_MODE_CLIENT && p == global.net_my_pid && global.ps_state[p] == global.NET_PS_ALIVE && (global.sn_flags[p] & global.NET_SF_EXEC) == 0 && global.av[p] != -4 && instance_exists(global.av[p]);
