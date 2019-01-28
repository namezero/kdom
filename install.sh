#!/usr/bin/env bash
SETUP_DIR=$PWD
PASSWORD="Uw206Ttu"
#sh -c "wpa_passphrase MAX notebook >> /etc/wpa_supplicant/wpa_supplicant.conf"
#dans interface wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
apt-get update
apt-get upgrade -y
apt-get install samba -y
apt-get install apache2 -y
apt-get install php libapache2-mod-php -y
apt-get install mysql-server php-mysql -y

echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

apt-get install phpmyadmin -y
apt-get install mosquitto -y
apt-get install mosquitto-clients -y
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install nodejs -y
apt-get install npm -y
npm install pm2 -g
apt-get install dos2unix -y
../apt autoremove -y
echo "Europe/Dublin" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
#dpkg-reconfigure tzdata
dpkg-reconfigure resolvconf
\cp ${SETUP_DIR}/interfaces /etc/network/interfaces
sh ${SETUP_DIR}/mysql.sh
ssh-keygen
cat /root/.ssh/id_rsa.pub
echo "La clé ssh a été copié dans bitbucket ?"
select yn in "Yes" "No"; do
    case $yn in
        Yes )

        break;;
        No ) exit;;
    esac
done
mkdir -p /var/node/kdom/
cd /var/node/kdom/
git init
sh ${SETUP_DIR}/api.sh
sh ${SETUP_DIR}/ui.sh
#sudo chmod +x /var/node/kdom/api/services/setup/wifi.sh
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 0 * * * /usr/sbin/ntpdate-debian" >> mycron
echo "*/5 * * * *  sh /var/node/kdom/api/services/setup/wifi.sh" >> mycron
echo "0 4   *   *   *    /sbin/shutdown -r +5" >> mycron
#install new cron file
crontab mycron
rm mycron
echo "Fin de l'installation"

#apache2
#  │ Configure database for phpmyadmin with dbconfig-common?  YES
# MySQL application password for phpmyadmin + confirmation
