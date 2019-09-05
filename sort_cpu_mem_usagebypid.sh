ps -eo pcpu,pmem,pid,user,args | sort -r -k1 | head -20


#%CPU %MEM    PID USER     COMMAND
# 0.2  0.7   2718 oracle   ora_dia0_murat
# 0.1  1.7   2816 oracle   ora_cjq0_murat
