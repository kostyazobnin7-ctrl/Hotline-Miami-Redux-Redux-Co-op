global.net_mode = global.NET_MODE_OFF;
global.net_host_ip = "127.0.0.1";
global.net_port = 47800;
global.net_lag = 0;
global.net_jitter = 0;
global.net_name = "Player";
global.net_debug = 0;
global.net_split_arg = 0;
var n = parameter_count();
for (var i = 1; i <= n; i += 1)
{
    var a = parameter_string(i);
    if (a == "-coop_host")
    {
        global.net_mode = global.NET_MODE_HOST;
    }
    else if (a == "-coop_debug")
    {
        global.net_debug = 1;
    }
    else if (a == "-coop_split")
    {
        global.net_split_arg = 1;
    }
    else if (i < n)
    {
        if (a == "-coop_join")
        {
            global.net_mode = global.NET_MODE_CLIENT;
            global.net_host_ip = parameter_string(i + 1);
            i += 1;
        }
        else if (a == "-coop_name")
        {
            global.net_name = parameter_string(i + 1);
            i += 1;
        }
        else if (a == "-coop_port")
        {
            global.net_port = real(parameter_string(i + 1));
            i += 1;
        }
        else if (a == "-coop_lag")
        {
            global.net_lag = real(parameter_string(i + 1));
            i += 1;
        }
        else if (a == "-coop_jitter")
        {
            global.net_jitter = real(parameter_string(i + 1));
            i += 1;
        }
    }
}
if (global.net_port < 1024 || global.net_port > 65000)
{
    global.net_port = 47800;
}
global.net_lag = clamp(global.net_lag, 0, 2000);
global.net_jitter = clamp(global.net_jitter, 0, 1000);
global.net_name = net_clean_nick(global.net_name);
