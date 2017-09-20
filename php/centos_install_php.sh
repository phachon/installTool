#!/bin/bash
# ----------------------------------
# centos install php
# author: phachon@163.com
# used: ./centos_install_php.sh
# apply: centos6.*
# ----------------------------------

# install start (set php version and install dir)
php_version="7.0.8"
php_install_dir="/usr/local/php7"
php_file_name="php-${php_version}.tar.bz2"
php_download_url="http://cn2.php.net/get/${php_file_name}/from/this/mirror"

# install base soft
yum install gcc-c++ gcc cmake cyrus-sasl-devel libmemcached php-memcached  build-essential bison libreadline6 libreadline6-dev curl  libssl-dev libyaml-dev libxml2-dev libxslt-dev autoconf libc6-dev libcur* libxml2 libxml2-devel zlib1g zlib1g-dev  openssl openssl-devel bzip2 bzip2-devel curl curl-devel libjpeg libjpeg-devel  libpng libpng-devel  freetype-devel gmp-devel mysql-devel ncurses ncurses-devel unixODBC-devel  pspell-devel  libmcrypt libmcrypt-devel net-snmp net-snmp-devel mhash-devel libsqlite3-0 libsqlite3-dev sqlite3

# install libmcrypt
wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/attic/libmcrypt/libmcrypt-2.5.7.tar.gz
tar -zxvf libmcrypt-2.5.7.tar.gz
cd libmcrypt-2.5.7
./configure --prefix=/usr/local/libmcrypt
make && make install
cd ../

# download php-7.0.8.tar.bz2
yum install -y wget
wget -O ${php_file_name} ${php_download_url}
tar jxf ${php_file_name}
cd php-${php_version}/

# make configure
# php5 add mysql extension --with-mysql=mysqlnd \
./configure --prefix=${php_install_dir} \
--with-config-file-path=${php_install_dir}/etc \
--with-config-file-scan-dir=${php_install_dir}/etc/conf.d \
--with-mcrypt=/usr/local/libmcrypt \
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