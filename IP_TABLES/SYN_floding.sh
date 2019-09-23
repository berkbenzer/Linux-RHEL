
#We can use the limit module of iptables firewall to protect us from SYN flooding.
#We specify 10 SYN packets per second

iptables -A INPUT -i ens192 -p tcp --syn -m limit --limit 10/second -j ACCEPT

#SYN COOKIES



#add following line to sysctl.conf
vi /etc/sysctl.conf
net.ipv4.tcp_syncookies = 1
#Then save and reload
sysctl -p
