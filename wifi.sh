#!/bin/bash
router_ip=google.fr
log=/var/log/wifi.log
wlan=wlan0
check_interval=10
nbLoop=23;

echo "Starting wifi check "
echo "Starting wifi check " >> ${log}

# make sure we aren't running already
what=`basename $0`
for p in `ps h -o pid -C ${what}`; do
        if [[ ${p} != $$ ]]; then
                exit 0
        fi
done

exec 1>> /dev/null
exec 2>> ${log}
echo $(date) >> ${log}
# without check_interval set, we risk a 0 sleep = busy loop
if [ ! "$check_interval" ]; then
        echo "No check interval set!" >> ${log}
        exit 1
fi


startWifi () {
        echo "---------WIFI OFF ! -------------" >> ${log}
        echo $(date) >> $log
        sudo /bin/mount -a
        echo "ifdown wlan0" >> ${log}
        sudo ifup ${wlan}
        sudo ifdown ${wlan}
        sleep 2
        echo "ifconfig wlan0 down" >> ${log}
        sudo ifconfig ${wlan} up
        sudo ifup ${wlan}
        sudo ifup --force ${wlan}
        sudo ifdown ${wlan}
        sudo ifup ${wlan}
        sudo ifup ${wlan}

        sudo /bin/mount -a
       # sudo /sbin/dhclient -v -r
}

#ifconfig $eth down
#sudo ifconfig ${wlan} up
#startWifi
while [ $nbLoop -gt 0 ]
do
        echo $(date)" Check #$nbLoop" >> ${log}
    ping -c 1 ${router_ip} & wait $!
    if [ $? != 0 ]; then
        echo $(date)" attempting restart number $nbLoop..." >> ${log}
        startWifi
    fi
    sleep ${check_interval}
     nbLoop=$((nbLoop-1))
done
        echo $(date)" Fin essais..." >> ${log}
exit 1
