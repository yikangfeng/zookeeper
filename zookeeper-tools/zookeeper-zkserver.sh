#! /bin/bash
# @Author kangfeng.yi
# 用于执行本机及远程机器的zkServer.sh脚本

BASE_DIR="/home/work/hotel"


IPS="10.88.16.86 10.70.10.75 10.39.40.33 10.50.4.91 10.50.1.18";

#IPS="新机器IP"


$BASE_DIR/zookeeper-3.4.6/bin/zkServer.sh $1

for ip in $IPS
do

       ssh work@$ip " $BASE_DIR/zookeeper-3.4.6/bin/zkServer.sh $1 "

done

echo "start all successful."


