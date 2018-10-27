#!/bin/sh
rm -rf /var/node/kdom/ui
mkdir -p /var/node/kdom/temp/
mkdir -p /var/node/kdom/ui/
cd /var/node/kdom/temp/
echo "Récupération des sources de l'UI K'Dom"
git init
git pull ssh://git@bitbucket.org/namezero/kdom-ui.git master
echo "copie du build"
mv /var/node/kdom/temp/build/* /var/node/kdom/ui
echo "suppression du dossier temporaire"
rm -rf /var/node/kdom/temp
echo "Récupération UI effectuée"
