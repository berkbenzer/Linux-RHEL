#!/bin/bash
function add_line
{
egrep "^$2" $1 > /dev/null || echo "$2" >> $1
}
function package_installed
{
	installed=$(rpm -qa $1 | wc -l)
}

function install_package
{
package_installed $1
if [ $installed -ne 0 ]
then
	echo "$1 is already installed"
else
	yum install $1 -y > /dev/null 2>&1
	package_installed $1
	if [ $installed -ne 0 ]
	then
		echo "$1" >> /root/backup/installed.txt
		echo "$1 package installed"
	else
		echo "$1 package could not be installed!"
	fi
fi
}
function delete_package
{
package_installed $1
if [ $installed -ne 0 ]
then
	yum erase $1 -y > /dev/null 2>&1
	package_installed $1
	if [ $installed -eq 0 ]
	then
		echo "$1" >> /root/backup/removed.txt
		echo "$1 package removed"
	else
		echo "$1 package not removed!"
	fi
else
	echo "$1 package is not installed!"
fi
}
#---------------------------------------------------------------------------------------------------------------
echo "creating backup"
rm -rf /root/backup/
mkdir /root/backup
rsync -avr /etc /root/backup
rsync -av /var/log /root/backup
rsync -av /var/spool /root/backup
rsync -av /boot/grub /root/backup
#---------------------------------------------------------------------------------------------------------------
echo 1.1.14
echo 1.1.15
echo 1.1.16
sed -i 's|\(/dev/shm\s*\S*\s*defaults\)\S*|\1,nodev,noexec,nosuid|' /etc/fstab
echo ------------------------------------------------------------------------
echo 1.1.18
echo "install cramfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.19
echo "install freevxfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.20
echo "install jffs2 /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.21
echo "install hfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.22
echo "install hfsplus /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.23
echo "install squashfs /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.1.24
echo "install udf /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 1.2.3
sed -i -e s/gpgcheck=0/gpgcheck=1/g /etc/yum.conf
echo ------------------------------------------------------------------------
echo ------------------------------------------------------------------------
echo 1.3.1
install_package aide
echo ------------------------------------------------------------------------
echo 1.3.2 
echo "0 5 * * * /usr/sbin/aide --check" >> /var/spool/cron/root
echo ------------------------------------------------------------------------
echo 1.4.4 and 1.4.5 
delete_package mcstrans
echo ------------------------------------------------------------------------
echo 1.5.1 
chown root:root /etc/grub.conf
echo ------------------------------------------------------------------------
echo 1.5.2 
chmod og-rwx /etc/grub.conf
echo ------------------------------------------------------------------------
echo 1.6.3
echo "kernel.randomize_va_space = 2" >> /etc/sysctl.conf
echo ------------------------------------------------------------------------
echo 2.1.1 
delete_package telnet
echo ------------------------------------------------------------------------
echo 2.1.2 
delete_package telnet-server
echo ------------------------------------------------------------------------
echo 2.1.3 
delete_package rsh-server
echo ------------------------------------------------------------------------
echo 2.1.4 
delete_package rsh
echo ------------------------------------------------------------------------
echo 2.1.5 
delete_package ypbind
echo ------------------------------------------------------------------------
echo 2.1.6 
delete_package ypserv
echo ------------------------------------------------------------------------
echo 2.1.7 
delete_package tftp
echo ------------------------------------------------------------------------
echo 2.1.8  
delete_package tftp-server
echo ------------------------------------------------------------------------
echo 2.1.9  
delete_package talk
echo ------------------------------------------------------------------------
echo 2.1.10  
delete_package talk-server
echo ------------------------------------------------------------------------
echo 2.1.11 
delete_package xinetd
echo ------------------------------------------------------------------------
echo 2.1.12 
chkconfig chargen-dgram off > /dev/null
echo ------------------------------------------------------------------------
echo 2.1.13 
chkconfig chargen-stream off > /dev/null 
echo ------------------------------------------------------------------------
echo 2.1.14 
chkconfig daytime-dgram off  > /dev/null 
echo ------------------------------------------------------------------------
echo 2.1.15 
chkconfig daytime-stream off  > /dev/null 
echo ------------------------------------------------------------------------
echo 2.1.16 
chkconfig echo-dgram off  > /dev/null 
echo ------------------------------------------------------------------------
echo 2.1.17 
chkconfig echo-stream off  > /dev/null 
echo ------------------------------------------------------------------------
echo 2.1.18 
chkconfig tcpmux-server off  > /dev/null 
echo ------------------------------------------------------------------------
echo 3.1 
echo "umask 027" >>  /etc/sysconfig/init
echo ------------------------------------------------------------------------
echo 3.3 
chkconfig avahi-daemon off > /dev/null 
echo ------------------------------------------------------------------------
echo 3.4 
chkconfig cups off > /dev/null 
echo ------------------------------------------------------------------------
echo 3.5 
delete_package dhcp
echo ------------------------------------------------------------------------
echo 3.6
				   
