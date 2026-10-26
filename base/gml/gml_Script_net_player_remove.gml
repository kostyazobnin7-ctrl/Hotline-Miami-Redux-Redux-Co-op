var pid = argument0;
if (pid < 2 || pid > global.NET_MAX_PLAYERS || !global.pl_used[pid])
{
    exit;
}
net_log("игрок " + string(pid) + " '" + global.pl_name[pid] + "' освободил слот: " + argument1);
global.pl_used[pid] = 0;
global.pl_ip[pid] = "";
global.pl_port[pid] = 0;
global.pl_name[pid] = "";
global.pl_ready[pid] = 0;
global.pl_host[pid] = 0;
