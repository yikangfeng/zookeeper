#! /bin/bash
# @Author kangfeng.yi
# 用于拷贝zookeeper集群依赖环境到IPS配置的机器中
# 运行该脚本的机器需要SSH到IPS配置的机器列表免密码登录
# 需要在DEPLOY_DIR路径下zookeeper-tools/env目录下放置所有集群相关的依赖软件配置文件等
# 执行脚本在DEPLOY_DIR路径下zookeeper-tools 目录下

DEPLOY_DIR="/home/work/hotel"

ZOOKEEPER="zookeeper-3.4.6.tar"
JDK="jdk-7u80-linux-x64.tar.gz"

IPS="10.88.16.86 10.70.10.75 10.39.40.33 10.50.4.91 10.50.1.18";

#IPS="新机器IP"


#当前运行脚本机器环境部署

cp -fr $DEPLOY_DIR/zookeeper-tools/env/$JDK $DEPLOY_DIR/$JDK
cd $DEPLOY_DIR
tar -xvf $DEPLOY_DIR/$JDK 
rm -fr $DEPLOY_DIR/$JDK

cp -fr $DEPLOY_DIR/zookeeper-tools/env/$ZOOKEEPER $DEPLOY_DIR/$ZOOKEEPER
cd $DEPLOY_DIR
tar -xvf $DEPLOY_DIR/$ZOOKEEPER
rm -fr $DEPLOY_DIR/$ZOOKEEPER

for ip in $IPS
do

       ssh work@$ip " mkdir -p $DEPLOY_DIR "

       scp -r $DEPLOY_DIR/zookeeper-tools/env/$JDK work@$ip:$DEPLOY_DIR/$JDK

       ssh work@$ip " cd $DEPLOY_DIR ; tar -xvf $DEPLOY_DIR/$JDK ; rm -fr $DEPLOY_DIR/$JDK"

       scp -r $DEPLOY_DIR/zookeeper-tools/env/$ZOOKEEPER work@$ip:$DEPLOY_DIR/$ZOOKEEPER 
       
       ssh work@$ip " cd $DEPLOY_DIR ; tar -xvf $DEPLOY_DIR/$ZOOKEEPER ; rm -fr $DEPLOY_DIR/$ZOOKEEPER"

done

echo "deploy successful"


