#!/bin/sh
echo '正在安装依赖'
if cat /etc/os-release | grep "centos"
    then
    yum install unzip wget -y > /dev/null
    yum update curl -y
else
    apt-get install unzip wget -y > /dev/null
    apt-get update curl -y
fi

api=$1
key=$2
nodeId=$3
localPort=$4
license=$5
extraids=$6

kill -9 $(ps -ef | grep $key | grep -v grep | grep -v bash | awk '{print $2}') 1 > /dev/null
kill -9 $(ps -ef | grep defunct | grep -v grep | awk '{print $2}') 1 > /dev/null
echo '结束进程'
rm -rf $key
mkdir $key
cd $key
wget https://github.com/deepbwork/v2board-server/raw/master/v2board-server
wget https://github.com/v2ray/v2ray-core/releases/download/v4.21.3/v2ray-linux-64.zip

unzip v2ray-linux-64.zip
chmod 755 *
nohup `pwd`/v2board-server -api=$api -token=$key -node=$nodeId -localport=$localPort -license=$license -extraids=$extraids > v2board.log 2>&1 &
echo '部署完成'
sleep 3
cat v2board.log
if ls | grep "service.log"
	then
	cat service.log
else
	echo '启动失败'
fi