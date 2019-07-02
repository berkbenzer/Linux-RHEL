#!/bin/bash

host=`hostname`
os=`cat /etc/redhat-release`
#cpu=`less /proc/cpuinfo | grep "model name" | uniq`
cpu=`cat /proc/cpuinfo | grep processor | wc -l`
memory=`awk '/MemTotal/ { printf "%.f \n", $2/1024/1024 }' /proc/meminfo`
virtualorphy=`dmidecode -s system-manufacturer`


if [[ $(dmidecode -s system-manufacturer) = *VMware* ]]; then
       `pcs status > /dev/null 2>&1`
        val=`echo $?`
                if [ $? != 1 ] ; then
                      echo "xyz|$host|$cpu|$memory"
                else
                      echo "xyz|$host|$cpu|$memory"
fi
fi
