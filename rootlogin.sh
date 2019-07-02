#!/bin/bash

host=`sudo hostname`
os=`sudo cat /etc/redhat-release`
checkroot=`sudo cat /etc/ssh/sshd_config | grep -i "PermitRootLogin yes" | grep -v "#PermitRootLogin yes"`

if [[ $(sudo cat /etc/ssh/sshd_config | grep -i "PermitRootLogin yes" | grep -v "#PermitRootLogin yes") = "PermitRootLogin yes" ]]; then
       `pcs status > /dev/null 2>&1`
        val=`echo $?`
               if [ $? != 1 ] ; then
                      echo  "xyz | $host | $checkroot"
              fi
fi
