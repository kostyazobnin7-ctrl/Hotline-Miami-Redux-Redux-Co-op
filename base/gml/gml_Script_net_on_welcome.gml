var b = argument0;
if (!net_from_host(argument2, argument3) || argument1 < 6)
{
    global.net_drops += 1;
    exit;
}
var pid = buffer_read(b, buffer_u8);
var sess = buffer_read(b, buffer_u32);
if (pid < 2 || pid > global.NET_MAX_PLAYERS)
{
    global.net_drops += 1;
    exit;
}
if (global.net_conn == global.NET_CONN_CONNECTED && pid == global.net_my_pid && sess == global.net_session)
{
    exit;
}
global.net_my_pid = pid;
global.net_session = sess;
global.net_conn = global.NET_CONN_CONNECTED;
net_log("принят хостом: player_id " + string(pid) + ", сессия " + string(sess));
