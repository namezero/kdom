#!/bin/bash
PASSWDDB="kdom"
MAINDB="kdom"
mysql -uroot -e "update mysql.user set plugin=' ' where User='root';"
mysql -uroot -e "flush privileges;"
if [ -f /root/.my.cnf ]; then

    mysql -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"
    mysql -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -e "FLUSH PRIVILEGES;"

else
    echo "Veuillez saisir le mot de passe root MySql"
    read rootpasswd
    mysql -uroot -p${rootpasswd} -e "CREATE DATABASE ${MAINDB} /*\!40100 DEFAULT CHARACTER SET utf8 */;"

    mysql -uroot -p${rootpasswd} -e "DROP USER ${MAINDB}@localhost;"
    mysql -uroot -p${rootpasswd} -e "CREATE USER ${MAINDB}@localhost IDENTIFIED BY '${PASSWDDB}';"
    mysql -uroot -p${rootpasswd} -e "GRANT ALL PRIVILEGES ON ${MAINDB}.* TO '${MAINDB}'@'localhost';"
    mysql -uroot -p${rootpasswd} -e "FLUSH PRIVILEGES;"
fi