ssh-keygen -t rsa -b 2048

rheltest:~]# ssh-keygen -t rsa -b 2048
Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:CIJwPEOs/UH5eHh74CZQpggAeEigXjbU9nd81kx6JdA root@rheltest
The key's randomart image is:
+---[RSA 2048]----+
|@*o...      .o   |
|*oB =o        E..|
|+=.@o+.   .   =..|
|+ *.=.=o . o + + |
| . o =.oS . o .  |
|    o + .        |
|     o .         |
|                 |
|                 |
+----[SHA256]-----+
[root@rheltest:~]# ssh-copy-id bbenzer@satellite
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/root/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys

bbenzer@satellite's password:
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh 'bbenzer@satellite'"
and check to make sure that only the key(s) you wanted were added.
[root@rheltest:~]# scp /tmp/ad/
krb5.conf    limits.conf  smb.conf     sssd.conf    
[root@rheltest:~]# scp /tmp/ad/smb.conf bbenzer@satellite:/tmp

smb.conf                                                                                                                                                                 100%   11KB   8.4MB/s   00:00    
[root@rheltest:~]#

