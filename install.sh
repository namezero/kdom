#!/usr/bin/env bash
SETUP_DIR="/root/setup"
apt-get update  # To get the latest package listsapt-get update -y
apt-get upgrade -y
apt-get install samba -y
apt-get install apache2 -y
apt-get install php libapache2-mod-php -y
apt-get install mysql-server php-mysql -y
apt-get install phpmyadmin -y
apt-get install mosquitto -y
apt-get install mosquitto-clients -y
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install nodejs -y
apt-get install npm -y
npm install pm2 -g
apt-get install dos2unix -y
../apt autoremove -y
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
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 0 * * * /usr/sbin/ntpdate-debian" >> mycron
echo "*/2 * * * *   root    /var/node/kdom/api/services/wifi.sh" >> mycron
#install new cron file
crontab mycron
rm mycron
echo "Fin de l'installation"

#apache2
#  │ Configure database for phpmyadmin with dbconfig-common?  YES
# MySQL application password for phpmyadmin + confirmation
