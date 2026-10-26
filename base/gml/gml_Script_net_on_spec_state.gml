var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 2)
{
    global.net_drops += 1;
    exit;
}
var n = buffer_read(b, buffer_u8);
if (n > global.NET_MAX_PLAYERS || sz < (2 + (n * 6)))
{
    global.net_drops += 1;
    exit;
}
for (var k = 0; k < n; k += 1)
{
    var pid = buffer_read(b, buffer_u8);
    var st = buffer_read(b, buffer_u8);
    var tm = buffer_read(b, buffer_u16);
    var obs = buffer_read(b, buffer_u8);
    var cause = buffer_read(b, buffer_u8);
    if (pid < 1 || pid > global.NET_MAX_PLAYERS || st > 2)
    {
        continue;
    }
    global.ps_state[pid] = st;
    global.ps_timer[pid] = tm;
    global.ps_observers[pid] = obs;
    global.ps_cause[pid] = cause;
}
