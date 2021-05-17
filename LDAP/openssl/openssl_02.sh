#!/bin/bash

echo "0 - 切换目录: 创建 并 进入CA中"
# mkdir -p /home/lwh/ldapCA/
# cd /home/lwh/ldapCA/
cd /etc/pki/CA/
# mkdir -p certs crl newcerts private

echo " 1 - OpenLDAP服务端 生成私钥"
(sudo umask 077; sudo openssl genrsa -out ldapkey.pem 2048)
#为了保证CA机构私钥的安全，需要把私钥文件掩码为077

echo " 2 - OpenLDAP服务端 向CA申请证书"
sudo openssl req -new -x509 -key ldapkey.pem -out ldap.csr  -days 3650
#注意：
#    除了 CommonName EmailAddress以外，
#    以上所有值必须和CA证书所填信息保持一致，否则无法得到验证


echo " 3 - CA核实并签发证书"
# sudo openssl ca -in ldap.csr -out ldapkey.pem -days 3650
sudo openssl ca -in ldap.csr -out ldapcert.pem -days 3650
#注：
#   如果CA是独立的服务器，则需要将用户的 申请证书请求 通过ssh传至CA服务端中，
#   当CA服务端完成签发后，通过SSH将用户证书文件传送给客户端即可。
#   生产环境中部署时，不建议将OpenLDAP和CA部署在一起，推荐采用独立的服务器作为CA

