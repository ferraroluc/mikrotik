# Scripts for Mikrotik

Compilation of scripts for Mikrotik routers/switches.

## List of scripts

- `certs-creator`: create IKEv2 certs
- `certs-updater`: renew IKEv2 certs
- `email-sender`: send an e-mail every 1st day of the month
- `EoIP-logging`: log information on changes in the EoIP tunnel
- `EoIP-onoff-layer2`: turn on/off EoIP tunnel with a layer 2 ping
- `EoIP-onoff-layer3`: turn on/off EoIP tunnel with a layer 3 ping
- `firewall-mac`: create firewall rules with an IP address taken from the DHCP server
- `IPSec-reset`: reset the EoIP tunnel if it does not respond
- `logging-internet`: if another Mikrotik stops responding ping, save the date to a file
- `logging-power`: save power state in file
- `logging-report`: save connection quality in file
- `usb-4g-reset`: if the EoIP tunnel is not active, it will restart it

## Schedule the script

On the terminal of the device:

```
/system scheduler
add comment="Ejecuta SCRIPT X" interval=1m name=schedulerName on-event=scriptName policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-time=startup
```

## Use Ansible

### Create the device list

```
vi devices.txt
```

```
[MikrotikDevices]
device1 ansible_ssh_host=192.168.XXX.XXX ansible_network_os=routeros
device2 ansible_ssh_host=192.168.XXX.XXX ansible_network_os=routeros
```

### Create de Ansible task

```
vi MikrotikTask1.yml
```

```
---
- name: "Script for Mikrotik"
  hosts: Mikrotik_devices
  connection: network_cli
  gather_facts: no

  tasks:
    - name: script1
      routeros_command:
        commands: ***COMMAND 1 ; COMMAND 2 ; COMMAND 3 ...***
...
```

### Run the task

```
ansible-playbook MikrotikTask1.yml -i devices.txt -u USER -k
```
