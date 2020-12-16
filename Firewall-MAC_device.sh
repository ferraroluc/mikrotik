:local camaraIP [/ip dhcp-server lease get [find where mac-address~"00:02:D1"] value-name=address];
/ip firewall filter add comment="Bloqueo de camara IP" disabled=yes chain=forward src-address=$camaraIP place-before="0";
