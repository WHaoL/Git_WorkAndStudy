#!/bin/bash
SYSLOG_CONF=/etc/rsyslog.conf
set -x
#如果已经配置了slapd的日志 就直接跳过(短路特性)，如果没有配置那么，配置slapd的日志目录
grep slapd $SYSLOG_CONF >/dev/null || echo "local4.*    /var/log/slapd.log" >> $SYSLOG_CONF

systemctl restart rsyslog
systemctl is-active slapd >/dev/null && systemctl restart slapd


#验证
cat /etc/rsyslog.conf | grep slapd
# cat /var/log/slapd.log


cat /dev/null > /var/log/slapd.log 
cat /var/log/slapd.log 