
yum install epel-release -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd

yum install -y gcc php php-cgi php-devel inotify-tools httpd mysql-devel postgresql-devel
git clone https://github.com/ossec/ossec-hids.git
cd ossec-hids/

./install.sh
(en/br/cn/de/el/es/fr/hu/it/jp/nl/pl/ru/sr/tr) [en]: en

What kind of installation do you want (server, agent, local, hybrid or help)? Server

Choose where to install the OSSEC HIDS [/var/ossec]: Press Enter

Do you want e-mail notification? (y/n) [y]: n

Do you want to run the integrity check daemon? (y/n) [y]: y

Do you want to run the rootkit detection engine? (y/n) [y]: y

Do you want to enable active response? (y/n) [y]: n

Do you want to enable remote syslog (port 514 udp)? (y/n) [y]: y

--- Press ENTER to continue ---
Start OSSEC for first time
/var/ossec/bin/ossec-control start
##After running OSSEC like this for first time, in future 'systemctl restart ossec' etc. can be used.


##############################################################
##Installing OSSEC web user interface (OSSEC-wui)			##
##Download and extract ossec-wui tar file from OSSEC webpage##
##############################################################
wget https://github.com/ossec/ossec-wui/archive/0.9.tar.gz

tar zxf 0.9.tar.gz
#Move ossec-wui directory to web root directory
mv ossec-wui-0.9/ /var/www/html/ossec-wui
#Navigate to ossec-wui directory and run the setup script.
cd /var/www/html/ossec-wui/

./setup.sh
#Answer the following
Username: centos
New password: centos
Re-type new password: centos

#Enter your web server user name (e.g. apache, www, nobody, www-data, ...) apache
#Here you can choose any username and password. The values do not seem to have any effect. User 'centos' does not needs to be any valid OS user.
#Change the permissions
usermod -aG ossec apache
cd /var/www/html/ossec-wui/
chmod 770 tmp/
chgrp apache tmp/
#Restart httpd & ossec
systemctl restart httpd

systemctl restart ossec
#To access your ossec-wui, navigate to your browser and enter;
#http://<your-server's-IP-address>/ossec-wui/
#Correct OSSEC web-UI timezone
#OSSEC taking time zone info from '/etc/php.ini'. Change the time zone depends on your locality.
#date.timezone = Asia/Kolkata
#Restart httpd
systemctl restart httpd
