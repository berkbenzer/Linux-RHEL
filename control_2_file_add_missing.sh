#!/bin/bash


for i in `cat /home/odeonuser/file1.txt`; do
      grep -i "$i" /home/xxx/file2.txt >/dev/null;
      if [[ $? == 0 ]]; then echo "$i exsists in both files";
        else
          echo "$i doesnt exsists in file2";
          echo $i >> /home/xxxx/file2.txt;
      fi;
  done
