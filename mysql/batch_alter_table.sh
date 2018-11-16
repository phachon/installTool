#!/bin/bash
#批量修改表结构
HOST="127.0.0.1"
USERNAME="root"
PASSWORD="123456"
DBNAME="test"

TABLE_COUNT=4
n=0
while(( $n<$TABLE_COUNT ))
do
	alter_table_sql="ALTER TABLE ${n} ADD \`user_id\` VARCHAR(100) NOT NULL DEFAULT '' COMMENT '用户id'"
	echo $alter_table_sql
	mysql -h${HOST} -u${USERNAME} -p${PASSWORD} ${DBNAME} -e "${alter_table_sql}"
	let "n++"
done