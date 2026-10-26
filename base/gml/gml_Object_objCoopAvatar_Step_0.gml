if (global.net_mode == global.NET_MODE_HOST)
{
    if (global.ps_state[pid] == global.NET_PS_ALIVE)
    {
        if (global.pe_exec[pid] != -4)
        {
            net_avatar_exec_step();
        }
        else
        {
            net_avatar_simulate();
            net_avatar_attack();
            net_avatar_doors();
            if (global.pin_use_edge[pid])
            {
                global.pin_use_edge[pid] = 0;
                net_avatar_execute();
            }
            global.pin_atk_edge[pid] = 0;
        }
        net_avatar_hits();
    }
    else
    {
        net_avatar_body_step();
        if (ds_list_size(global.pin_q[pid]) > 0)
        {
            global.pin_ack[pid] = global.pin_seq[pid];
            ds_list_clear(global.pin_q[pid]);
        }
    }
}
else if (!net_predicting(pid))
{
    net_avatar_interpolate();
}
