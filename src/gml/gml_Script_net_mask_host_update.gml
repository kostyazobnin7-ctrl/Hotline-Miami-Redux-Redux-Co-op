/// net_mask_host_update()
// ХОСТ: своя маска (P1) для FLOW. Маски клиентов приходят пакетом MASK.
if (global.net_mode != global.NET_MODE_HOST)
{
    exit;
}
if (global.maskon == 1 && global.maskindex >= 0 && global.maskindex < 255)
{
    global.pl_mask[1] = global.maskindex;
    global.pl_mskin[1] = net_mask_of(global.maskindex);
}
else
{
    global.pl_mask[1] = 255;
}
