HISTTIMEFORMAT="%d/%m/%y %T "

echo 'HISTTIMEFORMAT="%d/%m/%y %T "' >> ~/.bashrc
source ~/.bashrc
source ~/.bash_profile

history -d $((HISTCMD-1)) && history -d [line entry number]
