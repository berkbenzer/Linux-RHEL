#!/bin/bash

 hostcheck () {    
    local tmpfile=$(mktemp)
    hammer host list | grep -F 'RHEL Server' > "$tmpfile"

    printf '%s\n' "$tmpfile"
}
group_counts () {
 
   local infile="$1"

    printf 'Linux Versions Count, Grouped by Linux Versions\n\n'
    awk -F '|' '{ c[$3]++ } END { for (h in c) printf("%d\t%s\n", c[h], h) }' "$infile" | sort -k 2
}

ver_and_hosts () {
    local infile="$1"

    printf 'Linux Versions and Hostnames\n\n'
    awk -F '|' '{ printf("%s | %s\n", $3, $2) }' "$infile" | sort
}


tmpfile=$( hostcheck )

{
    group_counts "$tmpfile"
    printf '\n\n'
    ver_and_hosts  "$tmpfile"
} > osversion.out

rm -f "$tmpfile"
NOW=$(date +'%d.%m.%Y')
cat osversion.out | mail -r xx@xx.com -s "$NOW Linux OS Version Check" xx@xxx.com
