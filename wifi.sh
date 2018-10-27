#!/bin/bash

# */5 *   * * *   root    /var/node/domotique/server/services/wifi-rebooter.sh

SERVER=8.8.8.8

# Only send two pings, sending output to /dev/null
ping -I wlan0 -c2 ${SERVER} > /dev/null
#ntpdate fr.pool.ntp.org
# If the return code from ping ($?) is not 0 (meaning there was an error)
if [ $? != 0 ]
then
    # Restart the wireless interface
    echo "restarting wlan0"
    modprobe xradio_wlan
    iwconfig wlan0 power on
    sleep 5
    ifdown wlan0
    sleep 5
    ifup wlan0
    sleep 5
    ifup wlan0
    sleep 1
    /etc/init.d/mosquitto restart

fi
