# Scripts for Mikrotiks
Compilation of scripts for Mikrotik routers/switches.

## List of scripts
* EoIP_tunnel-logging: log information on changes in the EoIP tunnel
* EoIP_tunnel-onoff_layer_2: turn on/off EoIP tunnel with a layer 2 ping
* EoIP_tunnel-onoff_layer_3: turn on/off EoIP tunnel with a layer 3 ping
* Firewall-MAC_device: create firewall rules with an IP address taken from the DHCP server
* IPSec_tunnel-reset: reset the EoIP tunnel if it does not respond
* USB_4G_modem-reset: if the EoIP tunnel is not active, it will restart it

## Schedule the script
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

### Create de Ansible tasks
```
vi MikrotiksTask1.yml
```
```
---

- name: "Script for Mikrotiks"
  hosts: Mikrotiks_devices
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
ansible-playbook MikrotiksTask1.yml -i devices.txt -u USER -k
```
