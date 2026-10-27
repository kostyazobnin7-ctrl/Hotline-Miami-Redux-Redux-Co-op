/// net_host_dedupe()
// v2.1.1, ХОСТ (End Step): хост и клиент ударили одного врага в одном кадре — каждый удар
// мог сделать из него своё тело (objKnockedOut / objDeadBody / objECrawl): два трупа, а
// нокаутированный потом вставал дважды. Новые тела этого кадра в одной точке — лишние удаляем.
if (global.net_mode != global.NET_MODE_HOST || !global.net_started)
{
    exit;
}
ds_list_clear(global.dd_new);
with (objKnockedOut)
{
    if (!ds_map_exists(global.dd_map, id))
    {
        ds_list_add(global.dd_new, id);
    }
}
with (objDeadBody)
{
    if (!ds_map_exists(global.dd_map, id))
    {
        ds_list_add(global.dd_new, id);
    }
}
with (objECrawl)
{
    if (!ds_map_exists(global.dd_map, id))
    {
        ds_list_add(global.dd_new, id);
    }
}
var n = ds_list_size(global.dd_new);
for (var i = 0; i < n; i += 1)
{
    var a = ds_list_find_value(global.dd_new, i);
    if (!instance_exists(a))
    {
        continue;
    }
    for (var j = i + 1; j < n; j += 1)
    {
        var b = ds_list_find_value(global.dd_new, j);
        if (instance_exists(b) && abs(a.x - b.x) < 1 && abs(a.y - b.y) < 1)
        {
            net_log("двойник врага убран: " + object_get_name(b.object_index) + " (оставлен " + object_get_name(a.object_index) + ")");
            global.dd_count += 1;
            with (b)
            {
                instance_destroy();
            }
        }
    }
    ds_map_replace(global.dd_map, a, 1);
}
