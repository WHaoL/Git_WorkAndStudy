#!/bin/bash

#-----------------------------------------------------------------------------
# 设置 /etc/openldap/ldap.conf
#     添加 TLS_REQCERT allow
#     设置 TLS_CACERTDIR /etc/openldap/ssl
# grep "TLS_REQCERT"  /etc/openldap/ldap.conf
# if [ $? -eq 0 ] ; then
#     sed -i '/^TLS_REQCERT/cTLS_REQCERT allow' /etc/openldap/ldap.conf
# else
#     echo "TLS_REQCERT allow" >>  /etc/openldap/ldap.conf
# fi
echo "TLS_REQCERT allow" >>  /etc/openldap/ldap.conf

grep "TLS_CACERTDIR"  /etc/openldap/ldap.conf 
if [ $? -eq 0 ] ;then
    sed -i '/^TLS_CACERTDIR/cTLS_CACERTDIR \/etc\/openldap\/ssl' /etc/openldap/ldap.conf
else
    echo "TLS_CACERTDIR /etc/openldap/ssl" >>  /etc/openldap/ldap.conf
fi

systemctl restart slapd

#-----------------------------------------------------------------------------

# 测试slapd 服务端证书合法性
# 输出 OK
openssl  verify -CAfile /etc/pki/CA/cacert.pem  /etc/openldap/ssl/slapdcert.pem
echo "slapd 服务端的TLS配置完毕!!!"

openssl s_client -connect localhost:636 -showcerts -state -CAfile /etc/openldap/ssl/cacert.pem 
# openssl s_client -connect localhost:636 -showcerts -state -CAfile /etc/openldap/ssl/slapdcert.pem 

# cp /etc/openldap/ssl/cacert.pem /etc/openldap/certs
# cp /etc/openldap/ssl/slapdcert.pem /etc/openldap/certs
# cp /etc/openldap/ssl/slapdkey.pem /etc/openldap/certs



ldapsearch -H ldap://slapd -D cn=admin,dc=testldap,dc=com -w admin "cn=config"
ldapsearch -H ldaps://slapd -D cn=admin,dc=testldap,dc=com -w admin "cn=config"