#!/usr/bin/env bash
SETUP_DIR=$PWD
PASSWORD="kdom"
#sh -c "wpa_passphrase Khaled notebook >> /etc/wpa_supplicant/wpa_supplicant.conf"
#dans interface wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
cd /usr/local/
git clone https://github.com/zwindler/dynhost
chmod +x dynhost/dynhost
apt-get update
apt-get upgrade -y
apt-get install build-essential nmap git resolvconf samba dnsmasq -y
apt-get install apache2 ntp -y
apt-get install php libapache2-mod-php -y
apt-get install mysql-server php-mysql -y
sed -i "s/80/8000/g" /etc/apache2/ports.conf
sed -i "s/443/44300/g" /etc/apache2/ports.conf
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password ${PASSWORD}' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

service apache2 restart
apt-get install nginx phpmyadmin -y
apt-get install mosquitto -y
apt-get install mosquitto-clients -y
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt-get install nodejs -y
apt-get install npm -y
npm install pm2 -g
apt-get install dos2unix -y
npm install -g --unsafe-perm homebridge
npm install -g homebridge-alexa
npm install -g homebridge-cmdswitch2
apt-get autoremove -y
echo "Europe/Dublin" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata
dpkg-reconfigure tzdata
dpkg-reconfigure resolvconf
echo "Sous domaine kdm.fr ? :"
read sd
sed -i "s/khaled/${sd}/g" ${SETUP_DIR}/kdom-nginx
\cp ${SETUP_DIR}/kdom-nginx /etc/nginx/sites-enabled/default
service nginx restart
apt-get install certbot python-certbot-nginx -t stretch-backports
certbot --nginx
echo "SSID du wifi ? :"
read ssdwifi
echo "Mot de passe du wifi ? :"
read pwdwfi
echo "IP statique de la box ? :"
read BOX_IP
echo "Masque réseau ? :"
read BOX_MASK
echo "Gateway ? :"
read BOX_GATEWAY
sh -c "wpa_passphrase ${ssdwifi} ${pwdwfi} >> /etc/wpa_supplicant/wpa_supplicant.conf"
sed -i "s/BOX_IP/${BOX_IP}/g" ${SETUP_DIR}/interfaces
sed -i "s/BOX_MASK/${BOX_MASK}/g" ${SETUP_DIR}/interfaces
sed -i "s/BOX_GATEWAY/${BOX_GATEWAY}/g" ${SETUP_DIR}/interfaces
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
sh ${SETUP_DIR}/restartAPI.sh
sh ${SETUP_DIR}/firstStart.sh
sh ${SETUP_DIR}/ui.sh
#sudo chmod +x /var/node/kdom/api/services/setup/wifi.sh
#write out current crontab
crontab -l > mycron
#echo new cron into cron file
echo "0 0 * * * /usr/sbin/ntpdate-debian" >> mycron
echo "*/5 * * * *  sh /var/node/kdom/api/services/setup/wifi.sh" >> mycron
echo "0 4   *   *   *    /sbin/shutdown -r +5" >> mycron
echo "* 7,19 * * * certbot -q renew" >> mycron

#install new cron file
crontab mycron
rm mycron

echo "Fin de l'installation"

#apache2
#  │ Configure database for phpmyadmin with dbconfig-common?  YES
# MySQL application password for phpmyadmin + confirmation
