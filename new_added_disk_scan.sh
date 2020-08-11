echo "- - -" > /sys/class/scsi_host/host#/scan
  193  echo "- - -" > /sys/class/scsi_host/host0/scan 
  194  echo "- - -" > /sys/class/scsi_host/host1/scan 
  195  echo "- - -" > /sys/class/scsi_host/host2/scan

~]# ls /sys/class/scsi_device/
1:0:0:0  2:0:0:0  2:0:1:0
[root@xxxx ~]# echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan
-bash: /sys/class/scsi_device/0:0:0:0/device/rescan: No such file or directory
[root@xxxx ~]# echo 1 > /sys/class/scsi_device/1\:0\:0\:0/device/rescan
[root@xxxx ~]# echo 1 > /sys/class/scsi_device/2\:0\:0\:0/device/rescan
[root@xxxx ~]# echo 1 > /sys/class/scsi_device/2\:0\:2\:0/device/rescan
-bash: /sys/class/scsi_device/2:0:2:0/device/rescan: No such file or directory
[root@xxxx ~]# echo 1 > /sys/class/scsi_device/2\:0\:1\:0/device/rescan
