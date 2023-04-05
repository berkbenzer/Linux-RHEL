#!/bin/sh
PERF=$(docker stats --no-stream  --all --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}" 6986b32ce33c)
DATE=`date`
echo $PERF  $DATE >> /var/log/perf.out
