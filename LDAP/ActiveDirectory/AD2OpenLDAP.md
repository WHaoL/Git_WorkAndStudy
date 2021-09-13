
***

*** 

    《Active Directory 内幕》http://www.kouti.com/index.htm 
    Reference Tables on Active Directory (1st Edition, AD2000)  http://www.kouti.com/tables.htm 
        
*** 

```bash
dn: dc=users
userlogin: USERNAME
userPassword: PASSWORD
objectclass: person
userPrincipalName: USERNAME@domain.com
sAMAccountName: USERNAME

```

***

# ldifde 导入导出 AD的数据
参考： https://bbs.csdn.net/topics/40090446 
 http://kms.lenovots.com/kb/article.php?id=8141 

```bash

ldifde -f testAD.ldif
    
    # LDIFDE 不支持导出密码
    # 因此在将用户导入到目录中时，会禁用帐户并将密码设置为空。
    # 这样做是出于安全原因。此外，帐户选项“用户下次登录时须更改密码”处于选中状态。
    #可以针对目录林中的每个域运行上面的 LDIFDE 导出命令

    -f #指定文件名
        ldifde -i -f fileName.LDF # 导入
        ldifde -f fileName.LDF    # 导出
    -i
        # 打开import模式
        # 不指定-i ，默认是export模式
    -c str1 str2
        # 将str1替换为str2
    -d RootDN
        # 导出时指定 根 
    -r filer
        # 导出时指定 查找的过滤器
    -l LDAP-attribute-list 
        # 逗号分隔
        # 指定-返回的属性列表。如果该参数被省略，则返回所有属性。
        # 例如，如果只返回对象的可分辨名称、公用名、名字、姓氏和电话号码，则要指定以下属性列表：
        # -l "distinguishedName, cn, givenName, sn, telephone"
    -o list
        # 逗号分隔 
        # 将 某些属性 从导出查询结果中 去掉。
        # 通常在以下情况下使用：即将对象从 Active Directory 中导出并随后将其导入另一 LDAP 兼容目录。
        # 可能存在一些其他目录不支持的属性，因此这些属性可从使用该选项的结果集中去掉。
        # 例如，要去掉 objectGUID、whenChanged 和 whenCreated 属性，则应指定以下选项：
        # -o "whenCreated, whenChanged, objectGUID"
    -m 
        # 去掉仅适用于 Active Directory 对象的属性，
        # 如 ObjectGUID、objectSID、pwdLastSet 和 samAccountType 属性。
```

***
***

参考： https://www.it1352.com/1706432.html 
```bash
需求： 
    我有一个应用程序，是使用Active Directory来验证用户的身份；现在我想用OpenLDAP替换AD。

问题：
    应该使用的 attribute 和 object class ？
    如何访问 域控制器/domain controll ？
    组/group 的类型和 范围 ，它们似乎是二进制 而不是字符串 ？

方向：
    添加microsoft.schema到openldap（但是：Active Directory的schema不是标准的）

方向：
    我们只能添加我们需要的attribute和object class；
    修改LDAP的schema，将AD的attribute和object class映射到LDAP的attribute和object class。


```
添加一些attribute和object class
```schema
attributetype ( 1.2.840.113556.1.4.750 NAME 'groupType' 
   SYNTAX '1.3.6.1.4.1.1466.115.121.1.27' SINGLE-VALUE )

attributetype ( 1.3.114.7.4.2.0.33 NAME 'memberOf' 
    SYNTAX '1.3.6.1.4.1.1466.115.121.1.26' )

objectclass ( 1.2.840.113556.1.5.9 NAME 'user'
        DESC 'a user'
        SUP organizationalPerson STRUCTURAL
        MUST ( cn )
        MAY ( userPassword $ memberOf ) )

objectclass ( 1.2.840.113556.1.5.8 NAME 'group'
        DESC 'a group of users'
        SUP top STRUCTURAL
        MUST ( groupType $ cn )
        MAY ( member ) )
```
然后创建LDIF文件，用于插入user和group
```ldif
dn: dc=myCompany
objectClass: top
objectClass: dcObject
objectClass: organization
dc: myCompany
o: LocalBranch

dn: ou=People,dc=myCompany
objectClass: top
objectClass: organizationalUnit
ou: People
description: Test database

dn: cn=Users,dc=myCompany
objectClass: groupOfNames
objectClass: top
cn: Users
member: cn=Manager,cn=Users,dc=myCompany

dn: cn=Manager,cn=Users,dc=myCompany
objectClass: person
objectClass: top
cn: Manager
sn: Manager
userPassword:: e1NIQX1tc0lKSXJCVU1XdmlPRUtsdktmV255bjJuWGM9

dn: cn=ReadWrite,ou=People,dc=myCompany
objectClass: group
objectClass: top
cn: ReadWrite
groupType: 2147483650
member: cn=sysconf,ou=People,dc=myCompany

dn: cn=sysopr,ou=People,dc=myCompany
objectClass: user
objectClass: organizationalPerson
objectClass: person
objectClass: top
cn: sysopr
sn: team
memberOf: cn=ReadOnly,ou=People,dc=myCompany
userPassword:: e1NIQX1jUkR0cE5DZUJpcWw1S09Rc0tWeXJBMHNBaUE9
```

***
***


