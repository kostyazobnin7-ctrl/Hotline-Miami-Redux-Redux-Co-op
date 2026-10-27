/// net_crash_note(text)
// v2.2: «чёрный ящик» — последние 40 событий кооператива (строки журнала). Попадают в
// coop_context.txt раз в секунду, после вылета — в coop_crash_log.txt.
ds_list_add(global.crash_ring, string(argument0));
while (ds_list_size(global.crash_ring) > 40)
{
    ds_list_delete(global.crash_ring, 0);
}
