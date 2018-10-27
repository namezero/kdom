# K'Dom
![alt text](https://raw.githubusercontent.com/namezero/kdom/master/images/kdom.png)

Script d'installation de K'Dom sur Armbian stretch
## Prérequis (orangepi zero)
Télécharger et installer Win32diskimager

```
https://sourceforge.net/projects/win32diskimager/files/latest/download
```
Télécharger et décompresser l'image armbian stretch

```
https://dl.armbian.com/orangepizero/archive/Armbian_5.59_Orangepizero_Debian_stretch_next_4.14.65.7z
```
Ecrire l'image sur la care SD

Booter l'orangepi, changer le mot de passe de root, et activer l'accès au :

```
armbian-config
 System/Hardware/
 cocher uart1, 2, 3 et usbhost0, 1, 2, 3
```
Au passage, mettre le bon timezone :

```
    Personal/Timezone
```
Changer aussi le hostname ->KDom

## Installation

```
git clone https://github.com/namezero/kdom.git
cd kdom
```
Modifiez le fichier "interfaces" selon la confiuration de votre réseau (clé wifi, ip statique, passerelle...)

```
nano interfaces
```
Lancer l'installation de KDom, celà prendra quelques minutes, selon votre débit
```
bash ./install.sh
```
Lors de l'installation vous serez invité a saisir/choisir le mot de passe pour MySql, et la config de phpMyAdmin

Il faudra m'envoyer la clé SHA256 qui sera affichée lors de l'installation (pour que je la colle dans bitbucket)

### Accès à K'Dom

une fois l'installation terminée, vous pouvez accéder à K'Dom sur le port 80 de l'opi

#### Codes d'accès
```
login : admin
Mot de passe : admin
```

#### Mises à jour
Pour mettre à jour l'application :
```
sh ./api.sh
sh ./ui.sh
```

#### Prochaine release

Alarme : prise en charge des capteurs de porte, capteurs de présence, sirènes
Camera de surveillance : prise en charge des cameras ONVIF
Senarios avancés

## ScreenShots

![alt text](https://raw.githubusercontent.com/namezero/kdom/master/images/Screenshot_1.png)


![alt text](https://raw.githubusercontent.com/namezero/kdom/master/images/Screenshot_2.png)


![alt text](https://raw.githubusercontent.com/namezero/kdom/master/images/Screenshot_3.png)


![alt text](https://raw.githubusercontent.com/namezero/kdom/master/images/Screenshot_4.png)