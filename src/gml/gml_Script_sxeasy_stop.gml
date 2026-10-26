// v1.4.4: см. net_music_hook
if (net_music_hook(0, ""))
{
    exit;
}
if (audio_is_playing(musJamPacked))
{
    audio_stop_sound(musJamPacked);
}
audio_stop_sound(global.currentsong);
