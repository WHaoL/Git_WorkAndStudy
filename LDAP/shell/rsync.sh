#!/bin/bash

#--------------------------------------------------------------    
#配置centos的备份, 方便以后快速回到当前状态
# sudo scp -r  install-ldap.sh root@192.168.122.171:/home/lwh
# root身份运行  ./install-ldap.sh
#--------------------------------------------------------------    


#--------------------------------------------------------------    
#1 - ./scp.sh                  #拷贝 ldif文件到虚拟机里
#2 - ./conn-ldap.sh            #连接到每个虚拟机
#3 - ./XXX.sh          #然后在虚拟机里运行 slapdmodify 添加配置
#------------------------------

sudo rsync -a /home/gos/workspace/Git_WorkAndStudy/LDAP/shell/*  root@192.168.122.234:/home/lwh/
# sudo rsync -a /home/gos/workspace/Git_WorkAndStudy/LDAP/shell/*  root@192.168.122.235:/home/lwh
# sudo rsync -a /home/gos/workspace/Git_WorkAndStudy/LDAP/shell/*  root@192.168.122.151:/home/lwh

#--------------------------------------------------------------


# 234 url01
# 230 url02
# vim /etc/hosts
# 192.168.122.9    url01
# 192.168.122.238    url02