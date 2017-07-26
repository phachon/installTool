#!/bin/bash
# -------------------------------
# - centos install nginx1.8.1
# - author: phachon@163.com
# -------------------------------
nginx_version="1.8.1"
nginx_install_dir="/usr/local/nginx"

yum install gcc gcc-c++ automake pcre pcre-devel zlip zlib-devel openssl openssl-devel

wget http://nginx.org/download/nginx-1.8.1.tar.gz
tar  xvf nginx-1.8.1.tar.gz
cd nginx-1.8.1

./configure  --prefix=${nginx_install_dir} \
--sbin-path=${nginx_install_dir}/sbin/nginx \
--conf-path=${nginx_install_dir}/conf/nginx.conf \
--error-log-path=/var/log/nginx/error.log \
--http-log-path=/var/log/nginx/access.log \
--pid-path=/var/run/nginx/nginx.pid \
--lock-path=/var/lock/nginx.lock \
--user=nginx \
--group=nginx \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_gzip_static_module \
--http-client-body-temp-path=/var/tmp/nginx/client/ \
--http-proxy-temp-path=/var/tmp/nginx/proxy/ \
--http-fastcgi-temp-path=/var/tmp/nginx/fcgi/ \
--http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
--http-scgi-temp-path=/var/tmp/nginx/scgi \
--with-pcre

mkdir ${nginx_install_dir}/logs
mkdir /var/log/nginx
mkdir /var/run/nginx
mkdir -p /var/tmp/nginx/client
mkdir -p /var/tmp/nginx/proxy
mkdir -p /var/tmp/nginx/fcgi
mkdir -p /var/tmp/nginx/uwsgi
mkdir -p /var/tmp/nginx/scgi

mkdir ${nginx_install_dir}/conf/conf.d

make && make install

wget "https://github.com/phachon/installTool/raw/master/nginx/www.conf.tar.gz"
tar -zxvf www.conf.tar.gz
mv www.conf  ${nginx_install_dir}/conf/conf.d

echo "done."