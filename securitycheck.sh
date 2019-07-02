 #!/bin/bash

block1=`hostname`



        host(){
    echo $block1".allinz-tr.local"
        }

       protocol(){
    if [[ $(grep Protocol /etc/ssh/sshd_config)
       }

        sysloglevel () {
`grep -v ^# | grep Syslog /etc/ssh/sshd_config`
        }

        sudorestriction() {
cat /etc/sudoers | grep -v '^#' | grep [A-Z] | grep -v Defaults | awk '{print $1}' ORS=' '
        }

        rootlogin() {
if [[ $(sudo cat /etc/ssh/sshd_config | grep -i "PermitRootLogin yes" | grep -v "#PermitRootLogin yes") = "PermitRootLogin yes" ]]; then
                      echo "Root Login Detected!!!"
fi
        }


cron=`cat /etc/cron.deny`
        crony() {
if [ -n "$cron" ]; then
                       echo "Cron Deny:"$cron
fi
        }


        process () {
 
pro=`cat /etc/sysconfig/selinux | grep SELINUX | grep -v '^#'  | grep -v SELINUXTYPE`
sel=`cat /etc/sysconfig/selinux | grep 'SELINUX=disable' | grep -v '^#'  | grep -v 'SELINUXTYPE'`

   if [  "$pro" != "$sel" ]; then
            echo $pro
   fi

        }


        xinet(){
xnet=`rpm -qa xinetd | grep -o xinetd`
                if [[ $xnet = 'xinetd' ]];then
                        echo "xinetd package detected!!!"
                        # else
                        #echo "xinetd not installed."
                fi
        }


        rsh () {
rsh=`rpm -qa rsh-server | grep -o rsh`                
                if [[ $rsh = 'rsh'    ]];then
                        echo "rsh package detected!!!"
                        # else
                        #echo "rsh not installed."
                fi
        }


        telnet(){
telnet=`rpm -qa telnet-server* | grep -o telnet`
                if [[ $telnet = 'telnet'    ]];then
            echo "telnet-server package detected!!!"
                fi
        }


        firefox(){
firefox=`rpm -qa firefox* | grep -o firefox`

                if [[ $firefox = 'firefox' ]]; then
                        echo "Firefox package detected!!!"
                fi
        }


        tftp(){
tftp=`rpm -qa tftp-server| grep -o tftp`
    
                if [[ $tftp = 'tftp' ]]; then
            echo "tftp package detected!!!"
                fi
        }


echo ""$1" "xyz"| "$(host)"|  "$(rootlogin)"| "$(sudorestriction)" |"$(crony)"| "$(process)"|  "$(rsh)"| "$(telnet)"| "$(xinet)" |"$(firefox)" |"$(tftp)""
