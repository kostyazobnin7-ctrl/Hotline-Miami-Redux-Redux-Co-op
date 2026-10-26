/// net_prog_len(block)
// Размеры массивов прогресса (как в scrSaveUnlocked): 0 levels, 1 masks, 2 newgun, 3 letter.
if (argument0 == 0)
{
    return 24;
}
if (argument0 == 1)
{
    return 27;
}
return 16;
