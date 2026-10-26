/// net_mask_draw(pid)
// Аватар (Draw): маска игрока поверх головы.
var mk = global.pl_mask[argument0];
if (mk == 255)
{
    exit;
}
var sn = "sprMasks";
if (global.pl_mskin[argument0] == 1)
{
    sn = "sprMasksSkin";
}
else if (global.pl_mskin[argument0] == 2)
{
    sn = "sprMasksHard";
}
var spr = asset_get_index(sn);
if (spr < 0)
{
    spr = asset_get_index("sprMasks");
}
if (spr < 0 || mk >= sprite_get_number(spr))
{
    exit;
}
draw_sprite_ext(spr, mk, x + 1, y + 1, 1, 1, dir, c_black, 0.25);
draw_sprite_ext(spr, mk, x, y, 1, 1, dir, c_white, 1);
