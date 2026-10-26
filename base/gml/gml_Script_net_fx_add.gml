if (global.fx_n >= global.NET_FX_MAX)
{
    exit;
}
if (argument0 == global.NET_FX_SOUND)
{
    var same = 0;
    for (var k = 0; k < global.fx_n; k += 1)
    {
        if (global.fx_kind[k] == global.NET_FX_SOUND && global.fx_a[k] == argument1)
        {
            same += 1;
        }
    }
    if (same >= 2)
    {
        exit;
    }
}
global.fx_kind[global.fx_n] = argument0;
global.fx_a[global.fx_n] = argument1;
global.fx_b[global.fx_n] = argument2;
global.fx_c[global.fx_n] = argument3;
global.fx_d[global.fx_n] = argument4;
global.fx_n += 1;
