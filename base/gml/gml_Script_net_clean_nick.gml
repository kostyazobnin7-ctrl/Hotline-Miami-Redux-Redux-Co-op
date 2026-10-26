var s = string(argument0);
s = string_replace_all(s, "#", " ");
if (string_length(s) > global.NET_NICK_MAX)
{
    s = string_copy(s, 1, global.NET_NICK_MAX);
}
if (string_length(s) == 0)
{
    s = "Player";
}
return s;
