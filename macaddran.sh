###########################################################
#Hi, this my first script in github 
#This script does not claim to be the best.
#If you have ideas for improvement, help improve the code. 
#Thanks for attention. 
###########################################################

#!/bin/bash

if ip link show enp3s0 | grep -q "state UP"; 
then
    echo "Enp3s0 now is Online and going to shutdown Net.Interface enp3s0"
    ip link set dev enp3s0 down 
    sleep 5
    MAC=$((date; cat /proc/interrupts) | md5sum | sed -r 's/^(.{12}).*$/\1/; s/([0-9a-f]{2})/\1:/g; s/:$//;')
    echo $MAC
    ip link set dev enp3s0 address $MAC
    sleep 2
    echo "Show new MAC address"
    ip link show enp3s0
    sleep 1
    ip link set dev enp3s0 up
    sleep 5
    systemctl restart NetworkManager.service
    sleep 2
    systemctl restart openvpn@*.service
else
    echo "Net.Interface not online"
    echo "Restart NetworkManager.service"
    systemctl restart NetworkManager.service
fi