cat /etc/ntp.conf |grep server|grep -v "#" > /tmp/ntpserver
while read p; do
        sed -i.bak "/$p/d" /etc/ntp.conf
done < /tmp/ntpserver

/bin/rm -rf /tmp/ntpserver
echo "server 10.170.147.204" >> /etc/ntp.conf
echo "server 10.170.147.205" >> /etc/ntp.conf
echo "server 159.95.1.17" >> /etc/ntp.conf
echo "server 159.50.1.17" >> /etc/ntp.conf
										  
/etc/init.d/ntpd start > /dev/null
echo ------------------------------------------------------------------------
echo 3.7
delete_package openldap-servers
delete_package openldap-clients
echo ------------------------------------------------------------------------
echo 3.8 
chkconfig nfslock off  > /dev/null 
chkconfig rpcgssd off  > /dev/null 
chkconfig rpcbind off  > /dev/null 
chkconfig rpcidmapd off  > /dev/null 
chkconfig rpcsvcgssd off > /dev/null 
echo ------------------------------------------------------------------------
echo 3.9 
delete_package bind
echo ------------------------------------------------------------------------
echo 3.10 
delete_package vsftpd
echo ------------------------------------------------------------------------
echo 3.12
delete_package dovecot
echo ------------------------------------------------------------------------
echo 3.13  
delete_package samba
echo ------------------------------------------------------------------------
echo 3.14    
delete_package squid
echo ------------------------------------------------------------------------
echo 3.15   
delete_package net-snmp
echo ------------------------------------------------------------------------
echo 4.1.1
sed -i -e s/"net.ipv4.ip_forward = 1/net.ipv4.ip_forward = 0"/g /etc/sysctl.conf
echo ------------------------------------------------------------------------
echo 4.1.2
sed -i.bak '/net.ipv4.conf.all.send_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.send_redirects = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.send_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.send_redirects = 0" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.1
sed -i.bak '/nnet.ipv4.conf.all.accept_source_route/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.accept_source_route/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.accept_source_route = 0" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.2
sed -i.bak '/net.ipv4.conf.all.accept_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.accept_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.accept_redirects = 0 " >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.3
sed -i.bak '/net.ipv4.conf.all.secure_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.secure_redirects = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.secure_redirects/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.secure_redirects = 0" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.4
sed -i.bak '/net.ipv4.conf.all.log_martians/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.log_martians/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.4
sed -i.bak '/net.ipv4.conf.all.log_martians/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.log_martians = 1" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv4.conf.default.log_martians/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.log_martians = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.5
sed -i.bak '/net.ipv4.icmp_echo_ignore_broadcasts/d' /etc/sysctl.conf 
echo "net.ipv4.icmp_echo_ignore_broadcasts = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.6
sed -i.bak '/net.ipv4.icmp_ignore_bogus_error_responses/d' /etc/sysctl.conf 
echo "net.ipv4.icmp_ignore_bogus_error_responses = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.7
sed -i.bak '/net.ipv4.conf.all.rp_filter/d' /etc/sysctl.conf 
echo "net.ipv4.conf.all.rp_filter = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
sed -i.bak '/net.ipv4.conf.default.rp_filter/d' /etc/sysctl.conf 
echo "net.ipv4.conf.default.rp_filter = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.2.8
sed -i.bak '/net.ipv4.tcp_syncookies/d' /etc/sysctl.conf 
echo "net.ipv4.tcp_syncookies = 1" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.3.1   
rm /etc/sysconfig/network-scripts/ifcfg-w* > /dev/null
echo ------------------------------------------------------------------------
echo 4.4.1.1
sed -i.bak '/net.ipv6.conf.all.accept_ra/d' /etc/sysctl.conf 
echo "net.ipv6.conf.all.accept_ra = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv6.conf.default.accept_ra/d' /etc/sysctl.conf 
echo "net.ipv6.conf.default.accept_ra = 0" >> /etc/sysctl.conf 
echo ------------------------------------------------------------------------
echo 4.4.1.2
echo "options ipv6 disable=1" >> /etc/modprobe.d/ipv6.conf
sed -i.bak '/net.ipv6.conf.all.accept_redirects/d' /etc/sysctl.conf 
echo "net.ipv6.conf.all.accept_redirects = 0" >> /etc/sysctl.conf 
sed -i.bak '/net.ipv6.conf.default.accept_redirects/d' /etc/sysctl.conf 
echo "net.ipv6.conf.default.accept_redirects = 0" >> /etc/sysctl.conf
																				
																			 
																					
																				 
echo ------------------------------------------------------------------------
echo 4.4.2
sed -i.bak '/NETWORKING_IPV6=no/d' /etc/sysconfig/network
sed -i.bak '/IPV6INIT=no/d'  /etc/sysconfig/network
sed -i.bak '/options ipv6 disable=1/d' /etc/modprobe.d/ipv6.conf
echo "NETWORKING_IPV6=no" >> /etc/sysconfig/network
echo "IPV6INIT=no" >> /etc/sysconfig/network
echo "options ipv6 disable=1" >> /etc/modprobe.d/ipv6.conf
/sbin/chkconfig ip6tables off > /dev/null
echo ------------------------------------------------------------------------
echo 4.5.1
install_package tcp_wrappers
echo ------------------------------------------------------------------------
echo 4.5.3 
chmod 644 /etc/hosts.allow > /dev/null
echo ------------------------------------------------------------------------
echo 4.5.5 Verify Permissions on /etc/hosts.deny
chmod 644 /etc/hosts.deny  > /dev/null
echo ------------------------------------------------------------------------
echo 4.6.1 Disable DCCP
echo "install dccp /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 4.6.2
echo "install sctp /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 4.6.3
echo "install rds /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 4.6.4
echo "install tipc /bin/true" >> /etc/modprobe.d/CIS.conf
echo ------------------------------------------------------------------------
echo 5.1.1
install_package rsyslog
echo ------------------------------------------------------------------------
echo 5.1.3
sed -i.bak "/auth,user.* \/var\/log\/messages/d" /etc/rsyslog.conf
sed -i.bak "/kern.* \/var\/log\/kern.log/d" /etc/rsyslog.conf
sed -i.bak "/daemon.* \/var\/log\/daemon.log/d" /etc/rsyslog.conf
sed -i.bak "/syslog.* \/var\/log\/syslog/d" /etc/rsyslog.conf
sed -i.bak "/lpr,news,uucp,local0,local1,local2,local3,local4,local5,local6.* \/var\/log\/unused.log/d" /etc/rsyslog.conf
echo "auth,user.* /var/log/messages" >> /etc/rsyslog.conf
echo "kern.* /var/log/kern.log" >> /etc/rsyslog.conf
echo "daemon.* /var/log/daemon.log" >> /etc/rsyslog.conf
echo "syslog.* /var/log/syslog" >> /etc/rsyslog.conf
echo "lpr,news,uucp,local0,local1,local2,local3,local4,local5,local6.* /var/log/unused.log" >> /etc/rsyslog.conf
echo ------------------------------------------------------------------------
echo 5.1.4
touch /var/log/kern.log
touch /var/log/daemon.log
touch /var/log/syslog
touch /var/log/unused.log
chown root:root /var/log/messages
chown root:root /var/log/secure
chown root:root /var/log/maillog
chown root:root /var/log/cron
chown root:root /var/log/spooler
chown root:root /var/log/boot.log
chown root:root /var/log/messages
chown root:root /var/log/kern.log
chown root:root /var/log/daemon.log
chown root:root /var/log/syslog
chown root:root /var/log/unused.log
chmod og-rwx /var/log/messages
chmod og-rwx /var/log/secure
chmod og-rwx /var/log/maillog
chmod og-rwx /var/log/cron
chmod og-rwx /var/log/spooler
chmod og-rwx /var/log/boot.log
chmod og-rwx /var/log/messages
chmod og-rwx /var/log/kern.log
chmod og-rwx /var/log/daemon.log
chmod og-rwx /var/log/syslog
chmod og-rwx /var/log/unused.log
echo ------------------------------------------------------------------------
echo 5.2.1.1
sed -i '/max_log_file =/c\max_log_file = 50' /etc/audit/auditd.conf
echo ------------------------------------------------------------------------
echo 5.2.2
chkconfig auditd on > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.3 
sed -i -e "s|audit=1||" /etc/grub.conf
sed -i -e "s|kernel[ ]*\([^ ]*\)|kernel \1 audit=1|" /etc/grub.conf
sed -i -e "s|audit=1||" /boot/grub/grub.conf
sed -i -e "s|kernel[ ]*\([^ ]*\)|kernel \1 audit=1|" /boot/grub/grub.conf
echo ------------------------------------------------------------------------
echo 5.2.4
sed -i.bak '/-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change/d' /etc/audit/audit.rules 
sed -i.bak '/-a always,exit -F arch=b64 -S clock_settime -k time-change/d' /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S adjtimex -S settimeofday -k time-change" >> /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S clock_settime -k time-change" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.5
sed -i.bak "/-w \/etc\/group -p wa -k identity/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/passwd -p wa -k identity/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/gshadow -p wa -k identity/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/shadow -p wa -k identity/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/security\/opasswd -p wa -k identity/d" /etc/audit/audit.rules
echo "-w /etc/group -p wa -k identity" >> /etc/audit/audit.rules
echo "-w /etc/passwd -p wa -k identity" >> /etc/audit/audit.rules
echo "-w /etc/gshadow -p wa -k identity" >> /etc/audit/audit.rules
echo "-w /etc/shadow -p wa -k identity" >> /etc/audit/audit.rules
echo "-w /etc/security/opasswd -p wa -k identity" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.6
sed -i.bak "/-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/issue -p wa -k system-locale/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/issue.net -p wa -k system-locale/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/hosts -p wa -k system-locale/d" /etc/audit/audit.rules
sed -i.bak "/-w \/etc\/sysconfig\/network -p wa -k system-locale/d" /etc/audit/audit.rules
echo "-a always,exit -F arch=b64 -S sethostname -S setdomainname -k system-locale" >> /etc/audit/audit.rules
echo "-w /etc/issue -p wa -k system-locale" >> /etc/audit/audit.rules
echo "-w /etc/issue.net -p wa -k system-locale" >> /etc/audit/audit.rules
echo "-w /etc/hosts -p wa -k system-locale" >> /etc/audit/audit.rules
echo "-w /etc/sysconfig/network -p wa -k system-locale" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.7
sed -i.bak "/-w \/etc\/selinux\/ -p wa -k MAC-policy/d" /etc/audit/audit.rules
echo "-w /etc/selinux/ -p wa -k MAC-policy" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.8
sed -i.bak "/-w \/var\/log\/faillog -p wa -k logins/d" /etc/audit/audit.rules
sed -i.bak "/-w \/var\/log\/lastlog -p wa -k logins/d" /etc/audit/audit.rules
sed -i.bak "/-w \/var\/log\/tallylog -p wa -k logins/d" /etc/audit/audit.rules
echo "-w /var/log/faillog -p wa -k logins" >> /etc/audit/audit.rules
echo "-w /var/log/lastlog -p wa -k logins" >> /etc/audit/audit.rules
echo "-w /var/log/tallylog -p wa -k logins" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.9
sed -i.bak "/-w \/var\/run\/utmp -p wa -k session/d" /etc/audit/audit.rules
sed -i.bak "/-w \/var\/log\/wtmp -p wa -k session/d" /etc/audit/audit.rules
sed -i.bak "/-w \/var\/log\/btmp -p wa -k session/d" /etc/audit/audit.rules
echo "-w /var/run/utmp -p wa -k session" >> /etc/audit/audit.rules
echo "-w /var/log/wtmp -p wa -k session" >> /etc/audit/audit.rules
echo "-w /var/log/btmp -p wa -k session" >> /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.10 Collect Discretionary Access Control Permission Modification Events
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S chmod -S fchmod -S fchmodat -F auid>=500 -F auid!=4294967295 -k perm_mod"
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S chown -S fchown -S fchownat -S lchown -F auid>=500 -F auid!=4294967295 -k perm_mod"
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S setxattr -S lsetxattr -S fsetxattr -S removexattr -S lremovexattr -S fremovexattr -F auid>=500 -F auid!=4294967295 -k perm_mod"
echo ------------------------------------------------------------------------
echo 5.2.11 Collect Unsuccessful Unauthorized Access Attempts to Files
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access"
add_line /etc/audit/audit.rules "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=500 -F auid!=4294967295 -k access"
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access"
add_line /etc/audit/audit.rules "-a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=500 -F auid!=4294967295 -k access"
echo ------------------------------------------------------------------------
echo 5.2.12 Collect Use of Privileged Commands
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/fusermount -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/su -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/ping -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/mount -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/umount -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/bin/ping6 -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/chsh -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/staprun -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/newgrp -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/chage -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/pkexec -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/gpasswd -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/sudo -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/sudoedit -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/Xorg -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/chfn -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/at -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/passwd -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/bin/crontab -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/libexec/polkit-1/polkit-agent-helper-1 -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/libexec/pt_chown -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/libexec/openssh/ssh-keysign -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/sbin/suexec -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/sbin/usernetctl -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/usr/sbin/userhelper -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/lib64/dbus-1/dbus-daemon-launch-helper -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/sbin/pam_timestamp_check -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
add_line /etc/audit/audit.rules "-a always,exit -F path=/sbin/unix_chkpwd -F perm=x -F auid>=500 -F auid!=4294967295 -k privileged"
echo ------------------------------------------------------------------------
echo 5.2.13 
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k mounts"
echo ------------------------------------------------------------------------
echo 5.2.14 
add_line /etc/audit/audit.rules "-a always,exit -F arch=b64 -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k delete"
echo ------------------------------------------------------------------------
echo 5.2.15
sed -i.bak "/-w \/etc\/sudoers -p wa -k scope/d" /etc/audit/audit.rules
echo "-w /etc/sudoers -p wa -k scope" >>  /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.16
sed -i.bak "/-w \/var\/log\/sudo.log -p wa -k actions/d" /etc/audit/audit.rules
echo "-w /var/log/sudo.log -p wa -k actions" >>  /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.17
sed -i.bak "/-w \/sbin\/insmod -p x -k modules/d" /etc/audit/audit.rules
sed -i.bak "/-w \/sbin\/rmmod -p x -k modules/d" /etc/audit/audit.rules
sed -i.bak "/-w \/sbin\/modprobe -p x -k modules/d" /etc/audit/audit.rules
echo "-w /sbin/insmod -p x -k modules" >>  /etc/audit/audit.rules
echo "-w /sbin/rmmod -p x -k modules" >>  /etc/audit/audit.rules
echo "-w /sbin/modprobe -p x -k modules" >>  /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.2.18
sed -i.bak "/-e 2/d" /etc/audit/audit.rules
echo "-e 2" >>  /etc/audit/audit.rules
/etc/init.d/auditd restart > /dev/null
echo ------------------------------------------------------------------------
echo 5.3
sed -i.bak "/\/var\/log\/messages/d" /etc/logrotate.d/syslog
sed -i.bak "/\/var\/log\/secure/d" /etc/logrotate.d/syslog
sed -i.bak "/\/var\/log\/maillog/d" /etc/logrotate.d/syslog
sed -i.bak "/\/var\/log\/spooler/d" /etc/logrotate.d/syslog
sed -i.bak "/\/var\/log\/boot.log/d" /etc/logrotate.d/syslog
sed -i.bak "/\/var\/log\/cron/d" /etc/logrotate.d/syslog
sed -i.bak "/{/d" /etc/logrotate.d/syslog
sed -i.bak "/    sharedscripts/d" /etc/logrotate.d/syslog
sed -i.bak "/    postrotate/d" /etc/logrotate.d/syslog
sed -i.bak "/        \/bin\/kill -HUP `cat \/var\/run\/syslogd.pid 2> \/dev\/null` 2> \/dev\/null || true/d" /etc/logrotate.d/syslog
sed -i.bak "/    endscript/d" /etc/logrotate.d/syslog
sed -i.bak "/}/d" /etc/logrotate.d/syslog
echo "/var/log/messages" >> /etc/logrotate.d/syslog
echo "/var/log/secure" >> /etc/logrotate.d/syslog
echo "/var/log/maillog" >> /etc/logrotate.d/syslog
echo "/var/log/spooler" >> /etc/logrotate.d/syslog
echo "/var/log/boot.log" >> /etc/logrotate.d/syslog
echo "/var/log/cron" >> /etc/logrotate.d/syslog
echo "{" >> /etc/logrotate.d/syslog
echo "    sharedscripts" >> /etc/logrotate.d/syslog
echo "    postrotate" >> /etc/logrotate.d/syslog
echo "        /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true" >> /etc/logrotate.d/syslog
echo "    endscript" >> /etc/logrotate.d/syslog
echo "}" >> /etc/logrotate.d/syslog
echo ------------------------------------------------------------------------
echo 6.1.1
install_package cronie-anacron
echo ------------------------------------------------------------------------
echo 6.1.2
chkconfig crond on > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.3
chown root:root /etc/anacrontab  > /dev/null
chmod og-rwx /etc/anacrontab > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.4
chown root:root /etc/crontab  > /dev/null
chmod og-rwx /etc/crontab > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.5
chown root:root /etc/cron.hourly > /dev/null
chmod og-rwx /etc/cron.hourly > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.6
chown root:root /etc/cron.daily > /dev/null
chmod og-rwx /etc/cron.daily > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.7
chown root:root /etc/cron.weekly > /dev/null
chmod og-rwx /etc/cron.weekly > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.8
chown root:root /etc/cron.monthly  > /dev/null
chmod og-rwx /etc/cron.monthly > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.9
chown root:root /etc/cron.d > /dev/null
chmod og-rwx /etc/cron.d > /dev/null
echo ------------------------------------------------------------------------
echo 6.1.11
touch /etc/at.allow >/dev/null
touch /etc/cron.allow >/dev/null
/bin/rm /etc/cron.deny > /dev/null
/bin/rm /etc/at.deny  > /dev/null
chmod og-rwx /etc/cron.allow  > /dev/null
chmod og-rwx /etc/at.allow > /dev/null
chown root:root /etc/cron.allow  > /dev/null
chown root:root /etc/at.allow > /dev/null
echo ------------------------------------------------------------------------
echo 6.2.1 
sed -i '/Protocol /c\Protocol 2' /etc/ssh/sshd_config
echo ------------------------------------------------------------------------
echo 6.2.2 
sed -i "/#LogLevel /c\LogLevel INFO" /etc/ssh/sshd_config
echo ------------------------------------------------------------------------
echo 6.2.3
chown root:root /etc/ssh/sshd_config > /dev/null
chmod 600 /etc/ssh/sshd_config > /dev/null
echo ------------------------------------------------------------------------
echo 6.2.5
sed -i "/#MaxAuthTries /c\MaxAuthTries 4" /etc/ssh/sshd_config
echo ------------------------------------------------------------------------
echo 6.2.6
sed -i "/#IgnoreRhosts /c\IgnoreRhosts yes" /etc/ssh/sshd_config
echo ------------------------------------------------------------------------
echo 6.2.9
sed -i "/#PermitEmptyPasswords /c\PermitEmptyPasswords no" /etc/ssh/sshd_config
sed -i "/#PermitUserEnvironment /c\PermitUserEnvironment no" /etc/ssh/sshd_config
echo ------------------------------------------------------------------------
echo 6.2.11
sed -i.bak '/Ciphers/d' /etc/ssh/sshd_config
echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" >> /etc/ssh/sshd_config
/etc/init.d/sshd restart > /dev/null
echo ------------------------------------------------------------------------
echo 6.3.1
authconfig --passalgo=sha512 --update
echo ------------------------------------------------------------------------
echo 6.3.2
sed -i -e s/"password    requisite     pam_cracklib.so try_first_pass retry=3 type=/password    required     pam_cracklib.so try_first_pass retry=3 minlen=14 dcredit=-1 ucredit=-1 ocredit=-1 lcredit=-1"/g /etc/pam.d/system-auth
echo ------------------------------------------------------------------------
echo 6.3.3
sed -i.bak "/password requisite pam_passwdqc.so min=disabled,disabled,16,12,8/d"  /etc/pam.d/system-auth
echo "password requisite pam_passwdqc.so min=disabled,disabled,16,12,8" >> /etc/pam.d/system-auth
echo ------------------------------------------------------------------------
echo 6.3.4
sed -i.bak "/auth required pam_env.so/d" /etc/pam.d/system-auth
sed -i.bak "/auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth [success=1 default=bad] pam_unix.so/d" /etc/pam.d/system-auth
sed -i.bak "/auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth required pam_deny.so/d" /etc/pam.d/system-auth
echo "auth required pam_env.so" >> /etc/pam.d/system-auth
echo "auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth [success=1 default=bad] pam_unix.so" >> /etc/pam.d/system-auth
echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth required pam_deny.so" >> /etc/pam.d/system-auth
sed -i.bak "/auth required pam_env.so/d" /etc/pam.d/system-auth
sed -i.bak "/auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth [success=1 default=bad] pam_unix.so/d" /etc/pam.d/system-auth
sed -i.bak "/auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900/d" /etc/pam.d/system-auth
sed -i.bak "/auth required pam_deny.so/d" /etc/pam.d/system-auth
echo "auth required pam_env.so" >> /etc/pam.d/system-auth
echo "auth required pam_faillock.so preauth audit silent deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth [success=1 default=bad] pam_unix.so" >> /etc/pam.d/system-auth
echo "auth [default=die] pam_faillock.so authfail audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth sufficient pam_faillock.so authsucc audit deny=5 unlock_time=900" >> /etc/pam.d/system-auth
echo "auth required pam_deny.so" >> /etc/pam.d/system-auth
echo ------------------------------------------------------------------------
echo 6.3.6
sed -i.bak "/password sufficient pam_unix.o remember=5/d" /etc/pam.d/system-auth
echo "password sufficient pam_unix.o remember=5" >> /etc/pam.d/system-auth
echo ------------------------------------------------------------------------
echo 7.1.1
sed -i '/PASS_MAX_DAYS   99999/c\PASS_MAX_DAYS   90' /etc/login.defs
echo ------------------------------------------------------------------------
echo 7.1.2
sed -i '/PASS_MIN_DAYS/ c\PASS_MIN_DAYS   7'  /etc/login.defs
echo ------------------------------------------------------------------------
echo 7.1.3
sed -i '/PASS_WARN_AGE/ c\PASS_WARN_AGE   7'  /etc/login.defs
echo ------------------------------------------------------------------------
echo 7.2
for user in `awk -F: '($3 < 500) {print $1 }' /etc/passwd`; do
        if [ $user != "root" ]
        then
                /usr/sbin/usermod -L $user
                if [ $user != "sync" ] && [ $user != "shutdown" ] && [ $user != "halt" ] && [[ $user != ks* ]]
                then
                        /usr/sbin/usermod -s /sbin/nologin $user
                fi
        fi
