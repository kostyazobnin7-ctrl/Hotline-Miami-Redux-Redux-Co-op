if (ecount > 0 && argument0 <= et[0])
{
    if (argument0 == et[0])
    {
        ex[0] = argument1;
        ey[0] = argument2;
        ea[0] = argument3;
    }
    exit;
}
var k = min(ecount, global.NET_ENT_BUF - 1);
while (k > 0)
{
    et[k] = et[k - 1];
    ex[k] = ex[k - 1];
    ey[k] = ey[k - 1];
    ea[k] = ea[k - 1];
    k -= 1;
}
et[0] = argument0;
ex[0] = argument1;
ey[0] = argument2;
ea[0] = argument3;
ecount = min(ecount + 1, global.NET_ENT_BUF);
if (ecount == 1)
{
    x = argument1;
    y = argument2;
    ang = argument3;
}
