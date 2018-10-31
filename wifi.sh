#!/bin/sh

# */5 *   * * *   root    /var/node/domotique/server/services/wifi-rebooter.sh

SERVER=8.8.8.8

# Only send two pings, sending output to /dev/null
ping -I wlan0 -c2 ${SERVER} > /dev/null
#ntpdate fr.pool.ntp.org
# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]
then
    # Restart the wireless interface
    systemctl stop network-manager.service
    systemctl disable network-manager.service
    echo "restarting wlan0"
    sudo ifconfig wlan0 down
    echo "ifconfig wlan0 down"
    ifconfig wlan0 up
    sleep 5
    sudo ifdown wlan0 --ignore-error
    echo "ifdown wlan0"
    sleep 5
    sudo ifup wlan0
    sudo ifup wlan0 --ignore-error
    sleep 5
    sudo ifup wlan0
    echo "ifup wlan0"

    echo "restarting network service"
   pm2 restart NETWORK

fi
