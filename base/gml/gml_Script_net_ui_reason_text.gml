var r = argument1;
if (argument0)
{
    if (r == global.NET_REJECT_FULL)
    {
        return "LOBBY FULL";
    }
    if (r == global.NET_REJECT_VERSION)
    {
        return "VERSION MISMATCH";
    }
    if (r == global.NET_REJECT_STARTED)
    {
        return "GAME ALREADY STARTED";
    }
    if (r == global.NET_REJECT_TIMEOUT)
    {
        return "HOST DOES NOT ANSWER";
    }
    return "CODE " + string(r);
}
if (r == global.NET_LEAVE_HOST_QUIT)
{
    return "HOST LEFT THE GAME";
}
if (r == global.NET_LEAVE_KICKED)
{
    return "YOU WERE REMOVED FROM THE GAME";
}
return "CONNECTION TO HOST LOST";
