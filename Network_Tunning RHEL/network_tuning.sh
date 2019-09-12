vi /etc/sysctl.conf

#1. Disable the TCP timestamps option for better CPU utilization:
sysctl -w net.ipv4.tcp_timestamps=0

#2. Enable the TCP selective acks option for better throughput:
sysctl -w net.ipv4.tcp_sack=1

#3. Increase the maximum length of processor input queues:
sysctl -w net.core.netdev_max_backlog=250000

#4. Increase the TCP maximum and default buffer sizes using setsockopt():

echo 'net.core.wmem_max=12582912' >> /etc/sysctl.conf       #memory usage is going to increase
echo 'net.core.rmem_max=12582912' >> /etc/sysctl.conf       #memory usage is going to increase
#You also need to set minimum size, initial size, and maximum size in bytes:
echo 'net.ipv4.tcp_rmem= 10240 87380 12582912' >> /etc/sysctl.conf
echo 'net.ipv4.tcp_wmem= 10240 87380 12582912' >> /etc/sysctl.conf
sysctl -w net.core.optmem_max=4194304

#5. Increase memory thresholds to prevent packet dropping: 
sysctl -w net.ipv4.tcp_rmem="4096 87380 4194304"
sysctl -w net.ipv4.tcp_wmem="4096 65536 4194304"

#6. Enable low latency mode for TCP:
sysctl -w net.ipv4.tcp_low_latency=1

#The following variable is used to tell the kernel how much of the socket buffer space should be used for TCP window size, and how much to save for an application buffer.

sysctl -w net.ipv4.tcp_adv_win_scale=1


#7.Enable window scaling.Turn on window scaling which can be an option to enlarge the transfer window

net.ipv4.tcp_window_scaling= 1
