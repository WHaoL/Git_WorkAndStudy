#!/bin/bash
#----------------------------------客户端部署-------------------------------------------
scp root@192.168.122.133:/etc/openldap/ssl/cacert.pem /etc/openldap/certs

HOSTS=/etc/hosts
sudo grep slapd $HOSTS > /dev/null   ||   sudo echo "192.168.122.133 slapd" >> $HOSTS  # 插入

echo "----------------------nss-pam-ldapd-----------------------"

echo "安装nss-pam-ldapd"
sudo yum install -y nss-pam-ldapd

echo "下面的操作需要先root: 1. Use LDAP  2. Use LDAP 3. Next  4. Use TLS  5. ldaps://ldapserver的IP dc=testldap,dc=com 6. OK"
echo ""
sudo authconfig-tui


#把 /etc/nslcd.conf 中的ssl start_sl 改为 ssl on
sed -i '/^ssl/ssl on' /etc/nslcd.conf


systemctl restart slapd
systemctl restart nslcd


# echo "ldaps能正常查询"
ldapsearch -H ldap://slapd -D cn=admin,dc=testldap,dc=com -w admin "cn=config"
ldapsearch -H ldaps://slapd -D cn=admin,dc=testldap,dc=com -w admin "cn=config"


# find / -name slapd 
# ldd /usr/sbin/slapd

# ps -ef | grep ldap
# ps -ef | grep sladp

# yum install -y lsof
# lsof -i:389
# lsof -i:636