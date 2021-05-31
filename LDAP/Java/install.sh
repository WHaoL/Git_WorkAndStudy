#!/bin/bash

#-----------------------------------------------------------------------------------------
# 一步步配置即可 
uname -a #我的Linux版本是ubuntu20.04.1
export MAVEN_OPTS="-Xmx512m"

sudo apt update
sudo apt install maven 
sudo apt install openjdk-11-jdk

vim /etc/profile.d/jdk_maven.sh

# this is environment for java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
export CLASSPATH=.:${JAVA_HOME}/lib
export PATH=${JAVA_HOME}/bin:${PATH}
# set maven environment
# export MAVEN_HOME=/usr/share/maven
# export PATH=${MAVEN_HOME}/bin:${PATH}
export PATH=/usr/share/maven/bin:$PATH

source /etc/profile.d/jdk_maven.sh

mvn -v
java -version
javac -version

# maven本地仓库初始化，在用户家目录下会生成一个.m2的文件夹
sudo mvn help:system
# 拷贝setting.xml到.m2文件夹下
cd ~/.m2
# cp ${MAVEN_HOME}/conf/settings.xml .
cp /usr/share/maven/conf/settings.xml .
# 修改settings.xml文件，配置阿里源
sudo vim settings.xml
<mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>
</mirror>
# 测试
mvn -v

# 安装配置到此结束(使用开源软件的足够了，如果使用oracleJdk，看下面的配置步骤)


    mvn -f pom-first.xml clean install && ./build.sh

# 二进制文件可执行安装包 的目录
/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/ 

# 二进制文件可执行安装包 的解压包目录
/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/org.apache.directory.studio.product/


/home/gos/workspace/JAVA/v20210213-M16-prepare-github/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/org.apache.directory.studio.product/linux/gtk/x86_64/ApacheDirectoryStudio/


#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------


#-------------------------------01-Ubuntu20.04安装 jdk-----------------
#注意，要安装oracle的java-jdk  不要安装openjava-jdk

# 1 - 首先卸载openjdk
#查看安装了 哪些和jdk相关的包ep openjdk     
root@gos-Latitude-5591:/home/gos# dpkg -l | grep "openjdk*" 
ii  openjdk-11-jre:amd64                       11.0.11+9-0ubuntu2~20.04              amd64        OpenJDK Java runtime, using Hotspot JIT
ii  openjdk-11-jre-headless:amd64              11.0.11+9-0ubuntu2~20.04              amd64        OpenJDK Java runtime, using Hotspot JIT (headless)
root@gos-Latitude-5591:/home/gos# 
#卸载openjdk
sudo remove -y openjdk*
#可使用 --purge 来把这些配置文件一并删除
# 使用 dpkg -l | grep openjdk 查看还有哪些 java安装包的配置没有卸载/删除
dpkg --purge openjdk-11-jre-headless:amd64
#注销一下ubuntu 然后 重新登陆 ubuntu ，此时就缓存中和java相关的配置/设置都已经被彻底清除了
# 此时运行下面两条命令
      java
      javac
# 都提示找不到，证明完全卸载 并 清除干净了

# 2 - 安装oracleJava 
#oracle官网下载 tar.gz 但是需要登陆
https://www.oracle.com/java/technologies/javase-jdk11-downloads.html
#所以我们在 去网络上直搜索下
https://www.jianshu.com/p/89744f54a2e5 

sudo tar -zxvf jdk-11.0.8_linux-x64_bin.tar.gz 
sudo mv jdk-11.0.8/ /usr/local/
cd /usr/local/jdk-11.0.8/

# .bashrc是bash每次启动时 都要去访问的配置文件

vim /etc/profile.d/jdk_maven.sh
# this is environment for java
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

# export JAVA_HOME=/usr/local/jdk-11.0.8/

export CLASSPATH=.:${JAVA_HOME}/lib
export PATH=${JAVA_HOME}/bin:${PATH}
source /etc/profile.d/jdk_maven.sh

# 此时测试正常
      java -version
      javac -version
#把上面的配置放在 /etc/profile.d/目录下是最好的 - 因为每个bash都会加载



#------------------------------Ubuntu20.04安装 maven并配置阿里源-----------------

# https://www.cnblogs.com/wqlken/p/14090525.html

sudo apt update
sudo apt install maven #安装maven,默认安装路径为/usr/share/maven

# 添加maven环境配置,在/etc/profile.d文件夹下新建配置文件jdk_maven.sh
vim /etc/profile.d/jdk_maven.sh

export MAVEN_HOME=/usr/share/maven
export PATH=${MAVEN_HOME}/bin:${PATH}


#加载环境配置
source /etc/profile.d/maven.sh
#查看mvn版本
mvn --version

# maven本地仓库初始化，在用户家目录下会生成一个.m2的文件夹
sudo mvn help:system

# 拷贝setting.xml到.m2文件夹下
cd ~/.m2
# cp ${MAVEN_HOME}/conf/settings.xml .
cp /usr/share/maven/conf/settings.xml .

# 修改settings.xml文件，配置阿里源
sudo vim settings.xml

<mirror>
      <id>alimaven</id>
      <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
      <mirrorOf>central</mirrorOf>
</mirror>

# 测试
mvn -v



#-------------------------------配置 jdk和maven的环境 (完整版)
vim /etc/profile.d/jdk_maven.sh

# this is environment for java
export JAVA_HOME=/usr/local/jdk-11.0.8/
export CLASSPATH=.:${JAVA_HOME}/lib
export PATH=${JAVA_HOME}/bin:${PATH}
# set maven environment
export PATH=/usr/share/maven/bin:$PATH

source /etc/profile.d/jdk_maven.sh

#-------------------------------测试
mvn -v 
java -version
javac -version


#-------------------------------

# 二进制文件可执行安装包 的目录
/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/ 

# 二进制文件可执行安装包 的解压包目录
/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/org.apache.directory.studio.product/


/home/gos/workspace/JAVA/v20210213-M16-prepare-github/directory-studio-2.0.0.v20210213-M16-prepare/product/target/products/org.apache.directory.studio.product/linux/gtk/x86_64/ApacheDirectoryStudio/




# #-------------------------------02-Ubuntu20.04安装 maven-----------------
# # mavent
# https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/
# # 注意： 要下载 binaries/  下的 tar.gz

# cd /usr/local/
# sudo wget  https://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
# sudo tar -zxvf apache-maven-3.6.3-bin.tar.gz