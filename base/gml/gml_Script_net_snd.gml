var r = audio_play_sound(argument0, argument1, argument2);
if (global.net_mode == global.NET_MODE_HOST && global.net_started && !argument2 && global.fx_on)
{
    net_fx_add(global.NET_FX_SOUND, argument0, 0, 0, 0);
}
return r;
