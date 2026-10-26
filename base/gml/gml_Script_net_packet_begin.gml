buffer_seek(global.net_wbuf, buffer_seek_start, 0);
buffer_write(global.net_wbuf, buffer_u8, argument0);
return global.net_wbuf;
