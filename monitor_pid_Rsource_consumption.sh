#!/bin/bash

OUTPUT="/var/log/xagt_resource_usage.csv"
TOTALS="/var/log/xagt_totals.csv"
NUM_CORES=$(nproc)

[ ! -f "$OUTPUT" ] && echo "Timestamp,PID,Process,CPU%,MEM%,MEM_MB,IO_Read_KB,IO_Write_KB" > "$OUTPUT"
[ ! -f "$TOTALS" ] && echo "Timestamp,TOTAL_CPU%,TOTAL_MEM%,NORMALIZED_CPU%" > "$TOTALS"

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    MAIN_PID=$(systemctl show -p MainPID --value SERVICE_NAME)    ###>>>> Put the service to monitor.  

    if [ -z "$MAIN_PID" ] || [ "$MAIN_PID" -eq 0 ] || [ ! -d "/proc/$MAIN_PID" ]; then
        sleep 1
        continue
    fi

    PIDS=$(pstree -p "$MAIN_PID" | grep -oP '\(\d+\)' | tr -d '()')
    PIDS="$MAIN_PID $PIDS"

    TOTAL_CPU=0
    TOTAL_MEM=0

    for pid in $PIDS; do
        if [ ! -d /proc/$pid ]; then
            continue
        fi

        CMD=$(ps -p $pid -o comm= 2>/dev/null | tr -d '\n')
        read CPU MEM RSS <<< $(ps -p $pid -o %cpu,%mem,rss --no-headers 2>/dev/null)

        CPU=${CPU:-0}
        MEM=${MEM:-0}
        RSS=${RSS:-0}

        MEM_MB=$(awk "BEGIN {printf \"%.1f\", $RSS/1024}")
        TOTAL_CPU=$(awk "BEGIN {print $TOTAL_CPU + $CPU}")
        TOTAL_MEM=$(awk "BEGIN {print $TOTAL_MEM + $MEM}")

        read IO_READ IO_WRITE <<< $(awk '
            /read_bytes/ {r=$2/1024}
            /write_bytes/ {w=$2/1024}
            END {printf "%.1f %.1f", r, w}
        ' /proc/$pid/io 2>/dev/null)

        echo "$TIMESTAMP,$pid,$CMD,$CPU,$MEM,$MEM_MB,$IO_READ,$IO_WRITE" >> "$OUTPUT"
    done

    # Calculate normalized CPU usage based on number of cores
    NORMALIZED_CPU=$(awk "BEGIN {printf \"%.2f\", $TOTAL_CPU / $NUM_CORES}")

    if [[ "$TOTAL_CPU" =~ ^[0-9]+([.][0-9]+)?$ && "$TOTAL_MEM" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
        echo "$TIMESTAMP,$TOTAL_CPU,$TOTAL_MEM,$NORMALIZED_CPU" >> "$TOTALS"
    fi

    sleep 1
done



[Unit]
Description=Monitor xagt resource usage
After=network.target xagt.service

[Service]
ExecStart=/usr/local/bin/monitor_xagt.sh
Restart=always
RestartSec=2
StandardOutput=null
StandardError=journal

[Install]
WantedBy=multi-user.target