done
echo ------------------------------------------------------------------------
echo 7.3
usermod -g 0 root > /dev/null
echo ------------------------------------------------------------------------
echo 7.4
echo "umask 077" >> /etc/profile.d/cis.sh
sed -i.bak "/umask 077/d" /etc/profile.d/cis.sh
sed -i.bak "/umask 077/d"  /etc/bashrc
echo "umask 077" >> /etc/profile.d/cis.sh
echo "umask 077" >> /etc/bashrc
echo ------------------------------------------------------------------------
echo 7.5
useradd -D -f 35
echo ------------------------------------------------------------------------
echo 9.1.2
/bin/chmod 644 /etc/passwd > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.3
/bin/chmod 000 /etc/shadow  > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.4
/bin/chmod 000 /etc/gshadow > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.5
/bin/chmod 644 /etc/group > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.6
/bin/chown root:root /etc/passwd > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.7
/bin/chown root:root /etc/shadow
echo ------------------------------------------------------------------------
echo 9.1.8
/bin/chown root:root /etc/gshadow
echo ------------------------------------------------------------------------
echo 9.1.9
/bin/chown root:root /etc/group
echo ------------------------------------------------------------------------
echo 9.1.10
find / -type f -perm -o+w > /root/backup/file_list.txt
find / -type f -perm -o+w -exec chmod o-w {} \; > /dev/null
echo ------------------------------------------------------------------------
echo 9.1.14 
df --local -P | awk {'if (NR!=1) print $6'} | xargs -I '{}' find '{}' -xdev -type f -perm -2000 -ls
echo ------------------------------------------------------------------------
echo 9.2.1
USERS="$(cut -d: -f 1 /etc/passwd)"
for u in $USERS
do
passwd -S $u | grep -Ew "NP" >/dev/null
if [ $? -eq 0 ]; then
passwd -l $u
fi
done
echo ------------------------------------------------------------------------
echo 9.2.2
/bin/grep '^+:' /etc/passwd
echo ------------------------------------------------------------------------
echo 9.2.3 
/bin/grep '^+:' /etc/shadow
echo ------------------------------------------------------------------------
echo 9.2.4
/bin/grep '^+:' /etc/group
echo ------------------------------------------------------------------------
echo 9.2.5
echo "Root dışında bir kullanıcı adı var ise /etc/passwd dosyasını kontrol et."
/bin/cat /etc/passwd | /bin/awk -F: '($3 == 0) { print $1 }'
echo ------------------------------------------------------------------------
echo 9.2.6 
if [ "`echo $PATH | /bin/grep :: `" != "" ]; then
 echo "Empty Directory in PATH (::)"
