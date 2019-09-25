#AUDIT SERVICE DISPACTH ERROR

/var/log/audit]# systemctl status auditd.service
   Active: active (running) 
   Sep 23 16:32:31 auditd[850]: dispatch error reporting limit reached - ending report notification.
   
:/var/log/audit]#vi /etc/audit/auditd.conf
#comment out the line below
#dispatcher = /sbin/audispd

systemctl stop auditd.service
#Failed to stop auditd.service: Operation refused, unit auditd.service may be requested by dependency only (it is configured to refuse manual start/stop).
#See system logs and 'systemctl status auditd.service' for details.

:/var/log/audit]#/usr/libexec/initscripts/legacy-actions/auditd/restart
#Stopping logging:                                          [  OK  ]
#Redirecting start to /bin/systemctl start auditd.service

:/var/log/audit]#systemctl status auditd.service -l

● auditd.service - Security Auditing Service
   Loaded: loaded (/usr/lib/systemd/system/auditd.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-09-25 10:37:23 +03; 2s ago
     Docs: man:auditd(8)
           https://github.com/linux-audit/audit-documentation
  Process: 5945 ExecStartPost=/sbin/augenrules --load (code=exited, status=0/SUCCESS)
  Process: 5941 ExecStart=/sbin/auditd (code=exited, status=0/SUCCESS)
 Main PID: 5942 (auditd)
   CGroup: /system.slice/auditd.service
           └─5942 /sbin/auditd

Sep 25 10:37:23  systemd[1]: Started Security Auditing Service.

###########################################################################################################



