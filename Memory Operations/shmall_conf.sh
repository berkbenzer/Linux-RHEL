SHMALL -CONFIGURATUON



## Need to exclude swap and cache.
##This case will configure 20GB memory.
##In this  machine we have single oracle instance
##16 GB to rest of the to OS

XXXX:~]# free -m
             total       used       free     shared    buffers     cached
Mem:         20120      19940        179       5082        129      18236
-/+ buffers/cache:       1574      18545
Swap:         4095       1021       3074
[oracle@XXXX:~]#  getconf PAGE_SIZE
4096

##Calculation
##Convert 16GB into bytes and divide by page size, I used the linux calc to do the math.

xxxx:~]# echo "( 16 * 1024 * 1024 * 1024 ) / 4096 " | bc -l
4194304.00000000000000000000

xxxx:~]# echo "4194304" > /proc/sys/kernel/shmall
xxxx:~]# sysctl –p

##Verify if the value has been taken into effect.

xxxx:~]#  sysctl -a | grep shmall
kernel.shmall = 1310720
