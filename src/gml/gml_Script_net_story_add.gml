/// net_story_add(kind, a, b, c, d, e, f)
// ХОСТ: записать сюжетное событие в кольцо; net_story_send повторяет его ST_KEEP тиков.
global.st_seq = (global.st_seq % 65535) + 1;
var k = global.st_seq % global.ST_RING;
global.st_r_seq[k] = global.st_seq;
global.st_r_tick[k] = global.net_tick;
global.st_r_room[k] = room;
global.st_r_kind[k] = argument0;
global.st_r_a[k] = argument1;
global.st_r_b[k] = argument2;
global.st_r_c[k] = argument3;
global.st_r_d[k] = argument4;
global.st_r_e[k] = argument5;
global.st_r_f[k] = argument6;
