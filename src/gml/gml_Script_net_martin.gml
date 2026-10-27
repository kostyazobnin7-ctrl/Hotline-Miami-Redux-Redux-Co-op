/// net_martin(pid)
// v2.0: игрок pid играет за Мартина Брауна (Мясника-свинью).
var p = argument0;
return p >= 1 && p <= global.NET_MAX_PLAYERS && global.pl_skin[p] == 2;
