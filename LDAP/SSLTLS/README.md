

***

# Openssl + SM2

Openssl: https://www.openssl.org/ 

完整流程：https://www.cnblogs.com/toolsMan/p/14045404.html 
参数解释：https://blog.csdn.net/as3luyuan123/article/details/14406429  
流程概述：https://blog.csdn.net/dong_beijing/article/details/81365060  
```bash
# 查看该版本的openssl 是否支持SM2参数
$ openssl ecparam -list_curves | grep SM2
  SM2       : SM2 curve over a 256 bit prime field

# 利用openssl自带的命令生成SM2公私钥对
# 1.创建EC参数和原始私钥文件：
openssl ecparam -out ec_param.pem -name SM2 -param_enc explicit --genkey
# 查看一下EC私钥信息:
openssl ecparam -in ec_param.pem -text
# 验证一下参数：
openssl ecparam -in ec_param.pem -check
# 2.把原始的私钥文件，转换为pkcs8格式：
# priv_key_pkcs8.pem是私钥
openssl pkcs8 -topk8 -inform PEM -in ec_param.pem  -outform  PEM -out priv_key_pkcs8.pem
# 3.使用原始的私钥文件，生成对应的公钥文件：
openssl ec -in ec_param.pem -pubout -out pub_key.pem 

```
***

SSL Secure Socket Layer 保证两个应用程序之间数据通信的安全性。
OpenSSL是SSL的开源实现。
    密钥交换，通过证书颁发机构/CA实现会话加密。
    CA对客户的真实性进行验证；
    CA也拥有自己的证书(即 公钥和私钥)，CA的公钥会被放到互联网上，让用户可以获取到。
对称加密
    DES(56bit)，3DES，AES(128bit)
    主要用于：对数据进行加密
RSA
    非对称加密
    主要用于：密钥的交换
        公钥加密，私钥解秘






***
支持国密的OpenSSL分支：https://github.com/guanzhi/GmSSL.git 




