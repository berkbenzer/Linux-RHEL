#RHEL 7.5 FIREWALL EXAMPLES

#When you add a rule it is added to the end of the chain
#You can add rule to top with "-I" option
#Secure of rules matters

iptables -I INPUT 1 -i ens192 -p udp -j ACCEPT



#to start firewall
systemctl start firewalld

#to check status
istsl75oeldb:/]# systemctl status firewalld
● firewalld.service - firewalld - dynamic firewall daemon
   Loaded: loaded (/usr/lib/systemd/system/firewalld.service; enabled; vendor preset: enabled)
   Active: active (running) since Mon 2019-09-23 12:10:14 +03; 2h 10min ago
     Docs: man:firewalld(1)
 Main PID: 943 (firewalld)
   CGroup: /system.slice/firewalld.service
           └─943 /usr/bin/python -Es /usr/sbin/firewalld --nofork --nopid

#to stop firewall
systemctl stop firewalld


#INCOMING TRAFFIC

#A      = adding new rule to INPUT chain
#i      = ethernet device which will be us. if it will not selected than rule will be applied to all incoming traffic regardless the devices
#p      = packet process you want to applied the rule
#-dport = destination port
#-d     = destination IP
#-j     = JUMP action to do

iptables -A INPUT -i ens192 -p tcp --dport 80 -d 1.2.3.4 -j ACCEPT

#OUTGOING TRAFFIC

#A      = adding new rule to OUTPUT chain
#o      = device for the useage of outgoing traffic
#-sport = source port

iptables -A OUTPUT -o ens192 -p tcp --sport 80 -j ACCEPT


#DELETING RULES

#We can use -D option in order to delete written rule
iptables -D INPUT -i ens192 -p tcp --dport 80 -d 1.2.3.4 -j ACCEPT

#Order based delete
iptables -D INPUT 2

#Delete all rules
iptables -F INPUT


#SAVE IPTABLES RULES

#You can save all iptables rules
iptables-save > /etc/sysconfig/iptables
service iptables save






