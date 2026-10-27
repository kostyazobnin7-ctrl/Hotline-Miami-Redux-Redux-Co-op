/// net_crash_pkt(dir, type, size)
// v2.2: последние 16 сетевых пакетов (направление, тип, размер, время) для журнала вылета.
var h = global.cr_pk_h;
global.cr_pk[h] = string(current_time) + " " + argument0 + " " + net_crash_pkt_name(argument1) + " " + string(argument2) + "b";
global.cr_pk_h = (h + 1) % 16;
