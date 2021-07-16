参考： https://blog.51cto.com/407711169/1439944


#! /bin/sh
set -e
set -x

# 参考步骤：
#     官方2.4源码包的：  /openldap-2_4/openldap-OPENLDAP_REL_ENG_2_4/tests/data/regressions/its8444/slapd-provider1.ldif
#         
#         "双主"部分    https://blog.csdn.net/rockstics/article/details/108239475 
#    

#-------------------------------------------------------------------------分别在两个Mirror节点上，输入指令 一步步执行
# 注意：
#       运行之前 更改 IP
#
cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG
chown ldap. /var/lib/ldap/DB_CONFIG
#设置suffix rootdn rootpw 加载schema
cd ../../
./01-changeroot.sh
ldapadd -x -D cn=admin,dc=testldap,dc=com -w admin -f  03-basedn.ldif 
cd -

#change server ID
#注意，分别在两个节点上运行 各自的更改
#Mirror-01
ldapmodify -Y EXTERNAL -H ldapi:/// -f 1-1ChangeServerID.ldif
#Mirror-02
ldapmodify -Y EXTERNAL -H ldapi:/// -f 1-2ChangeServerID.ldif

#加载同步模块
ldapadd -Y EXTERNAL -H ldapi:/// -f 2-syncprov_module.ldif

#overlay syncprov  ， checkpoint， sessionlog
ldapadd -Y EXTERNAL -H ldapi:/// -f 3-syncprov_overlay.ldif

#设置syncrepl
#Mirror-01
ldapmodify -Y EXTERNAL -H ldapi:/// -f 4-1MirrorMode.ldif
#Mirror-02
ldapmodify -Y EXTERNAL -H ldapi:/// -f 4-2MirrorMode.ldif

#-------------------------------------------------------------------------在Master上执行更改，在Slave上查询

#Mirror-01 添加 部门和user
ldapmodify -a -x -D cn=admin,dc=testldap,dc=com -w admin -f ../04-add_group_users.ldif
#Mirror-02查询自己 是否同步
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b dc=testldap,dc=com
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b cn=fang.huang,ou=HR,ou=People,dc=testldap,dc=com -LLL

# Mirror-02更改
ldapmodify -x -D "cn=admin,dc=testldap,dc=com" -w admin -f 5-1-modify.ldif
ldapmodify -x -D "cn=admin,dc=testldap,dc=com" -w admin -f 5-2-modify.ldif
#Mirror-01查询自己 是否同步
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b dc=testldap,dc=com
ldapsearch -H ldapi:/// -D cn=admin,dc=testldap,dc=com -w admin -b cn=fang.huang,ou=HR,ou=People,dc=testldap,dc=com -LLL





# lsof -i:389
# ps -ef | grep ldap | grep -v grep