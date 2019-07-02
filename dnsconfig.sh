#!/bin/bash


block1= `nmcli d s | grep ethernet | grep -v disconnected | awk '{ print $1 }' | xargs -I [] nmcli device modify [] ipv4.dns ''`
block2= `nmcli connection show | grep ethernet | awk '{ print $1 }' | xargs -I [] nmcli connection modify [] ipv4.dns 'IP ADDR,IP ADDR'`
block3= `systemctl start network`
block4= `systemctl restart NetworkManager`




     if [[ $(cat /etc/redhat-release | grep -o '7') = *7* ]]; then
        
                        $block1 $block2 $block3 $block4
        #       else
       
         #   if [[ $(cat /etc/redhat-release | grep -o '6*') = *6* ]]; then
       
#                       $resolveconfbak $addresolveconf
        #       fi
     fi