fi
if [ "`echo $PATH | /bin/grep :$`" != "" ]; then
 echo "Trailing : in PATH"
fi
p=`echo $PATH | /bin/sed -e 's/::/:/' -e 's/:$//' -e 's/:/ /g'`
set -- $p
while [ "$1" != "" ]; do
 if [ "$1" = "." ]; then
  echo "PATH contains ."
  shift
  continue
 fi
 if [ -d $1 ]; then
  dirperm=`/bin/ls -ldH $1 | /bin/cut -f1 -d" "`
  if [ `echo $dirperm | /bin/cut -c6 ` != "-" ]; then
   echo "Group Write permission set on directory $1"
  fi
  if [ `echo $dirperm | /bin/cut -c9 ` != "-" ]; then
   echo "Other Write permission set on directory $1"
  fi
  dirown=`ls -ldH $1 | awk '{print $3}'`
  if [ "$dirown" != "root" ] ; then
   echo $1 is not owned by root
  fi
  else
   echo ""
 fi
 shift
done
echo ------------------------------------------------------------------------
echo 9.2.7 
for dir in `/bin/cat /etc/passwd | /bin/egrep -v '(root|halt|sync|shutdown)' | /bin/awk -F: '($8 == "PS" && $7 != "/sbin/nologin") { print $6 }'`; do
 dirperm=`/bin/ls -ld $dir | /bin/cut -f1 -d" "`
 if [ `echo $dirperm | /bin/cut -c6 ` != "-" ]; then
  echo "Group Write permission set on directory $dir"
 fi
 if [ `echo $dirperm | /bin/cut -c8 ` != "-" ]; then
  echo "Other Read permission set on directory $dir"
 fi
 if [ `echo $dirperm | /bin/cut -c9 ` != "-" ]; then
  echo "Other Write permission set on directory $dir"
 fi
 if [ `echo $dirperm | /bin/cut -c10 ` != "-" ]; then
  echo "Other Execute permission set on directory $dir"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.8 
