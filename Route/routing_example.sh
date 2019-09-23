#Display all routing in a server

ldb:/]# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         gateway         0.0.0.0         UG    100    0        0 ens192
172.17.242.0    0.0.0.0         255.255.255.0   U     100    0        0 ens192
192.168.122.0   0.0.0.0         255.255.255.0   U     0      0        0 virbr0


#Add routing
route add -net xxx.xx.xxx.xx netmask 255.255.255.0 dev ens192

#KERNEL ROUTE CACHE

#kernel maintains the route cache in order to route packets fast
route -Cn

#REJECT ROUTE from PARTICULAR HOST
route add -host xxx.xxx.xx.xx reject

#Reject entire Network
route add -net 192.168.1.0 netmask 255.255.255.0 reject

