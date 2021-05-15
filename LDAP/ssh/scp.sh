#!/bin/bash

#1 - 先拷install脚本到centos7
sudo scp -r  install-ldap.sh root@192.168.122.171:/home/lwh
sudo scp -r  install-ldap.sh root@192.168.122.83:/home/lwh

#2 - 连接到 每个centos7

#3 - 然后在虚拟机里运行 ./home/lwh/instll-ldap.sh

#依次运行三个脚本



