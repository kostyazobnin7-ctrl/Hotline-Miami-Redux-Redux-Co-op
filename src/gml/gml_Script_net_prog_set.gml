/// net_prog_set(block, index)
// Открыть элемент прогресса (= 1): 0 levels, 1 masks, 2 newgun, 3 letter.
var k = argument1;
if (argument0 == 0)
{
    global.levels[k] = 1;
}
else if (argument0 == 1)
{
    global.masks[k] = 1;
}
else if (argument0 == 2)
{
    global.newgun[k] = 1;
}
else
{
    global.letter[k] = 1;
}
