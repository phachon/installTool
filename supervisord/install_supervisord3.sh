#!/bin/bash
# ---------------
# 安装 supervisord
# phachon@163.com
# ----------------
wget --no-check-certificate https://github.com/phachon/offlinePkg/raw/master/supervisor/supervisord3.zip
unzip supervisord.zip
cd supervisord

tar -zxvf setuptools-0.6c11.tar.gz
cd setuptools-0.6c11
python setup.py install

cd ../
tar -zxvf meld3-0.6.5.tar.gz
cd meld3-0.6.5
python setup.py install
cd ../

unzip elementtree-1.2.7-20070827-preview.zip
cd elementtree-1.2.7-20070827-preview
python setup.py install
cd ../

tar -zxvf supervisor-3.0a9.tar.gz
cd supervisor-3.0a9
python setup.py install

echo_supervisord_conf >/etc/supervisord.conf
cd ../

supervisord -c /etc/supervisord.conf

echo "done!"