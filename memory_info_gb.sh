#/bin/bash
awk '{ printf "%.2f", $2/1024/1024 ; exit}' /proc/meminfo
