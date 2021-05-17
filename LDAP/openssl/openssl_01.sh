#!/bin/bash

# echo "  - 记得提前安装好OpenSSL"
# rpm -qa | grep openssl


# 1-
echo "1 - 进入CA中心"
cd /etc/pki/CA
#没有更改前的目录结构
# [lwh@bogon CA]$ sudo  tree
# .
# ├── certs
# ├── crl
# ├── newcerts
# └── private

# 2-
echo " 1 - CA生成 自身私钥"
(sudo umask 077; sudo openssl genrsa -out private/cakey.pem 2048)
#为了保证CA机构私钥的安全，需要把私钥文件掩码为077

echo " 2 - CA签发 自身公钥/证书"
sudo openssl req -new -x509 -key private/cakey.pem -out cacert.pem  -days 365

# Country Name (2 letter code) [XX]:CN                          #输入国家的简称 两个字母
# State or Province Name (full name) []:BeiJing                 #省份的全拼
# Locality Name (eg, city) [Default City]:BeiJing               #市或地区的全拼
# Organization Name (eg, company) [Default Company Ltd]:WanLi   #公司名词
# Organizational Unit Name (eg, section) []:Linux               #部门名词
# Common Name (eg, your name or your server's hostname) []:ca.wanli.com #你的name或者服务器的域名/IP
# Email Address []:ca@wanli.com                                 #邮件地址

# CN
# BeiJing
# BeiJing
# WanLi
# Linux
# lwh 
# lwh@great.com

#更改后的目录结构
# [lwh@bogon CA]$ sudo  tree
# [lwh@bogon CA]$ sudo tree
# .
# ├── cacert.pem      #CA签发的 CA自身的证书文件(公钥)(可以根据需要定制)
# ├── certs           #存放 clients/客户端  证书/公钥 的目录
# ├── crl             #CA吊销的客户端证书 的 存放目录
# ├── newcerts        #生成新证书 的 存放目录
# └── private         #存放CA自身私钥的目录
#     └── cakey.pem
# index.txt   #存放客户端证书 的信息
# serial      #客户端证书    的编号(编号可以自定义)，用于识别客户端证书

# echo "  - 创建index.txt serial 用于存放 客户端证书的信息以及编号"
#这部分 推荐 直接在bash中输入执行，而不是 通过脚本运行
# touch index.txt  serial 
# echo "001" > serial

echo " 3 - 通过OpenSSL命令获取根证书信息"
sudo openssl x509 -noout -text -in /etc/pki/CA/cacert.pem

#至此，通过OpenSSL软件自建CA就完成了，后续就要接收客户端证书请求，
#验证所提供信息的合法性 并 秦法证书 以及后续证书的颁发，吊销证书等操作



cd /etc/pki/CA
(sudo umask 077; sudo openssl genrsa -out private/cakey.pem 2048)
sudo openssl req -new -x509 -key private/cakey.pem -out cacert.pem  -days 365
sudo touch index.txt  serial 
sudo echo "01" > serial
sudo openssl x509 -noout -text -in /etc/pki/CA/cacert.pem


(sudo umask 077; sudo openssl genrsa -out ldapkey.pem 1024)
sudo openssl req -new -x509 -key ldapkey.pem -out ldap.csr  -days 365
sudo openssl ca -in ldap.csr -out ldapcert.pem -days 365

