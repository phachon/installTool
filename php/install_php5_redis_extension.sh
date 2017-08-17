#!/bin/bash
# ----------------------------------
# compile install php5 redis extension
# author: phachon@163.com
# used: ./install_php5_redis_extendion.sh
# notice: set php install dir
# ----------------------------------

# set php install dir
php_install_dir="/usr/local/php5.5"

wget --no-check-certificate https://github.com/phpredis/phpredis/archive/2.2.8.tar.gz
tar -zxvf 2.2.8.tar.gz
cd phpredis-2.2.8
${php_install_dir}/bin/phpize --with-php-config=${php_install_dir}/bin/php-config
./configure --with-php-config=${php_install_dir}/bin/php-config
make && make install
cd ..
rm -rf phpredis-2.2.8/
rm -rf 2.2.8.tar.gz
if [ -f "${php_install_dir}/lib/php/extensions/no-debug-non-zts-20121212/redis.so" ];then
    echo "[redis]">>${php_install_dir}/etc/php.ini
    echo "extension=redis.so">>${php_install_dir}/etc/php.ini
    ${php_install_dir}/bin/php -m
fi
echo "done."
