#!/bin/bash
#-----------------------
#-- install fcrontab
#-----------------------
weget https://github.com/snail007/fcron/raw/master/fcron-3.2.0-fixed-time-can-less-than-10-seconds.tar.gz
tar xzvf fcron-3.2.0-fixed-time-can-less-than-10-seconds.tar.gz
cd fcron-3.2.0
./configure --prefix=/usr --sysconfdir=/etc --without-sendmail
make && make install

echo "done."