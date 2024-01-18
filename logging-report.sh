# NETWATCH
## DOWN
:local day [/system clock get value-name=date];
:local time [/system clock get value-name=time];
:set $message ("\n$day - $time: Conexion a proveedor perdida");
/file set Report.txt contents=([get Report.txt contents] . $message);

## UP
:local day [/system clock get value-name=date];
:local time [/system clock get value-name=time];
:set $message ("\n$day - $time: Conexion a proveedor restablecida");
/file set Report.txt contents=([get Report.txt contents] . $message);

# TIME SCRIPT
:local host "8.8.8.8";
:local limit value=20;
:local avgRtt value=0;
:local day [/system clock get value-name=date];
:local time [/system clock get value-name=time];

/tool flood-ping address=8.8.8.8 count=1 do={
  :set avgRtt ($"avg-rtt");
}

if ( $avgRtt = 0 ) do {
    :set $message ("\n$day - $time: Perdida de paquete");
    /file set Report.txt contents=([get Report.txt contents] . $message);
} else {
    if ( $avgRtt > $limit ) do {
        :set $message ("\n$day - $time: Tiempo de respuesta excedido a $avgRtt ms");
        /file set Report.txt contents=([get Report.txt contents] . $message);
    }
}

# E-MAIL SCRIPT
:local day [/system clock get value-name=date];

/tool e-mail send to="user@domain.com" subject="Reporte $day" body="Estimados, buenos dias.\n\nSe adjunta el reporte del dia $day\n\nSaludos." file="Report.txt";
:delay 30
/file set Report.txt contents=("");