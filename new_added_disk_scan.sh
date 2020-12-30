echo "- - -" > /sys/class/scsi_host/host#/scan
echo "- - -" > /sys/class/scsi_host/host0/scan 
echo "- - -" > /sys/class/scsi_host/host1/scan 
echo "- - -" > /sys/class/scsi_host/host2/scan

ls /sys/class/scsi_device/
1:0:0:0  2:0:0:0  2:0:1:0

echo 1 > /sys/class/scsi_device/0\:0\:0\:0/device/rescan
echo 1 > /sys/class/scsi_device/1\:0\:0\:0/device/rescan
echo 1 > /sys/class/scsi_device/2\:0\:0\:0/device/rescan
echo 1 > /sys/class/scsi_device/2\:0\:2\:0/device/rescan
echo 1 > /sys/class/scsi_device/2\:0\:1\:0/device/rescan
