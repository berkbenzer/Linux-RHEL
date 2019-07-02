mkdir /backups/
# tar -zcvf /backups/rpmdb-$(date +"%d%m%Y").tar.gz /var/lib/rpm

Next, verify the integrity of the master package metadata file /var/lib/rpm/Packages; this is the file that needs rebuilding, but first remove /var/lib/rpm/__db* files to prevent stale locks using following commands.

# rm -f /var/lib/rpm/__db*
# /usr/lib/rpm/rpmdb_verify /var/lib/rpm/Packages

In case the above operation fails, meaning you still encounter errors, then you should dump and load a new database. Also verify the integrity of the freshly loaded Packages file as follows.

# cd /var/lib/rpm/
# mv Packages Packages.back
# /usr/lib/rpm/rpmdb_dump Packages.back | /usr/lib/rpm/rpmdb_load Packages
# /usr/lib/rpm/rpmdb_verify Packages


Now to check the database headers, query all installed packages using the -q and -a flags, and try to carefully observe any error(s) sent to the stderror.
# rpm -qa >/dev/null #output is discarded to enable printing
rpm -vv --rebuilddb
