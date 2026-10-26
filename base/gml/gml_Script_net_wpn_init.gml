for (var g = 0; g <= global.NET_WPN_MAX; g += 1)
{
    global.wpn_walk[g] = 40;
}
global.wpn_walk[0] = 22;
global.wpn_walk[1] = 34;
global.wpn_walk[2] = 15;
global.wpn_walk[3] = 29;
global.wpn_walk[4] = 12;
global.wpn_walk[5] = 20;
global.wpn_walk[6] = 17;
global.wpn_walk[7] = 37;
global.wpn_walk[8] = 39;
global.wpn_walk[9] = 47;
global.wpn_walk[10] = 26;
global.wpn_walk[11] = 33;
global.wpn_walk[12] = 25;
global.wpn_walk[13] = 30;
global.wpn_walk[14] = 31;
global.wpn_walk[15] = 10;
global.wpn_walk[16] = 27;
global.wpn_walk[17] = 16;
global.wpn_walk[18] = 24;
global.wpn_walk[19] = 38;
global.wpn_walk[20] = 44;
global.wpn_walk[21] = 18;
global.wpn_walk[22] = 28;
global.wpn_walk[23] = 13;
global.wpn_walk[24] = 32;
global.wpn_walk[25] = 35;
global.wpn_walk[26] = 41;
global.wpn_walk[27] = 54;
global.wpn_walk[28] = 53;
global.wpn_walk[29] = 23;
global.wpn_walk[39] = 1945;
global.wpn_walk[40] = 1990;
global.wpn_walk[41] = 2099;
global.wpn_walk[42] = 36;
for (var g = 0; g <= global.NET_WPN_MAX; g += 1)
{
    global.wpn_gun[g] = 0;
}
global.wpn_gun[0] = 1;
global.wpn_gun[1] = 1;
global.wpn_gun[6] = 1;
global.wpn_gun[7] = 1;
global.wpn_gun[9] = 1;
global.wpn_gun[10] = 1;
global.wpn_gun[11] = 1;
global.wpn_gun[12] = 1;
global.wpn_gun[25] = 1;
global.wpn_gun[27] = 1;
global.wpn_gun[28] = 1;
global.wpn_gun[29] = 1;
global.wpn_gun[39] = 1;
global.wpn_gun[40] = 1;
global.wpn_gun[41] = 1;
for (var g = 0; g <= global.NET_WPN_MAX; g += 1)
{
    var nm = sprite_get_name(global.wpn_walk[g]);
    if (global.wpn_walk[g] == 40)
    {
        nm = "Throw";
    }
    else if (string_pos("sprPWalk", nm) == 1)
    {
        nm = string_delete(nm, 1, 8);
    }
    else if (string_pos("sprJacketWalk", nm) == 1)
    {
        nm = string_delete(nm, 1, 13);
    }
    global.wpn_name[g] = nm;
}
