# Scripts para Mikrotiks
Compilado de scripts para routers/switches Mikrotiks.

## Listado de scripts
* Kill Tunel IPSec
* On-Off Tunel EoIP
* Reset Modem USB 4G

## Comando para programar el schedule
```
/system scheduler
add comment="Ejecuta SCRIPT" interval=1m name=schedulerName on-event=scriptName policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
```
