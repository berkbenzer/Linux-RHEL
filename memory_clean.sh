free && sync && echo 3 > /proc/sys/vm/drop_caches && free


#To free pagecache:
echo 1 > /proc/sys/vm/drop_caches

#To free dentries and inodes:
echo 2 > /proc/sys/vm/drop_caches

#To free pagecache, dentries and inodes: (not execute on prod)
echo 3 > /proc/sys/vm/drop_caches
