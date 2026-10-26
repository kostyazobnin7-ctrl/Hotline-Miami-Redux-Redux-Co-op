var w = net_packet_begin(global.NET_MSG_SNAPSHOT);
buffer_write(w, buffer_u16, global.net_tick % 65536);
buffer_write(w, buffer_u16, room);
var cpos = buffer_tell(w);
buffer_write(w, buffer_u8, 0);
var n = 0;
if (global.ps_state[1] != global.NET_PS_ALIVE)
{
    var p = global.ps_body[1];
    if (p == -4 || !instance_exists(p))
    {
        p = global.net_dummy;
    }
    if (p != -4 && instance_exists(p))
    {
        with (p)
        {
            net_snap_write(w, 1, x, y, image_angle, sprite_index, image_index, 0, 0, 0, 0, 0);
        }
        n += 1;
    }
}
else if (net_player_inst(1) != -4)
{
    var p = net_player_inst(1);
    with (p)
    {
        if (net_player_has_vars(object_index))
        {
            var fl = global.NET_SF_LEGS;
            if (left < 0)
            {
                fl |= global.NET_SF_LEFT;
            }
            net_snap_write(w, 1, x, y, dir, sprite_index, image_index, legdir, legindex, fl, myxspeed, myyspeed);
        }
        else
        {
            net_snap_write(w, 1, x, y, image_angle, sprite_index, image_index, 0, 0, 0, 0, 0);
        }
    }
    n += 1;
}
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    var inst = global.av[i];
    if (global.pl_used[i] && inst != -4 && instance_exists(inst) && global.pe_exec[i] != -4 && instance_exists(global.pe_exec[i]))
    {
        with (global.pe_exec[i])
        {
            net_snap_write(w, i, x, y, image_angle, sprite_index, image_index, 0, 0, global.NET_SF_EXEC, 0, 0);
        }
        n += 1;
    }
    else if (global.pl_used[i] && inst != -4 && instance_exists(inst))
    {
        with (inst)
        {
            var fl = 0;
            if (legs)
            {
                fl |= global.NET_SF_LEGS;
            }
            if (left < 0)
            {
                fl |= global.NET_SF_LEFT;
            }
            net_snap_write(w, pid, x, y, dir, sprite_index, image_index, legdir, legindex, fl, myxspeed, myyspeed);
        }
        n += 1;
    }
}
buffer_poke(w, cpos, buffer_u8, n);
var size = buffer_tell(w);
for (var i = 2; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (global.pl_used[i])
    {
        net_transport_send(global.pl_ip[i], global.pl_port[i], w, size);
    }
}
global.net_snap_bytes = size;
