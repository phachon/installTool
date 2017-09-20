#!/bin/bash
# ----------------------------------
# compile install libiconv
# author: phachon@163.com
# used: ./install_libiconv.sh
# ----------------------------------
wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.1.tar.gz
tar -zxvf libiconv-1.13.1.tar.gz
cd libiconv-1.13.1
./configure --prefix=/usr/local/libiconv
make
make install
