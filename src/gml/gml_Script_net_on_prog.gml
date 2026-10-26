/// net_on_prog(buf, size, ip, port)
// v1.6, КЛИЕНТ: прогресс хоста. Первый пакет сессии — точка отсчёта; всё, что хост открыл
// после неё (пройденные в коопе уровни, найденные маски...), открывается и у клиента
// и сохраняется в его saves.dat. Старый прогресс хоста клиенту не передаётся.
var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || global.net_mode != global.NET_MODE_CLIENT)
{
    global.net_drops += 1;
    exit;
}
var first = (global.prog_sess != global.net_session);
global.prog_sess = global.net_session;
var changed = 0;
for (var blk = 0; blk < 4; blk += 1)
{
    if ((buffer_tell(b) + 1) > sz)
    {
        exit;
    }
    var n = buffer_read(b, buffer_u8);
    for (var k = 0; k < n && (buffer_tell(b) + 1) <= sz; k += 1)
    {
        var v = buffer_read(b, buffer_u8);
        var key = (blk * 64) + k;
        if (first)
        {
            global.prog_base[key] = v;
        }
        else if (v && !global.prog_base[key] && net_prog_get(blk, k) == 0)
        {
            net_prog_set(blk, k);
            changed += 1;
        }
    }
}
if (changed > 0)
{
    with (objCoopNet)
    {
        scrSaveUnlocked();
    }
    net_log("прогресс: открыто от хоста " + string(changed) + ", сохранено");
}
