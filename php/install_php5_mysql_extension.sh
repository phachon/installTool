#!/bin/bash
# ----------------------------------
# compile install php5 mysql extension
# author: phachon@163.com
# used: ./install_php5_mysql_extendion.sh
# notice: set php install dir
# ----------------------------------

php_version="5.5.36"
# set php install dir
php_install_dir="/usr/local/php5.5"
php_file_name="php-${php_version}.tar.bz2"
php_download_url="http://cn2.php.net/get/${php_file_name}/from/this/mirror"

# download php-5.5.36.tar.bz2
yum install -y wget
wget -O ${php_file_name} ${php_download_url}
tar jxf ${php_file_name}
cd php-${php_version}/ext/mysql

${php_install_dir}/bin/phpize --with-php-config=${php_install_dir}/bin/php-config
./configure --with-php-config=${php_install_dir}/bin/php-config --with-mysql=mysqlnd
make && make install
cd ..

if [ -f "${php_install_dir}/lib/php/extensions/no-debug-non-zts-20121212/mysql.so" ];then
    echo "[mysql]">>${php_install_dir}/etc/php.ini
    echo "extension=mysql.so">>${php_install_dir}/etc/php.ini
    ${php_install_dir}/bin/php -m
fi
echo "done."
