/// net_on_mask(buf, size, ip, port)
// ХОСТ: маска клиента (u8 маска, u8 скин); расходится всем в FLOW.
if (global.net_mode != global.NET_MODE_HOST || argument1 < 3)
{
    global.net_drops += 1;
    exit;
}
var pid = net_player_find(argument2, argument3);
if (pid < 2)
{
    global.net_drops += 1;
    exit;
}
var mk = buffer_read(argument0, buffer_u8);
var sk = buffer_read(argument0, buffer_u8);
if (global.pl_mask[pid] != mk || global.pl_mskin[pid] != sk)
{
    net_log("P" + string(pid) + " маска " + string(mk));
}
global.pl_mask[pid] = mk;
global.pl_mskin[pid] = sk;
