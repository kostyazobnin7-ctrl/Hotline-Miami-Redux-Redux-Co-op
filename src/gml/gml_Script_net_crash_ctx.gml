/// net_crash_ctx()
// v1.9, каждый шаг objCoopNet: раз в секунду и при смене комнаты — снимок состояния в
// coop_context.txt (после вылета из него собирается coop_crash_log.txt).
// v2.2: версия мода, дата и время, последние 40 событий журнала и 16 сетевых пакетов.
if ((current_time - global.crash_t) < 1000 && room == global.crash_room)
{
    exit;
}
global.crash_t = current_time;
global.crash_room = room;
var f = file_text_open_write(working_directory + chr(92) + "coop_context.txt");
var ln;
ln[0] = "мод " + global.COOP_VERSION + ", протокол " + string(global.NET_PROTO) + ", снимок " + date_datetime_string(date_current_datetime()) + " (" + string(current_time) + " мс от запуска)";
ln[1] = "режим " + string(global.net_mode) + " (0 нет, 1 хост, 2 клиент), связь " + string(global.net_conn) + ", игра идёт " + string(global.net_started) + ", я P" + string(global.net_my_pid);
ln[2] = "комната " + room_get_name(room) + ", комната хоста " + string(global.net_host_room) + ", level " + string(global.level) + ", done " + string(global.done) + ", маска " + string(global.maskindex) + " вкл " + string(global.maskon);
var n = 3;
for (var i = 1; i <= global.NET_MAX_PLAYERS; i += 1)
{
    if (i >= 2 && !global.pl_used[i])
    {
        continue;
    }
    ln[n] = "P" + string(i) + " '" + string(global.pl_name[i]) + "' состояние " + string(global.ps_state[i]) + " скин " + string(global.pl_skin[i]) + " оружие " + string(global.pw_wpn[i]) + " казнь " + string(global.pe_exec[i]) + " пинг " + string(net_pl_rtt(i));
    n += 1;
}
var s = "objPlayer и дочерние:";
with (objPlayer)
{
    s += " " + object_get_name(object_index) + "#" + string(id);
    if (id == global.net_dummy)
    {
        s += "(манекен)";
    }
    if (sprite_exists(sprite_index))
    {
        s += "[" + sprite_get_name(sprite_index) + "]";
    }
}
ln[n] = s;
n += 1;
ln[n] = "врагов " + string(instance_number(objEnemy)) + ", лежат " + string(instance_number(objKnockedOut)) + ", боссов " + string(instance_number(objBoss)) + ", аватаров " + string(instance_number(objCoopAvatar)) + ", эффектор " + string(instance_exists(objEffector));
n += 1;
ln[n] = "";
n += 1;
ln[n] = "--- последние события ---";
n += 1;
for (var k = 0; k < ds_list_size(global.crash_ring); k += 1)
{
    ln[n] = ds_list_find_value(global.crash_ring, k);
    n += 1;
}
ln[n] = "";
n += 1;
ln[n] = "--- последние сетевые пакеты (> отправлен, < получен) ---";
n += 1;
for (var k = 0; k < 16; k += 1)
{
    var pk = global.cr_pk[(global.cr_pk_h + k) % 16];
    if (pk != "")
    {
        ln[n] = pk;
        n += 1;
    }
}
for (var k = 0; k < n; k += 1)
{
    file_text_write_string(f, ln[k]);
    file_text_writeln(f);
}
file_text_close(f);
