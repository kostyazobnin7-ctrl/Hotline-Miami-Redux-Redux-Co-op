var s = argument0;
var ok = argument1;
var out = "";
for (var i = 1; i <= string_length(s); i += 1)
{
    var c = string_char_at(s, i);
    if (string_pos(c, ok) > 0)
    {
        out += c;
    }
}
if (string_length(out) > argument2)
{
    out = string_copy(out, 1, argument2);
}
return out;
