
# Library Functions Manual(库函数手册)
```
NAME		ldap - OpenLDAP Lightweight Directory Access Protocol API
LIBRARY		OpenLDAP LDAP (libldap, -lldap)
SYNOPSIS	#include <ldap.h>
```



## DESCRIPTION(描述)
The  Lightweight  Directory  Access  Protocol  provides access to X.500 directory services.  The services may  be  stand-alone  or  part  of  a distributed  directory  service.   This  API  supports  LDAP  over  TCP (RFC2251), LDAP over SSL, and LDAP  over  IPC  (UNIX  domain  sockets). This  API supports SASL (RFC2829) and Start TLS (RFC2830).  This API is based upon IETF C LDAP API draft specification, a work in progress.
LDAP提供对X.500目录服务的访问。这些服务可以是独立的，也可以是分布式目录服务的一部分。
此API支持TCP上的LDAP (RFC2251)、SSL上的LDAP和IPC上的LDAP (UNIX域套接字)。
支持SASL(RFC2829)和Start TLS(RFC2830)。
这个API是基于IETF C LDAP API规范草案的，这个工作正在进行中。

The  OpenLDAP  Software  package  includes  a  stand-alone  server   in slapd(8),  various  LDAP  clients,  and  an LDAP client library used to provide programmatic access to the LDAP protocol. This man  page  gives an overview of the LDAP library routines.
OpenLDAP软件包 包括slapd(8)中的一个独立服务器、各种LDAP客户端和一个用于提供对LDAP协议的编程访问的LDAP客户端库。
此手册页提供了LDAP库例程的概述。

Both synchronous and asynchronous APIs are provided.  Also included are various routines to parse the results  returned  from  these  routines. These routines are found in the -lldap library.
同时提供了同步和异步api。
还包括各种解析从这些例程返回的结果的例程。
这些例程可以在-lldap库中找到。

The basic interaction is as follows.  A session handle is created using ldap_init(3) or ldap_initialize(3).  (The ldap_initialize(3) routine is preferred, but is not part of the draft specification.)  The underlying session is established upon first use which is commonly  an  LDAP  bind operation.    The   LDAP   bind   operation  is  performed  by  calling ldap_sasl_bind(3) or one of its friends.  Next,  other  operations  are performed  by  calling  one of the synchronous or asynchronous routines (e.g.,   ldap_search_ext_s(3)   or   ldap_search_ext(3)   followed   by ldap_result(3)).   Results returned from these routines are interpreted by calling the LDAP parsing routines such as ldap_parse_result(3).  The LDAP  association  and  underlying  connection is terminated by calling ldap_unbind_ext(3).    Errors   can   be   interpreted    by    calling ldap_err2string(3).
基本的相互作用如下。
使用ldap_init(3)或ldap_initialize(3)创建会话句柄。(ldap_initialize(3)例程是首选，但不是草案规范的一部分。)
底层会话是在首次使用时建立的，这通常是一个LDAP  bind operation/LDAP绑定操作。
LDAP绑定操作通过调用ldap_sasl_bind(3)或它的一个友方来执行。
接下来，通过调用一个同步或异步例程来执行其他操作(例如，ldap_search_ext_s(3)或ldap_search_ext(3)后跟ldap_result(3))。
通过调用LDAP解析例程(如ldap_parse_result(3))来解释从这些例程返回的结果。
通过调用ldap_unbind_ext(3)终止LDAP关联和底层连接。
可以通过调用ldap_err2string(3)来解释错误。



## SEARCH FILTERS(搜索过滤器)
Search  filters  to  be  passed  to  the ldap search routines are to be constructed by hand and should conform to RFC 2254.
传递给ldap搜索例程的搜索过滤器 是手工构造的/constructed，并且应该符合RFC 2254。



## DISPLAYING RESULTS(显示结果)
Results obtained from the ldap search routines can be output  by  hand, by  calling  ldap_first_entry(3) and ldap_next_entry(3) to step through the      entries      returned,       ldap_first_attribute(3)       and ldap_next_attribute(3)  to  step  through  an  entry's  attributes, and ldap_get_values(3) to retrieve a given attribute's  values.   Attribute values may or may not be displayable.
从ldap搜索例程中获得的结果可以手工输出，通过调用ldap_first_entry(3)和ldap_next_entry(3)来逐步遍历返回的条目，调用ldap_first_attribute(3)和ldap_next_attribute(3)来逐步遍历条目的属性，和ldap_get_values(3)检索给定属性的值。属性值可以显示，也可以不显示。




