#!/bin/bash
SYSLOG_CONF=/etc/rsyslog.conf
set -x
#如果已经配置了slapd的日志 就直接跳过(短路特性)，如果没有配置那么，配置slapd的日志目录
grep slapd $SYSLOG_CONF >/dev/null || echo "local4.*    -/var/log/slapd.log" >> $SYSLOG_CONF

systemctl restart rsyslog
systemctl is-active slapd >/dev/null && systemctl restart slapd


#关于 syslog 日志界别的选择，参考：
#   5.2.1.2. olcLogLevel: <level> 或者 6.2.1.5. loglevel <level>
#   7.1 命令行参数  -l <syslog-local-user>
#   21.3. Logging
#   推荐
#       olcLogLevel: 256

#关于 debug 的level 参考：
#   7.1 命令行参数-d <level>
#   21.3. Logging
#       要debug slapd.conf中定义的access rules，请添加日志级别"ACL"  128 (0x80 ACL)
#
#   例如：
#       slapd -d -1  #通常可以跟踪相当简单的问题，例如丢失的schema以及 slapd用户的证书权限不正确的文件权限

#虽然二者的level是同一张表，
#   但是syslog推荐 256
#   -d 的根据实际情况，在命令行中指定
#     如：slapadd -l <inputfile> -f <slapdconfigfile> [-d <debuglevel>] [-n <integer>|-b <suffix>]



#验证
#   cat /etc/rsyslog.conf | grep slapd

#   cat /dev/null > /var/log/slapd.log 
#   cat /var/log/slapd.log 