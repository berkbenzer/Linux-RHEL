for x in `seq 1 1 10`; do ps -eo state,pid,cmd | grep "^D"; echo "----"; sleep 5; done

 2990 auditd
D   9903 /usr/bin/unzip -q -o /tmp/.ahf.9616/ahf_install.9616.zip -d /tmp/.ahf.9616/oracle.ahf
D  14758 /usr/local/IBM/modules/perl /usr/local/IBM/modules/SUPERVISOR/11.1.0.0_r107670_1-1581594637/guard_supervisor
D  18640 /bin/sh -c hostname
D  18643 grep ^D
D  18644 /bin/sh -c hostname
D  26660 ora_lgwr_app_name
