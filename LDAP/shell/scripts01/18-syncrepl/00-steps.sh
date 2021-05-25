#! /bin/sh
set -e
set -x

# 参考步骤：
#     官方2.4源码包的：  /openldap-2_4/openldap-OPENLDAP_REL_ENG_2_4/tests/data/regressions/its8521/its8521
#         
#         https://blog.csdn.net/weixin_43423965/article/details/105215245
#         https://blog.csdn.net/weixin_43423965/article/details/105215519

# 带数字的  xxx.ldif 才是实际要执行的文件


#-------------------------------------------------------------------------此为Master的步骤，输入CMD 一步步执行
# master
# cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
# chown ldap. /var/lib/ldap/DB_CONFIG
cd ../../
./01-changeroot.sh
ldapadd -x -D cn=admin,dc=testldap,dc=com -w admin -f  03-basedn.ldif 
cd -
#此user专门负责replicat
ldapadd -x -D "cn=admin,dc=testldap,dc=com" -w admin -f 1-replicator.ldif
#挂载syncprov
ldapadd -Y EXTERNAL -H ldapi:/// -f 2-syncprov_module.ldif
#overlay syncprov  ， checkpoint， sessionlog
ldapadd -Y EXTERNAL -H ldapi:/// -f 3-syncprov_overlay.ldif
#设置replocator的访问权限
ldapmodify -Y EXTERNAL -H ldapi:/// -f 4-olchdb.ldif
#-------------------------------------------------------------------------此为Slave的步骤，输入CMD 一步步执行
# slave
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG 
systemctl start slapd
#设置suffix rootdn rootpw 加载schema
cd ../../
source 01-changeroot.sh
cd -
#设置syncrepl
ldapmodify -Y EXTERNAL -H ldapi:/// -f 21-syncrepl.ldif
#-------------------------------------------------------------------------在Master上执行更改，在Slave上查询
# 更改provider
ldapmodify -x -D "cn=admin,dc=testldap,dc=com" -w admin -f 5-1-modify.ldif
ldapmodify -x -D "cn=admin,dc=testldap,dc=com" -w admin -f 5-2-modify.ldif
#Slave查询自己 是否同步
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b dc=testldap,dc=com
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b cn=fang.huang,ou=HR,ou=People,dc=testldap,dc=com -LLL







