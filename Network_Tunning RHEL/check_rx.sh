xxxxx:~]# egrep 'CPU|em1_1' /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       
  96:     219931          0     183428          0  IR-PCI-MSI-edge      em1_1
  98:   33702797          0   24668025          0  IR-PCI-MSI-edge      em1_1-fp-0
  99:   19844486          0   32755113          0  IR-PCI-MSI-edge      em1_1-fp-1
 100:   20288653          0   35093907          0  IR-PCI-MSI-edge      em1_1-fp-2
 101:   26187803          0   26220658          0  IR-PCI-MSI-edge      em1_1-fp-3
[oracle@xxxxx:~]# ethtool -g em1_!
Ring parameters for em1_!:
Cannot get device ring settings: No such device
[oracle@xxxxx:~]# ethtool -g em1_1
Ring parameters for em1_1:
Pre-set maximums:
RX:		4078
RX Mini:	0
RX Jumbo:	0
TX:		4078
Current hardware settings:
RX:		815
RX Mini:	0
RX Jumbo:	0
TX:		4078
