var c = argument0;
if (c == global.NET_CAUSE_SHOT)
{
    return "застрелен";
}
if (c == global.NET_CAUSE_CUT)
{
    return "зарезан";
}
if (c == global.NET_CAUSE_EXPLODED)
{
    return "взорван";
}
if (c == global.NET_CAUSE_BEATEN)
{
    return "избит";
}
return "убит";
