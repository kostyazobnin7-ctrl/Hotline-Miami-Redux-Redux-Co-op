/// net_mask_client_step()
// КЛИЕНТ, каждый тик в комнате хоста:
//  - после перезапуска уровня открывает выбор маски (как при старте уровня в оригинале);
//  - когда выбор подтверждён — пишет pl_mask и шлёт хосту (MASK раз в секунду из lobby_extra).
// v2.2.2 / bug3: подтверждение берёт global.maskindex (KeyPress_13), не dummy.maskindex.
var me = global.net_my_pid;
if (me <= 0)
{
    exit;
}
net_mask_pick_step();
var open = net_mask_menu_open();
// подтверждение: меню ещё есть, но выбор закрыт (если меню исчезло при смене комнаты — выбора не было)
if (global.net_mask_menu_was && !open && instance_exists(objMaskMenu))
{
    // KeyPress_13: global.maskindex = select (в т.ч. 0 = Richard)
    var mk = clamp(round(global.maskindex), 0, 254);
    // запасной: select меню, если maskindex вдруг не записался
    with (objMaskMenu)
    {
        if (select >= 0 && select <= 26)
        {
            // select — позиция колеса в момент Enter; совпадает с maskindex после KeyPress
            if (global.maskindex < 0 || global.maskindex >= 255)
            {
                mk = clamp(round(select), 0, 254);
            }
        }
    }
    global.pl_mask[me] = mk;
    global.pl_mskin[me] = net_mask_of(mk);
    global.net_mask_confirmed = 1;
    global.net_mask_sent_t = 0;
    var d = global.net_dummy;
    if (d != -4 && instance_exists(d))
    {
        d.maskindex = mk;
        d.maskon = 1;
    }
    net_log("маска: выбрана " + string(global.pl_mask[me]));
}
global.net_mask_menu_was = open;
// отправка маски хосту — в net_lobby_extra_update (v1.7)