for dir in `/bin/cat /etc/passwd | /bin/egrep -v '(root|sync|halt|shutdown)' | /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
 for file in $dir/.[A-Za-z0-9]*; do
  if [ ! -h "$file" -a -f "$file" ]; then
   fileperm=`/bin/ls -ld $file | /bin/cut -f1 -d" "`
   if [ `echo $fileperm | /bin/cut -c6 ` != "-" ]; then
    echo "Group Write permission set on file $file"
   fi
   if [ `echo $fileperm | /bin/cut -c9 ` != "-" ]; then
    echo "Other Write permission set on file $file"
   fi
  fi
 done
done
echo ------------------------------------------------------------------------
echo 9.2.9 
for dir in `/bin/cat /etc/passwd | /bin/egrep -v '(root|sync|halt|shutdown)' | /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
 for file in $dir/.netrc; do
  if [ ! -h "$file" -a -f "$file" ]; then
   fileperm=`/bin/ls -ld $file | /bin/cut -f1 -d" "`
   if [ `echo $fileperm | /bin/cut -c5 ` != "-" ]
   then
    echo "Group Read set on $file"
   fi
   if [ `echo $fileperm | /bin/cut -c6 ` != "-" ]; then
    echo "Group Write set on $file"
   fi
   if [ `echo $fileperm | /bin/cut -c7 ` != "-" ]; then
    echo "Group Execute set on $file"
   fi
   if [ `echo $fileperm | /bin/cut -c8 ` != "-" ]; then
    echo "Other Read set on $file"
   fi
   if [ `echo $fileperm | /bin/cut -c9 ` != "-" ]; then
    echo "Other Write set on $file"
   fi
   if [ `echo $fileperm | /bin/cut -c10 ` != "-" ]; then
    echo "Other Execute set on $file"
   fi
  fi
 done
