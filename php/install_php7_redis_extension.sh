#!/bin/bash
# ----------------------------------
# compile install php7 redis extension
# author: phachon@163.com
# used: ./install_php7_redis_extendion.sh
# notice: set php install dir
# ----------------------------------

# set php install dir
php_install_dir="/usr/local/php7"

wget --no-check-certificate https://github.com/phpredis/phpredis/archive/php7.zip
unzip php7.zip
cd phpredis-php7
${php_install_dir}/bin/phpize --with-php-config=${php_install_dir}/bin/php-config
./configure --with-php-config=${php_install_dir}/bin/php-config
make && make install
cd ..
rm -rf php7.zip
if [ -f "${php_install_dir}/lib/php/extensions/no-debug-non-zts-20151012/redis.so" ];then
    echo "[redis]">${php_install_dir}/etc/php.ini
    echo "extension=redis.so">>${php_install_dir}/etc/php.ini
    ${php_install_dir}/bin/php -m
fi
echo "done."

