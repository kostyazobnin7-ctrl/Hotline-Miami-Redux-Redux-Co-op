/// net_prog_get(block, index)
// Значение прогресса: 0 levels, 1 masks, 2 newgun, 3 letter. Нет массива — 0.
var k = argument1;
var a = 0;
if (argument0 == 0)
{
    a = global.levels;
}
else if (argument0 == 1)
{
    a = global.masks;
}
else if (argument0 == 2)
{
    a = global.newgun;
}
else
{
    a = global.letter;
}
if (!is_array(a) || k >= array_length_1d(a))
{
    return 0;
}
return a[k];
