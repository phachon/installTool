#!/bin/bash
#---------------------------
#-- redis install
#-- author: phachon@163.com
#---------------------------
wget http://download.redis.io/releases/redis-3.2.9.tar.gz
tar xzf redis-3.2.9.tar.gz
cd redis-3.2.9
make

if [ ! -d "/usr/local/redis" ]; then
    mkdir /usr/local/redis
    mkdir /usr/local/redis/bin
    mkdir /usr/local/redis/etc
fi

cp redis.conf /usr/local/redis/etc/
cp src/redis-server /usr/local/redis/bin/
cp src/redis-cli /usr/local/redis/bin/
cp src/redis-check-rdb /usr/local/redis/bin/
cp src/redis-check-benchmark /usr/local/redis/bin/
cp src/redis-check-aof /usr/local/redis/bin/
cp src/redis-check-sentinel /usr/local/redis/bin/


echo "done."