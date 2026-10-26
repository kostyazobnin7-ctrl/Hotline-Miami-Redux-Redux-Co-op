// v1.4.4: в сетевой игре музыку выбирает хост (FLOW), у клиента свои вызовы игры игнорируются
if (net_music_hook(1, argument0))
{
    exit;
}
if (file_exists(working_directory + "\restartmusic"))
{
    nothing = 1;
}
else
{
    audio_stop_sound(global.currentsong);
}
var lastsong = global.currentsong;
thissong = string_replace(argument0, "mp3", "ogg");
global.currentsong = audio_create_stream(thissong);
if (global.holiday == 2 && argument0 == global.Paris2)
{
    net_snd(127, 100, 1);
}
else
{
    net_snd(global.currentsong, 100, 1);
}
c_print("Played music " + string(argument0), 65535);
audio_sound_gain(global.currentsong, global.mvol, 0);
if (string(lastsong) == "")
{
    nothing = 1;
}
else if (file_exists(working_directory + "\restartmusic"))
{
    nothing = 1;
}
else
{
    audio_destroy_stream(lastsong);
}
if (is_string(argument0))
{
    _intendedSong = argument0;
}
else
{
    _intendedSong = "Static.mp3";
}
