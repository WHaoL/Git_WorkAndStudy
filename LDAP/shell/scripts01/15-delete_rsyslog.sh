#!/bin/bash 
SYSLOG_CONF=/etc/rsyslog.conf
set -x
#已经配置了slapd的日志了，才执行后面的操作(删除slapd的日志配置)
grep slapd $SYSLOG_CONF >/dev/null && sed -i '/slapd/d' $SYSLOG_CONF

systemctl restart rsyslog
systemctl is-active slapd >/dev/null && systemctl restart slapd


#验证
cat /etc/rsyslog.conf | grep slapd
# cat /var/log/slapd.log