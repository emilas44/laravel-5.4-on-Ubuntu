##################################################################
#!/bin/bash

# update the sources
sudo apt update
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::updated apt repos"
sleep 2

# install zip & git
sudo apt -y install zip git
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed NGINX"
sleep 2

# install nginx
sudo apt -y install nginx
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed NGINX"
sleep 2


# install php and needed mods
sudo apt install -y curl php
sudo apt install -y php-mysql php-fpm php-curl php-gd php7.0-mcrypt php-mbstring php-gettext php-token-stream php-zip
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed PHP7"
sleep 2


# enable the mods for laravel
sudo phpenmod mcrypt mbstring curl gettext
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::enabled PHP mods"
sleep 2


# install mysql
sudo apt -y install mysql-server
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed mysql-server"
sleep 2


# disable cgi scripting  -security reasons
sudo -- sh -c "echo 'cgi.fix_pathinfo=0' >> /etc/php/7.0/fpm/php.ini"
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::disabled cgi scripting -security reasons"
sleep 2


# restart to apply changes
sudo systemctl restart php7.0-fpm
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::restarted PHP"
sleep 2


# restart nginx
sudo service nginx restart
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::restarted NGINX"
sleep 2

# do a secure mysql installation
sudo mysql_secure_installation <<EOF
password
n
y
y
y
y
y
EOF

echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::mysql secure installed 1/2"
sleep 2

# do a secure mysql installation
sudo mysql_secure_installation <<EOF
password
n
y
y
y
y
y
EOF

echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::mysql secure installed 1/2"
sleep 2

mysql -u root -ppassword << EOF

UPDATE mysql.user SET authentication_string=PASSWORD("password") where user='root';
DROP USER IF EXISTS ''@'localhost';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
EOF

echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::mysql secure installed 2/2"
sleep 2

sudo apt install -y git
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed git"
sleep 2

# install redis
sudo apt install -y redis-server
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed redis"
sleep 2

#install composer
cd /home/$USER
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed composer"
sleep 2

# install laravel installer
composer global require laravel/installer
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::installed laravel installer"
sleep 2

# clean unnecesary files from apt-get
sudo apt-get clean
echo "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::cleaned apt-files"
sleep 2

echo ":::::::::::::::::::::::::::: INSTALLATION COMPLETED! ::::::::::::::::::::::::::::::::"
