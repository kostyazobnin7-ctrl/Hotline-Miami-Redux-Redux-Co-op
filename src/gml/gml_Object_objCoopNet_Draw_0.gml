net_downed_world();
// v1.8: казни клиентов-Байкеров (хост)
if (global.net_mode == global.NET_MODE_HOST && global.net_started)
{
    for (var bi = 2; bi <= global.NET_MAX_PLAYERS; bi += 1)
    {
        if (net_biker(bi) && global.pe_exec[bi] != -4 && instance_exists(global.pe_exec[bi]))
        {
            net_biker_exec_draw(global.pe_exec[bi]);
        }
    }
}
