#!/bin/bash
set -e
set -x
# set -x会在执行每一行 shell 脚本时，把执行的内容输出来。它可以让你看到当前执行的情况，里面涉及的变量也会被替换成实际的值。
# set -e会在执行出错时结束程序，就像其他语言中的“抛出异常”一样。（准确说，不是所有出错的时候都会结束程序，见下面的注）
# 这两个组合在一起用，可以在 debug 的时候替你节省许多时间。出于防御性编程的考虑，有必要在写第一行具体的代码之前就插入它们。

admin_pass=`/usr/sbin/slappasswd -s admin`
echo "admin pass is:  ${admin_pass}"
sed "s!<pass>!${admin_pass}!g"   01-rootdn.ldif > 01-tmp.ldif

echo "备份默认配置"
cp /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif \
   /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif.bak01

echo "将要修改的内容："
cat 01-tmp.ldif

ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f 01-tmp.ldif

echo "修改后的变化"
diff -Nur \
        /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif \
        /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif.back01