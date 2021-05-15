#!/bin/bash

#1 - 先拷install脚本到centos7
#sudo scp -r  install-ldap.sh root@192.168.122.171:/home/lwh
#sudo scp -r  install-ldap.sh root@192.168.122.83:/home/lwh
#2 - 然后在虚拟机里运行instll-ldap.sh

echo "1 - install yum-utils"
sudo yum install -y yum-utils
echo "2 - 配置aliyun镜像"
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/repo/Centos-7.repo

echo "3 - 安装openldap openldap openldap-clients openldap-servers"
sudo yum install -y openldap openldap-clients openldap-servers 

echo "4 - 关闭防火墙"
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "5 - 开机启动slapd"
sudo systemctl start slapd
sudo systemctl enable slapd

echo "6 - 安装一些小工具"
sudo yum install -y tree net-tools vim 

echo "7 - 关闭SELINUX 这个必须重启才能生效 我们把重启放到最后"
sed 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

echo "8 - 安装openssl"
sudo yum install -y openssl openssl-devel
#确认当前系统是否安装OpenSSL
#rpm -qa | grep openssl

echo "重启centos7"
sudo reboot

