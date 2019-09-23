#N = Create user define chain
iptables -N userchain

#E = Rename user defined chain
iptable -E userchain newuserchain

#X = Delete user define chain
iptable -X userchain
