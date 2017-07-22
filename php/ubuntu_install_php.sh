#!/bin/bash
# ----------------------------------
# ubuntu install php7
# author: phachon@163.com
# used: ./ubuntu_install_php.sh
# apply: ubuntu14 ubuntu16 mint18.*
# ----------------------------------

# install start (set php version and install dir)
php_version="7.0.8"
php_install_dir="/usr/local/php7"
php_file_name="php-${php_version}.tar.bz2"
php_download_url="http://cn2.php.net/get/${php_file_name}/from/this/mirror"

apt-get update
# install base soft
apt-get install libxml2-dev
apt-get install build-essential
apt-get install openssl
apt-get install libssl-dev
apt-get install make
apt-get install curl
apt-get install libcurl4-gnutls-dev
apt-get install libjpeg-dev
apt-get install libpng-dev
apt-get install libmcrypt-dev
apt-get install libreadline6 libreadline6-dev
apt-get install libreadline6-dev
apt-get install libcurl3-openssl-dev
apt-get install libfreetype6-dev

#libssl 安装失败原因可能是 openssl版本太高,解决如下
#apt-get install aptitude
#aptitude install libssl-dev

# download php-7.0.8.tar.bz2
apt-get install -y wget
wget -O ${php_file_name} ${php_download_url}
tar jxf ${php_file_name}
cd php-${php_version}/

# make configure
./configure --prefix=${php_install_dir} \
--with-config-file-path=${php_install_dir}/etc \
--with-config-file-scan-dir=${php_install_dir}/etc/conf.d \
--with-mcrypt=/usr/include \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-gd \
--with-iconv \
--with-zlib \
--enable-xml \
--enable-bcmath \
--enable-shmop \
--enable-sysvsem \
--enable-inline-optimization \
--enable-mbregex \
--enable-fpm \
--enable-mbstring \
--enable-ftp \
--enable-gd-native-ttf \
--with-openssl \
--enable-pcntl \
--enable-sockets \
--with-xmlrpc \
--enable-zip \
--enable-soap \
--without-pear \
--with-gettext \
--enable-session \
--with-curl \
--with-jpeg-dir \
--with-freetype-dir \
--enable-opcache

make && make install

# config php
cp php.ini-production ${php_install_dir}/etc/php.ini
cp ${php_install_dir}/etc/php-fpm.conf.default ${php_install_dir}/etc/php-fpm.conf
cp ${php_install_dir}/etc/php-fpm.d/www.conf.default ${php_install_dir}/etc/php-fpm.d/www.conf

${php_install_dir}/bin/php -v