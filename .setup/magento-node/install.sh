#!/usr/bin/env bash
# Paths:
SETUP_DIR_CUSTOM="/vagrant/.setup/magento-node"
MAGENTO_SRC_DIR='/vagrant/src/magento'
MAGENTO_DEST_DIR='/var/www/magento'
MYSQL_ROOT_PASSWORD='SecRetPaSsWord'
MAGENTO_DB_HOST='localhost'
MAGENTO_DB_NAME='magentodb'
MAGENTO_DB_USER='magentouser'
MAGENTO_DB_PASSWORD='magentoPwd'


# Install EPEL
yum install -y epel-release

# Add repos:
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
rpm -Uvh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm

# Install software:
yum install -y php70w php70w-opcache php70w-xml php70w-mcrypt \
    php70w-mbstring php70w-intl php70w-gd php70w-mbstring \
    php70w-pdo php70w-mysql mysql-server vim

# Files/configs overwrites:
cp -r $SETUP_DIR_CUSTOM/* /

mkdir -p $MAGENTO_DEST_DIR
rsync -azh $MAGENTO_SRC_DIR/ $MAGENTO_DEST_DIR/
chmod -R 0777 $MAGENTO_DEST_DIR/var $MAGENTO_DEST_DIR/app/etc $MAGENTO_DEST_DIR/pub/media $MAGENTO_DEST_DIR/pub/static

# Start services
service httpd restart
service mysql restart

# Set Magento db and user
/usr/bin/mysql -e 'create database `'$MAGENTO_DB_NAME'`'
/usr/bin/mysql -e 'create user `'$MAGENTO_DB_USER'`@`'$MAGENTO_DB_HOST'` identified by "'$MAGENTO_DB_PASSWORD'"'
/usr/bin/mysql -e 'grant all privileges on '$MAGENTO_DB_NAME'.* to `'$MAGENTO_DB_USER'`@`'$MAGENTO_DB_HOST'`'
/usr/bin/mysql -e 'flush privileges'

# Firewall: pass http connections
firewall-cmd --zone=public --change-interface=eth1
firewall-cmd --zone=public --add-service=http