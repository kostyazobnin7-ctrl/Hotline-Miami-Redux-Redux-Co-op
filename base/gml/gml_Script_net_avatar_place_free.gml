if (place_free(x, y))
{
    exit;
}
for (var r = 16; r <= 64; r += 16)
{
    for (var a = 0; a < 360; a += 45)
    {
        var nx = x + lengthdir_x(r, a + (pid * 30));
        var ny = y + lengthdir_y(r, a + (pid * 30));
        if (place_free(nx, ny))
        {
            x = nx;
            y = ny;
            exit;
        }
    }
}
