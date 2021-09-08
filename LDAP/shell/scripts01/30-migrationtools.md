参考： 
    https://www.cnblogs.com/kevingrace/p/9052669.html
    https://blog.csdn.net/dockj/article/details/84671890 
    https://www.cnblogs.com/lemon-le/p/6206822.html
    
```bash


yum install migrationtools

vim /usr/share/migrationtools/migrate_common.ph
	# Default DNS domain
	$DEFAULT_MAIL_DOMAIN = "123456@qq.com";

	# Default base 
	$DEFAULT_BASE = "ou=linux,dc=testldap,dc=com";



cat >> export.sh << EOF 
 cat /etc/passwd > passwd
 cat /etc/group  > group
 /usr/share/migrationtools/migrate_base.pl          > base.ldif
 /usr/share/migrationtools/migrate_group.pl group   > group.ldif
 /usr/share/migrationtools/migrate_passwd.pl passwd > passwd.ldif
 cat /etc/passwd | grep lwh > passwd
 cat /etc/group  | grep lwh > group
 /usr/share/migrationtools/migrate_base.pl > base.ldif
EOF


bash export.sh

shell/srcips
	01 + 03 

ldapadd -x -D "cn=admin,dc=testldap,dc=com" -w admin -f base.ldif 
ldapadd -x -D "cn=admin,dc=testldap,dc=com" -w admin -f passwd.ldif 
ldapadd -x -D "cn=admin,dc=testldap,dc=com" -w admin -f group.ldif 

ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/nis.ldif


ldapdelete -x -D cn=admin,dc=testldap,dc=com -w admin "ou=Services,ou=linux,dc=testldap,dc=com"
ldapdelete -x -D cn=admin,dc=testldap,dc=com -w admin "ou=Rpc,ou=linux,dc=testldap,dc=com"
ldapdelete -x -D cn=admin,dc=testldap,dc=com -w admin "ou=Hosts,ou=linux,dc=testldap,dc=com"
ldapdelete -x -D cn=admin,dc=testldap,dc=com -w admin "ou=linux,dc=testldap,dc=com"


```