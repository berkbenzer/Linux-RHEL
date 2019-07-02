#!/bin/bash
host=`hostname | tr "[:lower:]" "[:upper:]"`
cpu=`cat /proc/cpuinfo | grep processor | wc -l`
cpumodel=`cat /proc/cpuinfo | grep "model name" | uniq`
memory=`awk '/MemTotal/ { printf "%.f \n", $2/1024^2 }' /proc/meminfo`
os=`cat /etc/redhat-release`
echo "xyz|$os|$host|$cpumodel|$cpu|$memory"