done
echo ------------------------------------------------------------------------
echo 9.2.10 
for dir in `/bin/cat /etc/passwd | /bin/egrep -v '(root|halt|sync|shutdown)' | /bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'`; do
 for file in $dir/.rhosts; do
  if [ ! -h "$file" -a -f "$file" ]; then
   echo ".rhosts file in $dir"
  fi
 done
done
echo ------------------------------------------------------------------------
echo 9.2.11 
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
 grep -q -P "^.*?:x:$i:" /etc/group
 if [ $? -ne 0 ]; then
  echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.12
cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
 if [ $uid -ge 500 -a ! -d "$dir" -a $user != "nfsnobody" ]; then
  echo "The home directory ($dir) of user $user does not exist."
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.13 
cat /etc/passwd | awk -F: '{ print $1 " " $3 " " $6 }' | while read user uid dir; do
 if [ $uid -ge 500 -a -d "$dir" -a $user != "nfsnobody" ]; then
  owner=$(stat -L -c "%U" "$dir")
  if [ "$owner" != "$user" ]; then
   echo "The home directory ($dir) of user $user is owned by $owner."
  fi
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.15 
echo "The Output for the Audit of Control 9.2.15 - Check for Duplicate UIDs is" /bin/cat /etc/passwd | /bin/cut -f3 -d":" | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  users=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | /usr/bin/xargs`
  echo "Duplicate UID ($2): ${users}"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.16 
echo "The Output for the Audit of Control 9.2.16 - Check for Duplicate GIDs is" /bin/cat /etc/group | /bin/cut -f3 -d":" | /bin/sort -n | /usr/bin/uniq -c | while read x ;do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  grps=`/bin/gawk -F: '($3 == n) { print $1 }' n=$2 /etc/group | xargs`
  echo "Duplicate GID ($2): ${grps}"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.17 
/bin/cat /etc/passwd |\
/bin/awk -F: '($3 < 500) { print $1" "$3 }' |\
while read user uid; do
found=0
for tUser in ${defUsers}
do
if [ ${user} = ${tUser} ]; then
found=1
fi
done
if [ $found -eq 0 ]; then
echo "User $user has a reserved UID ($uid)."
fi
done
echo ------------------------------------------------------------------------
echo 9.2.18 
echo "The Output for the Audit of Control 9.2.18 - Check for Duplicate User Names is" cat /etc/passwd | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  uids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 /etc/passwd | xargs`
  echo "Duplicate User Name ($2): ${uids}"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.19 
