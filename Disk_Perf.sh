
## DISK WRITE PERF. CHECK
dd if=/dev/zero of=/tmp/test.img bs=1G count=2 oflag=dsync
2+0 records in
2+0 records out
2147483648 bytes (2.1 GB) copied, 31.9026 s, 67.3 MB/s

dd if=/dev/zero of=/tmp/test2.img bs=512k count=2048 oflag=direct
2048+0 records in
2048+0 records out
1073741824 bytes (1.1 GB) copied, 15.1705 s, 70.8 MB/s


## DISK READ PERF. CHECK
dd if=./test.img of=/dev/zero bs=512k count=2048
2048+0 records in
2048+0 records out
1073741824 bytes (1.1 GB) copied, 12.0465 s, 89.1 MB/s
dd if=./test2.img of=/dev/zero bs=512k count=2048
2048+0 records in
2048+0 records out
1073741824 bytes (1.1 GB) copied, 11.8221 s, 90.8 MB/s
