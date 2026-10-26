var a = argument0;
var r = -4;
with (objTransitioner)
{
    if (r == -4 && solid == 0 && place_meeting(x, y, a))
    {
        r = id;
    }
}
with (objTeleporter)
{
    if (r == -4 && place_meeting(x, y, a))
    {
        r = id;
    }
}
if (global.done == 1 && global.gotbeaten == 0)
{
    with (objPlayerCarEnter)
    {
        if (r == -4 && place_meeting(x, y, a))
        {
            r = id;
        }
    }
    with (objElevator)
    {
        if (r == -4 && place_meeting(x, y, a))
        {
            r = id;
        }
    }
    with (objHospitalElevator)
    {
        if (r == -4 && place_meeting(x, y, a))
        {
            r = id;
        }
    }
    with (objLadder)
    {
        if (r == -4 && place_meeting(x - 8, y, a))
        {
            r = id;
        }
    }
    with (objManhole)
    {
        if (r == -4 && place_meeting(x + 4, y, a))
        {
            r = id;
        }
    }
}
return r;