echo "The Output for the Audit of Control 9.2.19 - Check for Duplicate Group Names is" cat /etc/group | cut -f1 -d":" | /bin/sort -n | /usr/bin/uniq -c | while read x ; do
 [ -z "${x}" ] && break
 set - $x
 if [ $1 -gt 1 ]; then
  gids=`/bin/gawk -F: '($1 == n) { print $3 }' n=$2 /etc/group | xargs`
  echo "Duplicate Group Name ($2): ${gids}"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.20 
for dir in `/bin/cat /etc/passwd | /bin/awk -F: '{ print $6 }'`; do
 if [ ! -h "$dir/.netrc" -a -f "$dir/.netrc" ]; then
  echo ".netrc file $dir/.netrc exists"
 fi
done
echo ------------------------------------------------------------------------
echo 9.2.21 
for dir in `/bin/cat /etc/passwd | /bin/awk -F: '{ print $6 }'`; do
 if [ ! -h "$dir/.forward" -a -f "$dir/.forward" ]; then
  echo ".forward file $dir/.forward exists"
 fi
done
echo ------------------------------------------------------------------------
echo STS-RHEL5-110
/bin/chmod 750  /var/log/secure > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-124
/bin/chmod 640 /etc/snmp/snmpd.conf  > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-097
chkconfig nfslock off   > /dev/null
chkconfig rpcgssd off  > /dev/null
chkconfig rpcidmapd off  > /dev/null
chkconfig portmap off  > /dev/null
chkconfig nfs off  > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-023
/bin/chmod 700 /root > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-123
/bin/chmod 1777 /tmp > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-121
/bin/chmod  755 /usr > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-122
/bin/chmod  755 /etc > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-129
/bin/chmod 600 /etc/security/opasswd > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-130
/bin/chmod  755 /var > /dev/null
echo ------------------------------------------------------------------------
echo STS-RHEL5-075
sed -i.bak "/authpriv.*                                              \/var\/log\/secure/d" /etc/rsyslog.conf
sed -i.bak "/authpriv.* \/var\/log\/secure/d" /etc/rsyslog.conf
echo "authpriv.* /var/log/secure" >> /etc/rsyslog.conf
echo ------------------------------------------------------------------------
echo STS-RHEL5-024
chmod -R 755 /usr/share/
echo ------------------------------------------------------------------------
