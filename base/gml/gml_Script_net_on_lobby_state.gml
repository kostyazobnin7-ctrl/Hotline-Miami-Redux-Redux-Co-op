var b = argument0;
var sz = argument1;
if (!net_from_host(argument2, argument3) || sz < 2)
{
    global.net_drops += 1;
    exit;
}
var n = buffer_read(b, buffer_u8);
if (n < 1 || n > global.NET_MAX_PLAYERS)
{
    global.net_drops += 1;
    exit;
}
var tmp_id, tmp_nick, tmp_flags;
for (var k = 0; k < n; k += 1)
{
    if ((buffer_tell(b) + 3) > sz)
    {
        global.net_drops += 1;
        exit;
    }
    var pid = buffer_read(b, buffer_u8);
    var flags = buffer_read(b, buffer_u8);
    var nick = net_clean_nick(buffer_read(b, buffer_string));
    if (pid < 1 || pid > global.NET_MAX_PLAYERS)
    {
        global.net_drops += 1;
        exit;
    }
    tmp_id[k] = pid;
    tmp_flags[k] = flags;
    tmp_nick[k] = nick;
}
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    global.pl_used[i] = 0;
}
for (var k = 0; k < n; k += 1)
{
    var pid = tmp_id[k];
    global.pl_used[pid] = 1;
    global.pl_ip[pid] = "";
    global.pl_port[pid] = 0;
    global.pl_name[pid] = tmp_nick[k];
    global.pl_ready[pid] = (tmp_flags[k] & global.NET_PF_READY) != 0;
    global.pl_host[pid] = (tmp_flags[k] & global.NET_PF_HOST) != 0;
}
if (n != global.net_lobby_count)
{
    net_log("лобби: игроков " + string(n));
}
global.net_lobby_count = n;
