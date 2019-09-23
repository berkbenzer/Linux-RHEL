#HARD LINKS

  # inode numbers are same
  # you can not user hard link in different partitions
  # if the source file permissions changes linked filed permissions also changes
  # if orjinal file deleted you can still display the linked file


  ### Hard link files must be in the same partition in other case you can not use hard link

istsl75oeldb:~]# df -h
#Filesystem                        Size  Used Avail Use% Mounted on
#devtmpfs                          5.8G     0  5.8G   0% /dev
#tmpfs                             5.8G     0  5.8G   0% /dev/shm
#tmpfs                             5.8G   26M  5.8G   1% /run
#tmpfs                             5.8G     0  5.8G   0% /sys/fs/cgroup
#/dev/mapper/ol_istsl75oeldb-root   36G  4.2G   31G  12% /
#/dev/mapper/ol_istsl75oeldb-home   18G   37M   18G   1% /home
#/dev/sda2                        1014M  217M  798M  22% /boot
#/dev/mapper/vg_oracle-lv_oracle    99G   13G   81G  14% /u01
#tmpfs                             1.2G     0  1.2G   0% /run/user/1000

  #ln /home/oracle/lin.sh /
  #ln: failed to create hard link ‘/lin.sh’ => ‘/home/oracle/lin.sh’: Invalid cross-device link


root@istsl75oeldb:~]# pwd
/root
root@istsl75oeldb:~]# ll
total 8
-rw-------. 1 root root 2240 Aug 29 14:48 anaconda-ks.cfg
-rw-r--r--. 1 root root 2271 Aug 29 16:45 initial-setup-ks.cfg
-rw-r--r--. 2 root root    0 Sep 23 09:47 x.sh



istsl75oeldb:~]#ln x.sh /

istsl75oeldb:~]# ll -li / | grep x.sh
201730569 -rw-r--r--.   2 root   root        0 Sep 23 09:47 x.sh

[root@istsl75oeldb:~]# rm -f x.sh
istsl75oeldb:~]# ll -li / | grep x.sh
201730569 -rw-r--r--.   1 root   root        0 Sep 23 09:47 x.sh

#SOFT LINK

# it can cross the file system
#allows you to link between directories,
#has different inodes number and file permissions than original file, permissions will not be updated,
#has only the path of the original file, not the contents

~]# mkdir test
~]# cd test/
~# echo "welcome" > source.file

istsl75oeldb:~/test]# ll
total 1
-rw-r--r--. 1 root root  8 Sep 23 10:13 source.file

~/test]#  cat source.file
welcome
~/test]# ln -s source.file softlink.file
istsl75oeldb:~/test]# ll
total 4
lrwxrwxrwx. 1 root root 11 Sep 23 10:14 softlink.file -> source.file
-rw-r--r--. 1 root root  8 Sep 23 10:13 source.file

stsl75oeldb:~/test]# cat softlink.file
welcome
stsl75oeldb:~/test]# ls -lia
total 8
201730569 drwxr-xr-x. 2 root root   46 Sep 23 10:14 .
201326721 dr-xr-x---. 8 root root 4096 Sep 23 10:12 ..
201730573 lrwxrwxrwx. 1 root root   11 Sep 23 10:14 softlink.file -> source.file
201730571 -rw-r--r--. 1 root root    8 Sep 23 10:13 source.file












