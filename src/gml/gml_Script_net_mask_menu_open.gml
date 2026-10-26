/// net_mask_menu_open()
// Открыт ли выбор маски (objMaskMenu ещё не подтверждён).
var r = 0;
with (objMaskMenu)
{
    if (on == 1)
    {
        r = 1;
    }
}
return r;
