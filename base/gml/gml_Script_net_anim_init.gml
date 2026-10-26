global.anim_spr[0] = 45;
global.anim_map = ds_map_create();
var n = 1;
for (var i = 0; sprite_exists(i); i += 1)
{
    var nm = sprite_get_name(i);
    if (string_pos("sprP", nm) == 1 || string_pos("sprBiker", nm) == 1 || string_pos("sprGriffin", nm) == 1 || string_pos("sprPig", nm) == 1 || string_pos("sprShield", nm) == 1 || string_pos("sprMC", nm) == 1 || string_pos("sprJacket", nm) == 1 || string_pos("sprAubrey", nm) == 1 || string_pos("sprDennis", nm) == 1)
    {
        global.anim_spr[n] = i;
        ds_map_add(global.anim_map, i, n);
        n += 1;
    }
}
global.anim_count = n;
