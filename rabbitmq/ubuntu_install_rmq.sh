#!/bin/bash
# -------------------------------
# - ubuntu install rabbitMQ
# - author: phachon@163.com
# - ubuntu14 ubuntu16 mint18
# -------------------------------

apt-get update

# apt-get install
apt-get install rabbitmq-server

# add user
rabbitmqctl add_user test 123456
# set user administrator
rabbitmqctl set_user_tags test administrator
# set user read write permission
rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

# install rabbitmq management plugins
rabbitmq-plugins enable rabbitmq_management

echo "done"

# Browser access
# http://127.0.0.1:15672
# guest guest