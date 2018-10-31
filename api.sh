#!/bin/sh
echo "Initialisation de l'API K'Dom"
#rm -rf /var/node/kdom/api/
mkdir -p /var/node/kdom/api/
cd /var/node/kdom/api/
echo "Récupération des sources de l'API K'Dom"
git init
git pull ssh://git@bitbucket.org/namezero/kdom-api.git master
echo "Installation des packages npm"
sudo npm install
echo "Démarrage de l'API"
npm run prod
echo "Configuration de apache"
\cp /var/node/kdom/api/services/apache /etc/apache2/sites-enabled/000-default.conf
/etc/init.d/apache2 restart
echo "Configuration des services systemd"
find /var/node/kdom/api/services/ -type f -name "*.sh" -print0 | xargs -0 dos2unix
chmod +x /var/node/kdom/api/services/setup/wifi.sh
\cp /var/node/kdom/api/services/mosquitto.service /etc/systemd/system/mosquitto.service
\cp /var/node/kdom/api/services/xradio.service /etc/systemd/system/xradio.service
echo "Démarrage des services systemd"
systemctl daemon-reload
systemctl enable mosquitto
systemctl enable xradio
systemctl start mosquitto
echo "Récupération API effectuée"
