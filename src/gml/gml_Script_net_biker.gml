/// net_biker(pid)
// v1.8.1: игрок pid играет за Байкера (pid 1 — хост, тоже может).
var p = argument0;
return p >= 1 && p <= global.NET_MAX_PLAYERS && global.pl_skin[p] == 1;
