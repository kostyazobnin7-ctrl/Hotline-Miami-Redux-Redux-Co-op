for (var i = 0; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.pin_move[i] = 0;
    global.pin_aim[i] = 0;
    global.pin_btn[i] = 0;
    global.pin_seq[i] = -1;
    global.pin_t[i] = 0;
    global.pin_pick[i] = 0;
    global.pin_pick_done[i] = 0;
    global.pin_ack[i] = 0;
    global.pin_use_edge[i] = 0;
    global.pin_atk_edge[i] = 0;
    global.pin_debt[i] = 0; // v2.1: шаги, сделанные «в долг», пока ввод клиента не дошёл
    global.pe_exec[i] = -4;
    if (!global.pin_q_ready)
    {
        global.pin_q[i] = ds_list_create();
    }
    else
    {
        ds_list_clear(global.pin_q[i]);
    }
}
global.pin_q_ready = 1;
for (var i = 0; i < 256; i += 1)
{
    global.ih_move[i] = 0;
    global.ih_aim[i] = 0;
    global.ih_btn[i] = 0;
    global.ih_pick[i] = 0;
}
global.ih_count = 0;
global.net_in_seq = 0;
