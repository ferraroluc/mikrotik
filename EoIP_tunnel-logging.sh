:global actualStateTunnel1;
:global actualStateTunnel2;
:local stateTunnel1 [/interface bridge port get [find where interface="eoip-tunel-1"] value-name=disabled];
:local stateTunnel2 [/interface bridge port get [find where interface="eoip-tunel-2"] value-name=disabled];
:local newState;
:local dia [/system clock get value-name=date];
:local hora [/system clock get value-name=time];

:if ($stateTunnel1 != $actualStateTunnel1) do={
:set $actualStateTunnel1 $stateTunnel1;
:if ($stateTunnel1) do={
:set $newState ("\n$dia - $hora: RESPONDE ping la sucursal 1 a traves de la red interna.");
} else={
:set $newState ("\n$dia - $hora: NO RESPONDE ping la sucursal 1, probable caida de red interna.");
}
/file set RecordOfStates contents=([get RecordOfStates contents] . $newState);
}

:if ($stateTunnel2 != $actualStateTunnel2) do={
:set $actualStateTunnel2 $stateTunnel2;
:if ($stateTunnel2) do={
:set $newState ("\n$dia - $hora: RESPONDE ping la sucursal 2 a traves de la red interna.");
} else={
:set $newState ("\n$dia - $hora: NO RESPONDE ping la sucursal 2, probable caida de red interna.");
}
/file set RecordOfStates contents=([get RecordOfStates contents] . $newState);
}
