/// net_mask_of(maskindex)
// Скин выбранной маски этого компьютера (global.skinmask[]) для пакета.
var mi = argument0;
if (!is_array(global.skinmask) || mi < 0 || mi >= array_length_1d(global.skinmask))
{
    return 0;
}
return net_mask_skin_id(global.skinmask[mi]);
