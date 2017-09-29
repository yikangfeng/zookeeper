#! /bin/bash
# @Author kangfeng.yi
# 用于分发zoo.cfg,java.env等文件到本机及远程机器及zookeeper数据目录的建立等

BASE_DIR="/home/work/hotel"
ZOOKEEPER_CONF_DIR=$BASE_DIR/zookeeper-3.4.6/conf

IPS="10.88.16.86 10.70.10.75 10.39.40.33 10.50.4.91 10.50.1.18";


cp -fr env/java.env $ZOOKEEPER_CONF_DIR
cp -fr env/zoo.cfg $ZOOKEEPER_CONF_DIR

mkdir -p /home/work/jvmlogs/1.7.0_80
mkdir -p /home/work/zookeeper-3.4.6/data
mkdir -p /home/work/zookeeper-3.4.6/datalog
echo 1 > /home/work/zookeeper-3.4.6/data/myid

myid=2
for ip in $IPS
do
    ssh work@$ip " mkdir -p /home/work/jvmlogs/1.7.0_80 ; mkdir -p /home/work/zookeeper-3.4.6/data ; mkdir -p /home/work/zookeeper-3.4.6/datalog ; echo $myid > /home/work/zookeeper-3.4.6/data/myid "
    
    scp -r $BASE_DIR/zookeeper-tools/env/zoo.cfg work@$ip:$ZOOKEEPER_CONF_DIR
    scp -r $BASE_DIR/zookeeper-tools/env/java.env work@$ip:$ZOOKEEPER_CONF_DIR
    
    ((myid=myid+1))
done

echo "dispatch successful"
