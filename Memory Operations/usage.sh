
[oracle@ists075pmsdbt ~]$ cat mem_usa.sh 
#!/bin/sh
free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 



ists075pmsdbt ~]$ ./mem_usa.sh 
Memory Usage: 41942/42339MB (99.06%)
Disk Usage: 19/83GB (24%)
CPU Load: 2.23
