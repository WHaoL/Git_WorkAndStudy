# 1. Active Directory-官方手册

 https://docs.microsoft.com/zh-cn/troubleshoot/windo：ws-server/identity/active-directory-overview 



## 1. Active Directory 备份、还原或灾难恢复


- Active Directory 证书服务
- Active Directory 数据库问题和域控制器启动失败
- Active Directory 域或林功能级别更新
- Active Directory 联合身份验证服务 (AD FS)
- Active Directory FSMO
- Active Directory 轻型目录服务 (AD LDS) 和 Active Directory 应用程序模式 (ADAM)
- Active Directory 迁移工具 (ADMT)
- Active Directory 复制
- Active Directory 拓扑 (站点、子网和连接对象)
- DCPromo 和域控制器安装
- 域控制器可伸缩性或性能 (LDAP)
- 域加入问题
- LDAP 配置和互操作性
- 架构更新 - 已知问题、最佳做法、工作流审阅
- 架构更新失败或冲突
- 传输层安全性 (TLS)
- 用户、计算机、组和对象管理
- 虚拟化域控制器 (错误和问题)
- Windows时间服务







# 2. Win10-AD的安装与使用

参考-百度：https://jingyan.baidu.com/article/0bc808fc351e9c1bd485b9de.html
- 搜索：控制面板 
- 点击：程序
    - 点击：启用或关闭Windows功能
    - 勾选：Active Directory ， 点击：确定
- 搜索 Active ,点击安装向导，进行AD的安装

```bash
AD LDS服务显示名称--实例名(I) instance1
AD LDS服务名称：ADAM_instance1
描述：AD LDS实例


LDAP端口号(L): 389
SSL端口号(S):  636

数据文件(D): C:\Program Files\Microsoft ADAM\instance1\data
数据回复文件(A): C:\Program Files\Microsoft ADAM\instance1\data

lwh
123



```bash

# WinDataSer01 AD1   AD1.adds.com
《Windows Server 2016中部署AD》： https://blog.51cto.com/lumay0526/2046844  
```bash

192.168.122.133
255.255.255.0
192.168.122.1


WindowsDataSenterDesktop2022

administrator 
WHaoL0603 

域名：adds.com 
DSRM密码：WHaoL0603

NetBIOS域名：ADDS
```
《Windows Server 2016 AD中新建组织单位、组、用户》： https://blog.51cto.com/lumay0526/2046851  
```bash
新建组织单位
    组织单位-名称：ClientUser

新建组
    组织单位-名称：Group
        组-名称：ServerUser

新建用户
    liangwenhao
    lwh@adds.com WHaoL0603

```

**** 

Windows Server 笔记（六）：Active Directory域服务：组织单位
新建组织单位，委派给某个人
：https://blog.51cto.com/yupeizhi/1552619 

*** 


*** 
Windows Server 2016中添加AD域控制器 https://blog.51cto.com/lumay0526/2051317
# WinDataSer02 
```bash
192.168.122.134
255.255.255.0
192.168.122.1
DNS指向AD1 192.168.122.133

administrator 
WHaoL0603

```
*** 

添加人员 ： https://blog.csdn.net/a137748099/article/details/115017435 
```bash
组织单位：研发部
    用户：zhangsan 
````

# AD导出位LDIF
```bash
ldifde -f testAD.ldif

    -f #指定文件名
        ldifde -i -f fileName.LDF # 导入
        ldifde -f fileName.LDF    # 导出
    

```