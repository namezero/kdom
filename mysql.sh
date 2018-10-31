#!/bin/bash
PASSWDDB="kdom"
MAINDB="kdom"
mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

#mysql -uroot -e "update mysql.user set plugin=' ' where User='root';"
#mysql -uroot -e "flush privileges;"
