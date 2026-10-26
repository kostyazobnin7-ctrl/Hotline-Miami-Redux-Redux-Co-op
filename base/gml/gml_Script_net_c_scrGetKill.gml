if ((argument0 == 20 || argument0 == 68) && global.maskindex == 6)
{
    global.usedkill[3] = 1;
    return 1163;
}
if (argument0 == 20 || argument0 == 68)
{
    global.usedkill[3] = 1;
    return 29;
}
if (argument0 == 547 || argument0 == 551)
{
    global.usedkill[3] = 1;
    return 84;
}
if (argument0 == 24 || argument0 == 71)
{
    global.usedkill[10] = 1;
    return 30;
}
if (argument0 == 13 || argument0 == 60)
{
    global.usedkill[14] = 1;
    return 17;
}
if (argument0 == 38 || argument0 == 86)
{
    global.usedkill[11] = 1;
    return 36;
}
if (argument0 == 12 || argument0 == 59 || argument0 == 15 || argument0 == 62 || argument0 == 75 || argument0 == 28 || argument0 == 79 || argument0 == 32 || argument0 == 29 || argument0 == 76 || argument0 == 11 || argument0 == 56)
{
    return 14;
}
if (argument0 == 10 || argument0 == 55)
{
    global.usedkill[7] = 1;
    return 12;
}
if (argument0 == 39 || argument0 == 87)
{
    global.usedkill[4] = 1;
    return 37;
}
if (argument0 == 31 || argument0 == 78)
{
    global.usedkill[6] = 1;
    return 20;
}
if (argument0 == 30 || argument0 == 77)
{
    global.usedkill[5] = 1;
    return 34;
}
if (argument0 == 18 || argument0 == 66)
{
    global.usedkill[12] = 1;
    return 23;
}
if (argument0 == 27 || argument0 == 74)
{
    global.usedkill[8] = 1;
    return 14;
}
if (argument0 == 16 || argument0 == 63)
{
    return 31;
}
if (argument0 == 41 || argument0 == 63)
{
    return 32;
}
if (argument0 == 40)
{
    if (global.net_atk.throwindex == 0)
    {
        global.usedkill[16] = 1;
        return 35;
    }
    if (global.net_atk.throwindex == 2)
    {
        global.usedkill[16] = 1;
        return 1172;
    }
    if (global.net_atk.throwindex == 1)
    {
        global.usedkill[17] = 1;
        return 1191;
    }
    if (global.net_atk.throwindex == 6)
    {
        global.usedkill[20] = 1;
        return 22;
    }
    if (global.net_atk.throwindex == 5)
    {
        global.usedkill[19] = 1;
        return 24;
    }
    if (global.net_atk.throwindex == 3)
    {
        global.usedkill[18] = 1;
        return 19;
    }
    if (global.net_atk.throwindex == 4)
    {
        global.usedkill[18] = 1;
        return 1173;
    }
}
if ((argument0 == 26 || argument0 == 72) && global.net_atk.ammo > 0)
{
    return 1093;
}
if ((argument0 == 53 || argument0 == 85) && global.net_atk.ammo > 0 && global.net_atk.ammo > 0 && global.maskindex == 3)
{
    return 1095;
}
if ((argument0 == 37 || argument0 == 84) && global.net_atk.ammo > 0)
{
    return 1102;
}
if ((argument0 == 47 || argument0 == 92) && global.net_atk.ammo > 0)
{
    return 1094;
}
if ((argument0 == 25 || argument0 == 73) && global.net_atk.ammo > 0)
{
    return 1099;
}
if ((argument0 == 33 || argument0 == 81) && global.net_atk.ammo > 0)
{
    return 1100;
}
if ((argument0 == 34 || argument0 == 82 || argument0 == 1982 || argument0 == 1983) && global.maskindex == 3)
{
    return 1101;
}
if ((argument0 == 22 || argument0 == 69) && global.maskindex == 3)
{
    return 1098;
}
if ((argument0 == 17 || argument0 == 64) && global.net_atk.ammo > 0)
{
    return 1096;
}
if ((argument0 == 23 || argument0 == 70) && global.net_atk.ammo > 0 && global.maskindex == 3)
{
    return 1097;
}
if ((argument0 == 1945 || argument0 == 1943) && global.net_atk.ammo > 0 && global.maskindex == 3)
{
    return 1103;
}
if ((argument0 == 2099 || argument0 == 2098) && global.net_atk.ammo > 0 && global.maskindex == 3)
{
    return 1178;
}
if (argument0 == 36 || argument0 == 88)
{
    global.usedkill[8] = 1;
    return 1177;
}
global.test = 1;
if (global.maskindex == 2)
{
    global.test = 1;
    return 39;
}
return 8;
