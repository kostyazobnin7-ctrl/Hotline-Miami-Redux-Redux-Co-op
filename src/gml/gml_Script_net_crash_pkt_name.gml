/// net_crash_pkt_name(type)
// v2.2: имя типа пакета для журнала вылета.
var t = argument0;
var nm = "";
switch (t)
{
    case 1: nm = "HELLO"; break;
    case 2: nm = "WELCOME"; break;
    case 3: nm = "REJECT"; break;
    case 4: nm = "SLOT_REQ"; break;
    case 5: nm = "READY"; break;
    case 6: nm = "LOBBY"; break;
    case 7: nm = "PING"; break;
    case 8: nm = "PONG"; break;
    case 9: nm = "LEAVE"; break;
    case 10: nm = "START"; break;
    case 11: nm = "INPUT"; break;
    case 12: nm = "SNAPSHOT"; break;
    case 13: nm = "WORLD"; break;
    case 14: nm = "PEVENT"; break;
    case 15: nm = "RESTART_CD"; break;
    case 16: nm = "LEVEL_RESTART"; break;
    case 17: nm = "SPEC_STATE"; break;
    case 18: nm = "SPEC_TARGET"; break;
    case 19: nm = "ENTS"; break;
    case 20: nm = "HUD"; break;
    case 21: nm = "FX"; break;
    case 22: nm = "DOORS"; break;
    case 23: nm = "STORY"; break;
    case 24: nm = "PROPS"; break;
    case 25: nm = "FLOW"; break;
    case 26: nm = "MASK"; break;
    case 27: nm = "PROG"; break;
    case 28: nm = "LOOK"; break;
    case 29: nm = "SAVE"; break;
    case 30: nm = "SAVE_ACK"; break;
    default: nm = "T" + string(t);
}
return nm;
