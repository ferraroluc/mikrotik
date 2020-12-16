:local DELAY "10s";
:if ([/ip ipsec remote-peers find remote-address="XXX.XXX.XXX.XXX"] = "") do={
:log error ("El tunel 4G no esta establecido");
/system routerboard usb power-reset duration=$DELAY;
:log warning "Restableciendo tunel 4G...";
} else={
:local TUNNELSTATE [/ip ipsec remote-peers get [find where remote-address="XXX.XXX.XXX.XXX"] value-name=state];
:if ($TUNNELSTATE != "established") do={
:log error ("El estado del tunel 4G es " . $TUNNELSTATE . ", por lo que se considera caido");
/system routerboard usb power-reset duration=$DELAY;
:log warning "Restableciendo tunel 4G...";
}
}
