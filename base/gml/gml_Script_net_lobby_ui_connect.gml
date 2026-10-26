global.net_name = net_clean_nick(global.lb_val[1]);
global.lb_val[1] = global.net_name;
var p = 0;
if (global.lb_val[3] != "")
{
    p = real(global.lb_val[3]);
}
if (p < 1024 || p > 65000)
{
    global.lb_err = "PORT MUST BE 1024..65000";
    exit;
}
if (argument0 == global.NET_MODE_CLIENT && string_count(".", global.lb_val[2]) != 3)
{
    global.lb_err = "ENTER HOST IP, e.g. 127.0.0.1";
    exit;
}
global.net_port = p;
global.net_host_ip = global.lb_val[2];
global.lb_field = 0;
global.lb_err = "";
if (!net_start(argument0))
{
    global.lb_err = "CANNOT OPEN UDP PORT " + string(p) + " (busy?)";
}
