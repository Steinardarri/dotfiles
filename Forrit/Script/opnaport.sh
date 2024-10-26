while true ; do date ; natpmpc -a 1 0 udp 60 -g 10.96.0.1 || { echo -e "ERROR with natpmpc command \a" ; break ; } ; sleep 45 ; done
