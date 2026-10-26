/// net_skin_frame(src_spr, image_index, dst_spr)
// v1.8.2: кадр спрайта Байкера по доле анимации Джека (раньше mod — удар обрывался на середине).
var ns = max(1, sprite_get_number(argument0));
var nd = max(1, sprite_get_number(argument2));
if (argument0 == argument2)
{
    return argument1;
}
return floor(((argument1 mod ns) / ns) * nd) mod nd;
