#!/bin/bash
set -e 
set -x


#root运行本文件

# echo "1 - install yum-utils"
# sudo yum install -y yum-utils
# echo "2 - 配置aliyun镜像"
# sudo yum-config-manager \
#     --add-repo \
#     http://mirrors.aliyun.com/repo/Centos-7.repo

#二、环境准备
# 1 - 
# 修改slapd server和client的 /etc/hosts，将slapd server的ip地址和主机名添加到该文件
#     127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
#     ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
#     192.168.122.234 slapd #新增的
HOSTS=/etc/hosts
sudo grep slapd $HOSTS > /dev/null   ||   sudo echo "192.168.122.234 slapd" >> $HOSTS  # 插入
# grep slapd $HOSTS >/dev/null    &&   sed -i '/slapd/d' $HOSTS               # 删除
#   
# 2 - 
#确保 server和client都已经安装了openssl
# sudo yum install -y openssl openssl-devel


echo "1 - CA中心 生成自身私钥 -->> cakey.pem"
cd /etc/pki/CA/
(umask 077; openssl genrsa -out private/cakey.pem 2048)
# 为保证CA私钥的安全，需要把私钥文件权限设置为077
# 带上”-des3”参数时，创建的私钥采取Triple DES算法加密，命令执行后会要求输入密码，
#   这样后续在调用此密钥时都会要求输入密码，如 “openssl genrsa -des3 -out cakey.pem 2048”，这里为了方便省略此参数
# 目录及文件说明：
#     certs       客户证书存放目录
#     crl         CA吊销的客户端证书存放目录
#     newcerts    生成新证书存放目录
#     private     存放CA自身私钥的目录
#     index.txt   存放客户端证书信息
#     serial      客户端证书编号（编号可以自定义），用于识别客户端证书

echo "2 - CA中心 签发自身公钥"
openssl  req -new -x509 -key private/cakey.pem -out cacert.pem -days 365
#   CN
#   BeiJing
#   BeiJing
#   greatdb
#   Linux
#   slapd
#   123@qq.com
#   123456
#   greatdb
# 注意：生成证书时，需要注意的是”Common Name”请填写服务器域名或IP。

echo "3.1 - slapd server生成私钥"
mkdir -p /etc/openldap/ssl
cd /etc/openldap/ssl
(sudo umask 077; sudo openssl genrsa -out slapdkey.pem 1024)

echo "3.2 - 创建index.txt和serial文件"
touch /etc/pki/CA/index.txt /etc/pki/CA/serial # index.txt文件用于存放客户端证书信息
echo "01" > /etc/pki/CA/serial                 # serial文件用于存放客户端证书编号，可以自定义,用于识别客户端证书
cd /etc/openldap/ssl

echo "3.3 - slapd server向 CA 申请证书签署请求 (这是一个请求文件，后面用于向CA申请 来生成一个证书)"
openssl req -new -key slapdkey.pem -out slapd.csr -days 3650
# 注意：相关信息必须和CA所填证书(完全)一致才可以正常签发，客户端访问需要使用Common Name，否则可能出现认证失败的问题。
#      所以建议将Common Name处设置为slapd 服务器域名或IP，并配置到客户端的/etc/hosts 文件中。

echo "3.4 - CA检测用户请求(通过后生成证书)"
#注意: CA和 user可以不在一台机器上, 把slapd.csr发送给CA所在的服务器,这样CA就可以为它签署证书
openssl ca -in slapd.csr -out slapdcert.pem -days 3650

#-----------------------------------------------------------------------------
echo "4 - 部署 slapd 服务端"
# echo "部署slapd服务端： 包含了 CA中心的根证书(CA自身的公钥)，CA签署过的slapd server的证书 slapd server的私钥 配置到cn=config中"
cp /etc/pki/CA/cacert.pem /etc/openldap/ssl/
sudo chown -R ldap:ldap /etc/openldap/ssl/*
# sudo chown -R ldap:ldap /etc/openldap/certs/cacert.pem 
# sudo chown -R ldap:ldap /etc/openldap/certs/slapdcert.pem 
# sudo chmod -R 0400 /etc/openldap/ssl/*

#-----------------------------------------------------------------------------
# !!!!!!!!!
#配置使用636进行通信 vim /etc/sysconfig/slapd
    # 把   SLAPD_URLS="ldapi:/// ldap:///"
    # 改为 SLAPD_URLS="ldaps:/// ldapi:/// ldap:///"
    #SLADP_LDAPS=yes 加不加 似乎没有影响
slapdurls636=/etc/sysconfig/slapd
sed -i 's/SLAPD_URLS=\"ldapi:\/\/\/ ldap:\/\/\/\"/SLAPD_URLS=\"ldaps:\/\/\/ ldapi:\/\/\/ ldap:\/\/\/\"/g' $slapdurls636
# 若是不配置这一项,636就无法启动 
# 不配置这一项, 最后slapd 服务端执行查询操作的时候,如下: 
    # [root@localhost openldap]# ldapsearch -H ldaps://slapd -D cn=admin,dc=testldap,dc=com -w admin "cn=config"
    # ldap_sasl_bind(SIMPLE): Can't contact LDAP server (-1)

#-----------------------------------------------------------------------------
cat << EOF > add_tls.ldif
dn: cn=config
changetype: modify
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/openldap/ssl/cacert.pem

dn: cn=config
changetype: modify
add: olcTLSCertificateFile
olcTLSCertificateFile: /etc/openldap/ssl/slapdcert.pem

dn: cn=config
changetype: modify
add: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/ssl/slapdkey.pem
EOF

slapdldif=/etc/openldap/slapd.d/cn\=config.ldif
grep olcTLSCACertificateFile $slapdldif >/dev/null && sed -i '/olcTLSCACertificateFile/d' $slapdldif
grep olcTLSCertificateFile $slapdldif >/dev/null && sed -i '/olcTLSCertificateFile/d' $slapdldif
grep olcTLSCertificateKeyFile $slapdldif >/dev/null && sed -i '/olcTLSCertificateKeyFile/d' $slapdldif
systemctl restart slapd
ldapmodify -Y EXTERNAL -H ldapi:// -f ./add_tls.ldif
#第一次执行的时候，问题如下
    # [root@localhost ssl]# ldapmodify -Y EXTERNAL -H ldapi:// -f ./add_tls.ldif
    # SASL/EXTERNAL authentication started
    # SASL username: gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth
    # SASL SSF: 0
    # modifying entry "cn=config"
    # ldap_modify: Inappropriate matching (18)
    #         additional info: modify/add: olcTLSCACertificateFile: no equality matching rule
#解决：
    # 把   /etc/openldap/slapd.d/cn\=config.ldif 文件中 对应的项删除调
    # 然后 systemctl restart slapd 
    # 然后 ldapmodify -Y EXTERNAL -H ldapi:// -f ./add_tls.ldif 

    # rpm -qa|grep openldap
    # rpm -q --scripts openldap-servers-2.4.44-23.el7_9.x86_64
    # rpm -q --scripts openldap-servers-2.4.44-23.el7_9.x86_64|less
    # cat  /usr/share/openldap-servers/slapd.ldif | grep -v ^# 
#因为openldap安装时，根据/usr/share/openldap-servers/slapd.ldif创建了默认配置

systemctl restart slapd
netstat -ntlp|grep 636
