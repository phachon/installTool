#!/bin/bash
# -------------------------------
# CentOS Nginx 1.24.0 安装脚本
# -------------------------------

set -e  # 任何命令失败时立即退出脚本

# 全局变量
nginx_version="1.24.0"
nginx_source="nginx-${nginx_version}.tar.gz"
download_url="http://nginx.org/download/${nginx_source}"
nginx_install_dir="/usr/local/nginx"
temp_dir="/tmp/nginx-install-$(date +%s)"
nginx_user="nginx"
nginx_group="nginx"

# 安装依赖
install_dependencies() {
    echo "正在安装系统依赖..."
    yum install -y \
        gcc \
        gcc-c++ \
        automake \
        pcre pcre-devel \
        zlib zlib-devel \
        openssl openssl-devel \
        wget
}

# 创建系统用户和组
create_nginx_user() {
    if ! id -u ${nginx_user} &>/dev/null; then
        echo "正在创建系统用户: ${nginx_user}"
        useradd -r -s /sbin/nologin ${nginx_user}
    fi
}

# 下载和解压源码
prepare_source() {
    mkdir -p ${temp_dir}
    cd ${temp_dir}

    if [ ! -f "${nginx_source}" ]; then
        echo "正在下载 Nginx 源码..."
        wget --no-check-certificate ${download_url}
    fi

    echo "正在解压源码包..."
    tar xzf ${nginx_source}
}

# 编译安装
compile_install() {
    cd "nginx-${nginx_version}"
    
    echo "正在配置编译参数..."
    ./configure \
        --prefix=${nginx_install_dir} \
        --sbin-path=${nginx_install_dir}/sbin/nginx \
        --conf-path=${nginx_install_dir}/conf/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx/nginx.pid \
        --lock-path=/var/lock/nginx.lock \
        --user=${nginx_user} \
        --group=${nginx_group} \
        --with-http_ssl_module \
        --with-http_stub_status_module \
        --with-http_gzip_static_module \
        --http-client-body-temp-path=/var/tmp/nginx/client \
        --http-proxy-temp-path=/var/tmp/nginx/proxy \
        --http-fastcgi-temp-path=/var/tmp/nginx/fcgi \
        --http-uwsgi-temp-path=/var/tmp/nginx/uwsgi \
        --http-scgi-temp-path=/var/tmp/nginx/scgi \
        --with-pcre \
        --with-stream

    echo "正在编译安装..."
    make -j$(nproc)
    make install
}

# 创建目录结构
create_directories() {
    echo "创建目录结构..."
    mkdir -p \
        ${nginx_install_dir}/conf/conf.d \
        /var/log/nginx \
        /var/run/nginx \
        /var/lock/nginx \
        /var/tmp/nginx/{client,proxy,fcgi,uwsgi,scgi}

    chown -R ${nginx_user}:${nginx_group} \
        /var/log/nginx \
        /var/run/nginx \
        /var/lock/nginx \
        /var/tmp/nginx
}

# 配置 systemd 服务
setup_systemd() {
    echo "配置 systemd 服务..."
    cat > /etc/systemd/system/nginx.service << EOF
[Unit]
Description=The NGINX HTTP and reverse proxy server
After=network.target

[Service]
Type=forking
PIDFile=/var/run/nginx/nginx.pid
ExecStartPre=${nginx_install_dir}/sbin/nginx -t
ExecStart=${nginx_install_dir}/sbin/nginx
ExecReload=${nginx_install_dir}/sbin/nginx -s reload
ExecStop=${nginx_install_dir}/sbin/nginx -s quit
PrivateTmp=true
Restart=on-failure
RestartSec=5
TimeoutStopSec=5

[Install]
WantedBy=multi-user.target
EOF

    systemctl daemon-reload
}

# 清理临时文件
cleanup() {
    echo "清理安装文件..."
    rm -rf ${temp_dir}
}

# 主执行流程
main() {
    install_dependencies
    create_nginx_user
    prepare_source
    compile_install
    create_directories
    setup_systemd
    cleanup

    echo "安装完成！"
    echo "启动命令: systemctl start nginx"
    echo "设置开机启动: systemctl enable nginx"
    echo "配置文件位置: ${nginx_install_dir}/conf/"
}

# 执行主函数
main
