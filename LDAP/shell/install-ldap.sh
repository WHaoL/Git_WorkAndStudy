#!/bin/bash
set -x
set -e

#1 - 先拷install脚本到centos7
#sudo scp -r  install-ldap.sh root@ldap-test01:/home/lwh
#sudo scp -r  install-ldap.sh root@ldap-test02:/home/lwh
#ldap-test01 及 ldap-test02 用ifconfig查看
#2 - 然后在虚拟机里运行instll-ldap.sh

echo "1 - install yum-utils"
sudo yum install -y yum-utils
echo "2 - 配置aliyun镜像"
sudo yum-config-manager \
    --add-repo \
    http://mirrors.aliyun.com/repo/Centos-7.repo

echo "3 - 安装openldap套件"
sudo yum install -y openldap         
sudo yum install -y openldap-clients 
sudo yum install -y openldap-servers 
sudo yum install -y openldap-devel
sudo yum install -y compat-openldap #主从依赖
sudo yum install -y openldap-servers-sql
sudo yum install -y migrationtools #用户转换依赖
sudo yum install -y unixODBC
# sudo yum install -y nss-pam-ldapd
# rpm -qa |grep openldap #查看安装了哪些包

#数据库模板初始化
# cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
# chown ldap:ldap /var/lib/ldap/DB_CONFIG

echo "4 - 关闭防火墙"
sudo systemctl stop firewalld
sudo systemctl disable firewalld

echo "5 - 开机启动slapd"
sudo systemctl start slapd
sudo systemctl enable slapd

echo "6 - 安装一些小工具"
sudo yum install -y tree net-tools vim wget

echo "7 - 关闭SELINUX 这个必须重启才能生效 我们把重启放到最后"
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
# sestatus -v 可以查看 SElinux status: disabled

# # echo "8 - 安装openssl"
# sudo yum install -y openssl openssl-devel
#确认当前系统是否安装OpenSSL
#rpm -qa | grep openssl

# echo "9 - 安装rsync 并 启动rsync"
# sudo yum -y install rsync
# sudo systemctl start rsyncd.service
# sudo systemctl enable rsyncd.service
# netstat -lnp|grep 873 #检查是否启动

echo "10 - 安装httpd phpldapadmin 并启动"
sudo yum install -y epel-release 
sudo yum clean all && yum makecache
sudo yum install -y httpd phpldapadmin 
sudo systemctl start httpd
sudo systemctl enable httpd
# 备份配置文件
#     cp /etc/httpd/conf.d/phpldapadmin.conf /etc/httpd/conf.d/phpldapadmin.conf.bak01
#     cp /etc/phpldapadmin/config.php /etc/phpldapadmin/config.php.bak01
# 修改配置文件
#     vim /etc/phpldapadmin/config.php ,找到 并修改如下两行
#         $servers->setValue('login','attr','dn');
#         // $servers->setValue('login','attr','uid');
#     vim /etc/httpd/conf.d/phpldapadmin.conf
#         <Directory /usr/share/phpldapadmin/htdocs>
#         <IfModule mod_authz_core.c>
#             Require all granted
#         </IfModule>
#         </Directory>
# sudo systemctl restart httpd
# 然后在浏览器上访问 http://192.168.122.9/phpldapadmin/ 


#samba
# sudo yum install -y samba-common samba samba-client
# cp /usr/share/doc/samba-3.6.9/LDAP/samba.schema /etc/openldap/schema/

# mkdir -p /var/lib/mdb


# echo "重启centos7"
# sudo reboot


#client
# yum install -y openldap-clients nss-pam-ldapd
# authconfig-tui


#解压tar.bz2
# yum install -y bzip2
# tar -jxvf x.tar.bz2 -C Path