## CONTROLS(控件)
This  library  supports  both  LDAP  Version  2 and Version 3, with the Version 2 protocol selected by default.  LDAP Version 3 operations  can be  extended  through  the  use  of controls. Controls can be sent to a server or returned to the  client  with  any  LDAP  message.   Extended versions  of the standard routines are available for use with controls.  These routines are generally  named  by  adding  _ext  to  the  regular routine's name.
这个库支持LDAP版本2和版本3，默认情况下选择版本2协议。
LDAP Version 3操作可以通过使用控件/control进行扩展。
可以使用任何LDAP消息/message 将控件/control发送到服务器或返回到客户机。
标准例程的扩展版本可以与控件一起使用。这些例程通常通过在常规例程的名称中添加_ext来命名。



## UNIFORM RESOURCE LOCATORS (URLS)(统一资源定位符)
The  ldap_url(3)  routines can be used to test a URL to see if it is an LDAP URL, to parse LDAP  URLs  into  their  component  pieces,  and  to initiate searches directly using an LDAP URL.
ldap_url(3)例程可用于测试URL，以确定它是否是LDAP URL，
将LDAP URL解析为其组件部分，并直接使用LDAP URL进行搜索。



## UTILITY ROUTINES(实用程序例程)
Also  provided are various utility routines.  The ldap_sort(3) routines are used to sort the entries and values returned via  the  ldap  search routines.
还提供了各种实用程序例程。
ldap_sort(3)例程用于对通过ldap搜索例程返回的条目和值进行排序。



## BER LIBRARY(BER库)
Also  included  in  the  distribution  is  a  set  of lightweight Basic Encoding Rules routines.  These routines are used by the  LDAP  library routines  to  encode  and  decode  LDAP  protocol  elements  using  the (slightly simplified) Basic Encoding Rules defined by LDAP.   They  are not normally used directly by an LDAP application program except in the handling of controls and extended operations.  The routines  provide  a printf  and scanf-like interface, as well as lower-level access.  These routines   are    discussed    in    lber-decode(3),    lber-encode(3), lber-memory(3), and lber-types(3).
该发行版中还包括一组轻量级的Basic Encoding Rules例程。
LDAP库例程使用这些例程来使用LDAP定义的基本编码规则/BER(稍微简化了)对LDAP协议元素进行编码和解码。
LDAP应用程序通常不会直接使用它们，除非在处理控件和扩展操作时使用。
这些例程提供了类似printf和scanf的接口，以及较低级别的访问。
这些例程在lber-decode(3)， lber-encode(3)， lber-memory(3)和lber-types(3)中进行了讨论。



## INDEX

