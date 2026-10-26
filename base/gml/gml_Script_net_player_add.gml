var pid = argument0;
global.pl_used[pid] = 1;
global.pl_ip[pid] = argument1;
global.pl_port[pid] = argument2;
global.pl_name[pid] = argument3;
global.pl_ready[pid] = 0;
global.pl_host[pid] = argument4;
if (global.net_mode == global.NET_MODE_HOST)
{
    net_log("игрок " + string(pid) + " '" + argument3 + "' занял слот (" + argument1 + ":" + string(argument2) + ")");
}
