
***

Active Directory的schema不是标准的，
需要修改LDAP的schema，将AD的attribute和object class映射到LDAP的attribute和object class。

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