```bash
       ldap_open(3)        open  a  connection  to an LDAP server (deprecated, use ldap_init(3))
                            打开到LDAP服务器的连接(已弃用，使用ldap_init(3))
       ldap_init(3)        initialize  the  LDAP  library  without  opening  a connection to a server
                            初始化LDAP库，但不打开到服务器的连接
       ldap_initialize(3)  initialize  the  LDAP  library  without  opening  a connection to a server
                            初始化LDAP库，但不打开到服务器的连接



       ldap_result(3)      wait for the result from an asynchronous operation
                            等待异步操作的结果



       ldap_abandon(3)     abandon (abort) an asynchronous operation
                            放弃(中止)一个异步操作



       ldap_add(3)         asynchronously add an entry
                            异步添加一个条目
       ldap_add_s(3)       synchronously add an entry
                            同步添加一个条目



       ldap_bind(3)        asynchronously bind to the directory
                            异步绑定到目录
       ldap_bind_s(3)      synchronously bind to the directory
                            同步绑定到目录



       ldap_simple_bind(3) asynchronously bind to the directory  using  simple authentication
                            使用简单的身份验证 异步绑定到目录
       ldap_simple_bind_s(3)
                           synchronously  bind  to  the directory using simple authentication
                           使用简单的身份验证同步绑定到目录



       ldap_unbind(3)      synchronously unbind from the LDAP server and close the connection
                            同步解除与LDAP服务器的绑定并关闭连接
       ldap_unbind_s(3)    equivalent to ldap_unbind(3)
                            相当于ldap_unbind (3)



       ldap_memfree (3)    dispose of memory allocated by LDAP routines.
                            释放LDAP例程分配的内存。



       ldap_compare(3)     asynchronously compare to a directory entry
                            与目录条目进行异步比较
       ldap_compare_s(3)   synchronously compare to a directory entry
                            同步地比较目录条目



       ldap_delete(3)      asynchronously delete an entry
                            异步删除一个条目
       ldap_delete_s(3)    synchronously delete an entry
                            同步删除一个条目



       ldap_perror(3)      print an LDAP error indication to standard error
                            将 LDAP错误指示 打印到标准错误
       ld_errno(3)         LDAP error indication
                            LDAP错误指示
       ldap_result2error(3)
                           extract LDAP error indication from LDAP result
                           从LDAP结果中 提取LDAP错误指示
       ldap_errlist(3)     list of LDAP errors and their meanings
                            LDAP错误及其含义的列表
       ldap_err2string(3)  convert LDAP error indication to a string
                            将LDAP错误指示转换为字符串



       ldap_first_attribute(3)
                           return first attribute name in an entry
                           返回条目中的第一个属性名
       ldap_next_attribute(3)
                           return next attribute name in an entry
                           返回条目中的下一个属性名



       ldap_first_entry(3) return first entry in a chain of search results
                            返回搜索结果链中的第一个条目
       ldap_next_entry(3)  return next entry in a chain of search results
                            返回搜索结果链中的下一个条目



       ldap_count_entries(3)
                           return number of entries in a search result
                           返回搜索结果中的条目数



       ldap_get_dn(3)      extract the DN from an entry
                            从条目中提取DN



       ldap_explode_dn(3)  convert a DN into its component parts
                            将DN转换为其组成部分
       ldap_explode_rdn(3) convert an RDN into its component parts
                            将RDN转换为其组成部分



       ldap_get_values(3)  return an attribute's values
                            返回属性值
       ldap_get_values_len(3)
                           return an attribute's values with lengths
                           返回带有长度的属性值



       ldap_value_free(3)  free memory allocated by ldap_get_values(3)
                            释放ldap_get_values(3)分配的内存
       ldap_value_free_len(3)
                           free memory allocated by ldap_get_values_len(3)
                           释放ldap_get_values_len(3)分配的内存



       ldap_count_values(3)
                           return number of values
                           返回值的数目
       ldap_count_values_len(3)
                           return number of values
                           返回值的数目



       ldap_modify(3)      asynchronously modify an entry
                            异步修改一个条目
       ldap_modify_s(3)    synchronously modify an entry
                            同步修改一个条目
       ldap_mods_free(3)   free  array  of  pointers to mod structures used by ldap_modify(3)
                            释放被ldap_modify(3)使用的 mod结构体(由指针数组指向）



       ldap_modrdn2(3)     asynchronously modify the RDN of an entry
                            异步修改条目的RDN
       ldap_modrdn2_s(3)   synchronously modify the RDN of an entry
                            同步修改条目的RDN
       ldap_modrdn(3)      deprecated - use ldap_modrdn2(3)
                            已被废弃 - 使用ldap_modrdn2(3)
       ldap_modrdn_s(3)    depreciated - use ldap_modrdn2_s(3)
                            已被废弃 - 使用ldap_modrdn2_s(3)



       ldap_msgfree(3)     free results allocated by ldap_result(3)
                            释放由ldap_result(3)分配的结果



       ldap_msgtype(3)     return  the  message  type  of   a   message   from ldap_result(3)
                            返回来自ldap_result(3)的消息的消息类型



       ldap_msgid(3)       return   the   message   id   of   a  message  from ldap_result(3)
                            从ldap_result(3)的一个message中返回message-id



       ldap_search(3)      asynchronously search the directory
                            异步搜索目录
       ldap_search_s(3)    synchronously search the directory
                            同步搜索目录
       ldap_search_st(3)   synchronously search the directory with timeout
                            同步搜索超时目录



       ldap_is_ldap_url(3) check a URL string to see if it is an LDAP URL
                            检查URL字符串是否为LDAP URL
       ldap_url_parse(3)   break up an LDAP URL string into its components
                            将LDAP URL字符串分解为其组件



       ldap_sort_entries(3)
                           sort a list of search results
                           排序搜索结果列表
       ldap_sort_values(3) sort a list of attribute values
                            对属性值列表进行排序



       ldap_sort_strcasecmp(3)
                           case insensitive string comparison
                           不区分大小写的字符串比较


```

## SEE ALSO(另请参阅)
ldap.conf(5),         slapd(8),          draft-ietf-ldapext-ldap-c-api-xx.txt <http://www.ietf.org>

## ACKNOWLEDGEMENTS
OpenLDAP   is   developed   and  maintained  by  The  OpenLDAP  Project(http://www.openldap.org/).  OpenLDAP is  derived  from  University  of Michigan LDAP 3.3 Release.
OpenLDAP由OpenLDAP项目(http://www.openldap.org/)负责开发和维护。
OpenLDAP源自于密歇根大学LDAP 3.3版本。

These API manual pages are based upon descriptions provided in the IETF C LDAP API Internet Draft, a work in progress, edited by Mark Smith.
这些API手册页面是基于IETF C LDAP API Internet草案中提供的描述，该草案正在编写中，由Mark Smith编辑。


OpenLDAP 2.1.22                   
06-26-2003                           
LDAP(3)