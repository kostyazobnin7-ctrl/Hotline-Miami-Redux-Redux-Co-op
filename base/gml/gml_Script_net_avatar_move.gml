var m = argument0;
var l = (m & global.NET_IN_LEFT) != 0;
var r = (m & global.NET_IN_RIGHT) != 0;
var u = (m & global.NET_IN_UP) != 0;
var d = (m & global.NET_IN_DOWN) != 0;
if (l)
{
    if (myxspeed > -myspeed)
    {
        myxspeed -= 0.5;
    }
    else
    {
        myxspeed = -myspeed;
    }
}
if (r)
{
    if (myxspeed < myspeed)
    {
        myxspeed += 0.5;
    }
    else
    {
        myxspeed = myspeed;
    }
}
if (u)
{
    if (myyspeed > -myspeed)
    {
        myyspeed -= 0.5;
    }
    else
    {
        myyspeed = -myspeed;
    }
}
if (d)
{
    if (myyspeed < myspeed)
    {
        myyspeed += 0.5;
    }
    else
    {
        myyspeed = myspeed;
    }
}
if (!l && !r)
{
    if (myxspeed > 0)
    {
        myxspeed -= 0.5;
    }
    else if (myxspeed < -0.5)
    {
        myxspeed += 0.5;
    }
    else
    {
        myxspeed = 0;
    }
}
if (!u && !d)
{
    if (myyspeed > 0)
    {
        myyspeed -= 0.5;
    }
    else if (myyspeed < -0.5)
    {
        myyspeed += 0.5;
    }
    else
    {
        myyspeed = 0;
    }
}
scrMoveSolidOn();
while ((abs(myxspeed) + abs(myyspeed)) > (myspeed + 2))
{
    myxspeed *= 0.98;
    myyspeed *= 0.98;
}
if (myxspeed == 0 && myyspeed == 0)
{
    legindex = 0;
}
else
{
    legindex += ((abs(myxspeed) + abs(myyspeed)) * 0.1);
    if (image_speed == 0)
    {
        image_index += ((abs(myxspeed) + abs(myyspeed)) * 0.05);
    }
    legdir = point_direction(0, 0, myxspeed, myyspeed);
}
if (abs(myxspeed) > 0)
{
    if (place_free(x + myxspeed, y))
    {
        x += myxspeed;
    }
    else if (myyspeed == 0)
    {
        if (place_free(x + myxspeed, y - 8))
        {
            y -= myspeed;
        }
        else if (place_free(x + myxspeed, y + 8))
        {
            y += myspeed;
        }
        else
        {
            move_contact_solid(90 - (sign(myxspeed) * 90), abs(myxspeed));
            myxspeed = 0;
        }
    }
}
if (abs(myyspeed) > 0)
{
    if (place_free(x, y + myyspeed))
    {
        y += myyspeed;
    }
    else if (myxspeed == 0)
    {
        if (place_free(x - 8, y + myyspeed))
        {
            x -= myspeed;
        }
        else if (place_free(x + 8, y + myyspeed))
        {
            x += myspeed;
        }
        else
        {
            move_contact_solid(-sign(myyspeed) * 90, abs(myyspeed));
            myyspeed = 0;
        }
    }
}
x = clamp(x, -64, room_width + 64);
y = clamp(y, -64, room_height + 64);
scrMoveSolidOff();
