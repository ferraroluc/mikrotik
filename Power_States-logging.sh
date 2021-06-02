:local prendido [/system resource get uptime];
:local referencia 0d01:10:00;
:local day [/system clock get value-name=date];
:local time [/system clock get value-name=time];

:if ($prendido < $referencia) do={
:set $message ("\n$day - $time: El Mikrotik se reinicio.");
/file set PowerStates.txt contents=([get PowerStates.txt contents] . $message);
/tool e-mail send to="user@domain.com" subject="Mikrotik Casa" body="Al final se había cortado la luz";
}
