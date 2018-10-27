# K'Dom
![alt text](https://raw.githubusercontent.com/namezero/kdom/master/kdom.png)

Script d'installation de K'Dom sur Armbian stretch
## Prérequis (orangepi zero)
Télécharger et installer Win32diskimager

```
https://sourceforge.net/projects/win32diskimager/files/latest/download
```
Télécharger l'image armbian stretch

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
Il faudra m'envoyer la clé rsa publique qui sera affichée lors de l'installation (pour accéder au dépot privé)

### Accès à K'Dom

une fois l'installation terminée, vous pouvez accéder à K'Dom sur le port 80 de l'opi

#### Codes d'accès
```
    login = admin
    mot de passe : admin
```
