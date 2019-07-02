#!/bin/bash
 
 output=$(sudo cat /etc/sudoers | grep "ALL=(ALL)" | grep -v "root" | grep -v "wheel"  | grep -v "#")
 
 
 host=`hostname`
 
 while read line; do
       priv=$( echo $line  | cut -d ":" -f2 | awk '{print $1}'  | grep -c "/")
       if (( $priv )); then
             echo "xyz | $host| $line | Service Execute"
       else
           sudo echo "xyz | $host | $line | Full Execute"  
       fi
 done <<< "$output"


