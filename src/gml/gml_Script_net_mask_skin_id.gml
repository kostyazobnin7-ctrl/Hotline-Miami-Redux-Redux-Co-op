/// net_mask_skin_id(skin)
// Скин маски для пакета: "" -> 0, "Skin" -> 1, "Hard" -> 2.
var s = argument0;
if (!is_string(s))
{
    return 0;
}
if (s == "Skin")
{
    return 1;
}
if (s == "Hard")
{
    return 2;
}
return 0;
