/// net_biker(pid)
// v1.8: игрок pid — клиент, выбравший Байкера (у хоста всегда Джек).
var p = argument0;
return p >= 2 && p <= global.NET_MAX_PLAYERS && global.pl_skin[p] == 1;
