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
    ifdown wlan0
    sleep 10
    ifup wlan0

fi
