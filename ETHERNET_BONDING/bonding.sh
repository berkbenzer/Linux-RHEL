#add secondary network card to machine
#give static IP
nmcli con add con-name ens224 ifname ens224 type ethernet ip4 xxx.xx.xxx.xxx/24 gw4 xxx.xx.xxx.xxx

#add bonding rules
nmcli connection add type bond ifname bond0 bond.options "mode=balance-rr,miimon=100"


nmcli connection add type ethernet ifname ens192 master bond0 
nmcli connection add type ethernet ifname ens224 master bond0

#To activate the slaves, issue a command as follows
nmcli  connection up bond-slave-ens192
nmcli  connection up bond-slave-ens224

]# ifconfig | grep -i bond
bond0: flags=5187<UP,BROADCAST,RUNNING,MASTER,MULTICAST>  mtu 1500

 nmcli connection 
NAME               UUID                                  TYPE      DEVICE 
bond-bond0         42d72917-0742-4f79-a957-4d22e311fa0a  bond      bond0  
bond-slave-ens192  d2f7d6cc-3e86-4b7a-a747-78670cc8a0d4  ethernet  ens192 
bond-slave-ens224  61e975d0-7281-46ae-b622-99933bbd93c6  ethernet  ens224 
virbr0             fd8fc045-7313-4ec8-8ea0-ec66d4fc981c  bridge    virbr0 
ens192             537a4a97-e164-45ec-9eca-1250151946b7  ethernet  --     
ens192             76830d6f-8947-4810-adab-42e786fca677  ethernet  --     
ens224             a1c70741-6cd2-478f-a3b1-d52fa2aba908  ethernet  --
