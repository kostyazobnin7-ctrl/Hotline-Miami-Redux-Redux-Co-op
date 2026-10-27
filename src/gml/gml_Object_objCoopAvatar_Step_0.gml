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
                // v2.0: Мартин — стоящего врага бьёт головой (вместо захвата за горло), лежащих казнит
                var hb = 0;
                if (net_martin(pid) && reload <= 0)
                {
                    hb = net_martin_headbutt(id, pid);
                    if (hb)
                    {
                        reload = 20;
                        sprite_index = sprPigButcherHeadButt;
                        image_index = 0;
                        image_speed = 0.4;
                    }
                }
                if (!hb)
                {
                    net_avatar_execute();
                }
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
