with (objDoorV)
{
    if (place_meeting(x, y, other))
    {
        event_perform(ev_collision, objPlayer);
    }
}
