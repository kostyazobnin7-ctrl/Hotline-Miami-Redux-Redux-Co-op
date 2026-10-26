/// net_mask_client_step()
// КЛИЕНТ, каждый тик в комнате хоста:
//  - после перезапуска уровня открывает выбор маски (как при старте уровня в оригинале);
//  - когда выбор подтверждён — шлёт маску хосту (пакет MASK), потом повторяет раз в секунду.
var me = global.net_my_pid;
if (me <= 0)
{
    exit;
}
net_mask_pick_step();
var open = net_mask_menu_open();
var d = global.net_dummy;
// подтверждение: меню ещё есть, но выбор закрыт (если меню исчезло при смене комнаты — выбора не было)
if (global.net_mask_menu_was && !open && instance_exists(objMaskMenu) && d != -4 && instance_exists(d))
{
    global.pl_mask[me] = clamp(round(d.maskindex), 0, 254);
    global.pl_mskin[me] = net_mask_of(global.pl_mask[me]);
    global.net_mask_sent_t = 0;
    net_log("маска: выбрана " + string(global.pl_mask[me]));
}
global.net_mask_menu_was = open;
if (global.pl_mask[me] != 255 && (current_time - global.net_mask_sent_t) >= 1000)
{
    global.net_mask_sent_t = current_time;
    var w = net_packet_begin(global.NET_MSG_MASK);
    buffer_write(w, buffer_u8, global.pl_mask[me]);
    buffer_write(w, buffer_u8, global.pl_mskin[me]);
    net_transport_send(global.net_host_ip, global.net_port, w, buffer_tell(w));
}
