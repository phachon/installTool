#!/bin/bash
# ----------------------------------
# compile install libmcrypt
# author: phachon@163.com
# used: ./libmcrypt.sh
# ----------------------------------
wget --no-check-certificate https://github.com/phachon/offlinePkg/raw/master/libmcrypt/libmcrypt-2.5.7.tar.gz
tar -zxvf libmcrypt-2.5.7.tar.gz
cd libmcrypt-2.5.7
./configure --prefix=/usr/local/libmcrypt
make && make install

echo "done."
