# Scripts para Mikrotiks
Compilado de scripts para routers/switches Mikrotiks.

## Listado de scripts
* EoIP Tunnel - logging
* EoIP Tunnel - onoff - Capa 2
* EoIP Tunnel - onoff - Capa 3
* IPSec Tunnel - reset
* USB Modem 4G - reset

## Comando para programar el schedule
```
/system scheduler
add comment="Ejecuta SCRIPT X" interval=1m name=schedulerName on-event=scriptName policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
```
