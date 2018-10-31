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
    ifconfig wlan0 down
    ifconfig wlan0 up
    ifdown wlan0 -ignore-error
    sleep 10
    ifup wlan0 -ignore-error

fi
