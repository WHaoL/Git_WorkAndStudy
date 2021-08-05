





Network Working Group                                           T. Howes
Request for Comments: 1823                                      M. Smith
Category: Informational                          University of  Michigan
                                                             August 1995


# The LDAP Application Program Interface(LDAP应用程序编程接口)

Status of this Memo

   This memo provides information for the Internet community.  This memo
   does not specify an Internet standard of any kind.  Distribution of
   this memo is unlimited.

# 1.  Introduction

This document defines a C language application program interface to the lightweight directory access protocol (LDAP). The LDAP API is designed to be powerful, yet simple to use. It defines compatible synchronous and asynchronous interfaces to LDAP to suit a wide variety of applications.  This document gives a brief overview of the LDAP model, then an overview of how the API is used by an application program to obtain LDAP information.  The API calls are described in detail, followed by an appendix that provides some example code demonstrating the use of the API.
本文档定义了一个用于轻量级目录访问协议(LDAP)的C语言应用程序接口。
LDAP API被设计为功能强大，但使用简单。
它为LDAP定义了兼容的同步和异步接口，以适应各种应用程序。
本文档简要介绍了LDAP模型/model，然后概述了应用程序如何使用API来获取LDAP信息。
详细描述了API调用，在附录中提供了一些演示API使用的示例代码。



# 2.  Overview of the LDAP Model(LDAP模型概述)

LDAP is the lightweight directory access protocol, described in [2] and [7]. It can provide a lightweight frontend to the X.500 directory [1], or a stand-alone service. In either mode, LDAP is based on a client-server model in which a client makes a TCP connection to an LDAP server, over which it sends requests and receives responses.
LDAP是轻量级的目录访问协议，在[2]和[7]中有描述。
它可以为X.500目录[1]提供轻量级前端，或者提供独立的服务。
        在这两种模式中，**LDAP都基于client-server模型**，
        **在该模型中，客户端与LDAP服务器建立TCP连接，通过该连接发送请求并接收响应。**

The LDAP information model is based on the entry, which contains information about some object (e.g., a person).  Entries are composed of attributes, which have a type and one or more values. Each attribute has a syntax that determines what kinds of values are allowed in the attribute (e.g., ASCII characters, a jpeg photograph, etc.) and how those values behave during directory operations (e.g., is case significant during comparisons).
**LDAP信息模型 基于条目，条目包含关于某个对象(例如，一个人)的信息。
条目由属性组成，属性具有一个类型和一个或多个值。
每个属性都有一个语法来确定
        属性中允许哪些类型的值(例如，ASCII字符，jpeg照片等)，
        以及这些值在目录操作期间的行为(例如，在比较期间大小写是否重要)。**

Entries are organized in a tree structure, usually based on political, geographical, and organizational boundaries. Each entry is uniquely named relative to its sibling entries by its relative distinguished name (RDN) consisting of one or more distinguished attribute values from the entry.  At most one value from each attribute may be used in the RDN.  For example, the entry for the
**条目以树状结构组织，通常基于政治、地理和组织边界。**
**每个条目相对于它的兄弟条目通过它的相对区别名(RDN)进行唯一命名，RDN由条目中的一个或多个区别属性值组成。**
**每个属性最多可以在RDN中使用一个值。**例如，

person Babs Jensen might be named with the "Barbara Jensen" value from the commonName attribute. A globally unique name for an entry, called a distinguished name or DN, is constructed by concatenating the sequence of RDNs from the root of the tree down to the entry. For example, if Babs worked for the University of Michigan, the DN of her U-M entry might be "cn=Barbara Jensen, o=University of Michigan, c=US". The DN format used by LDAP is defined in [4].
可以使用commonName属性中的“Barbara Jensen”值来命名Babs Jensen。
**条目的全局唯一名称，称为专有名称或DN，是通过将rdn序列从树的根向下连接到条目来构造的。**
例如，如果Babs在密歇根大学工作，她的U-M条目的DN可能是 "cn=Barbara Jensen, o=University of Michigan, c=US"。
LDAP使用的DN格式在[4]中定义。

Operations are provided to authenticate, search for and retrieve information, modify information, and add and delete entries from the tree.  The next sections give an overview of how the API is used and detailed descriptions of the LDAP API calls that implement all of these functions.
提供了用于**身份验证、搜索和检索信息、修改信息以及从树中添加和删除条目**的操作。
下一节将概述如何使用API，并详细描述实现所有这些函数的LDAP API调用。



# 3.  Overview of LDAP API Use(LDAP-API使用概述)

An application generally uses the LDAP API in four simple steps.
应用程序通常通过四个简单步骤使用LDAP API。

- Open a connection to an LDAP server. The ldap_open() call returns a handle to the connection, allowing multiple connections to be open at once.
打开与LDAP服务器的连接。
**ldap_open()调用 返回连接的句柄，允许同时打开多个连接。**

- Authenticate to the LDAP server and/or the X.500 DSA. The ldap_bind() call and friends support a variety of authentication methods.
认证到LDAP服务器和/或X.500 DSA。
**ldap_bind()调用 支持各种身份验证方法。**

- Perform some LDAP operations and obtain some results. ldap_search() and friends return results which can be parsed by ldap_result2error(), ldap_first_entry(), ldap_next_entry(), etc.
执行LDAP相关操作并获取结果。
**ldap_search()返回 可由ldap_result2error()、ldap_first_entry()、ldap_next_entry()等解析的结果。**

- Close the connection. The ldap_unbind() call closes the connection.
关闭连接。
**ldap_unbind()调用 关闭连接。**

Operations can be performed either synchronously or asynchronously. Synchronous calls end in _s. For example, a synchronous search can be completed by calling ldap_search_s(). An asynchronous search can be initiated by calling ldap_search(). All synchronous routines return an indication of the outcome of the operation (e.g, the constant LDAP_SUCCESS or some other error code).  The asynchronous routines return the message id of the operation initiated. This id can be used in subsequent calls to ldap_result() to obtain the result(s) of the operation.  An asynchronous operation can be abandoned by calling ldap_abandon().
**操作可以同步执行，也可以异步执行。**
**同步调用以_s结束。**
例如，
        同步搜索可以通过调用ldap_search_s()来完成。
        异步搜索可以通过调用ldap_search()来启动。
**所有同步例程都返回操作结果的指示(例如常量LDAP_SUCCESS或其他错误代码)。
异步例程返回初始化操作的message-id。**
        **这个id可以在对ldap_result()的后续调用中使用，以获得操作的结果。
        可以通过调用ldap_abandon()来放弃异步操作。**

Results and errors are returned in an opaque structure called LDAPMessage.  Routines are provided to parse this structure, step through entries and attributes returned, etc. Routines are also provided to interpret errors. The next sections describe these routines in more detail.
**结果和错误 在名为LDAPMessage的不透明结构体中返回。
提供了解析该结构体的例程，并逐步查看返回的条目和属性等。
还提供了用于解释错误的例程。**
下一节更详细地描述这些例程。



# 4.  Calls for performing LDAP operations(执行LDAP操作的调用)

This section describes each LDAP operation API call in detail. All calls take a "connection handle", a pointer to an LDAP structure containing per-connection information.  Many routines return results in an LDAPMessage structure. These structures and others are described as needed below.
本节将详细描述  每个LDAP操作API调用。
所有调用都有一个"connection handle/连接句柄"，一个指向 包含每个连接信息的LDAP结构体  的指针。
许多例程在LDAPMessage结构中返回结果。
下面将根据需要描述这些结构和其他结构。



## 4.1.  Opening a connection(连接)

ldap_open() opens a connection to the LDAP server.
ldap_open() 打开到 LDAP服务器 的连接。
```c
              typedef struct ldap {
                      /* ... opaque parameters ... */
                      int     ld_deref;
                      int     ld_timelimit;
                      int     ld_sizelimit;
                      int     ld_errno;
                      char    *ld_matched;
                      char    *ld_error;
                      /* ... opaque parameters ... */
              } LDAP;

              LDAP *ldap_open( char *hostname, int portno );
/*
      Parameters are:
      参数

      hostname
      主机名 
        Contains a space-separated list of hostnames or dotted strings representing the IP address of hosts running an LDAP server to connect to. The hosts are tried in the order listed, stopping with the first one to which a successful connection is made;
        包含以空格分隔的 主机名列表 或 点分十进制字符串，表示 运行了LDAP服务器 要连接的主机的IP地址。
        按照列出的顺序尝试连接主机，当第一次成功连接到主机时 停止尝试;

      portno   
      端口号
        contains the TCP port number to which to connect. The default LDAP port can be obtained by supplying the constant LDAP_PORT.
        包含要连接的 TCP 端口号。 
        默认的LDAP端口，可以通过 指定/提供 常量 LDAP_PORT 获得。
*/
```
ldap_open() returns a "connection handle", a pointer to an LDAP structure that should be passed to subsequent calls pertaining to the connection. It returns NULL if the connection cannot be opened. One of the ldap_bind calls described below must be completed before other operations can be performed on the connection.
ldap_open() 返回一个"connection handle/连接句柄"，
        一个指向 LDAP结构体的指针，
        
        
        该结构体应该传递给与连接相关的后续调用。 
如果无法打开连接，则返回 NULL。 
必须先完成下面描述的 ldap_bind 调用之一，然后才能对连接执行其他操作。

The calling program should assume nothing about the order of the fields in the LDAP structure. There may be other fields in the structure for internal library use. The fields shown above are described as needed in the description of other calls below.
调用程序不应假设 LDAP结构体 中字段的顺序。 
结构体 中可能还有其他字段，以供内部库使用。 
上面显示的字段  在下面对其他调用的描述中 根据需要进行了描述。



## 4.2.  Authenticating to the directory(绑定并认证)

ldap_bind() and friends are used to authenticate to the directory.
ldap_bind()系列函数，用于对目录进行身份验证。
```c
        int ldap_bind( LDAP *ld, char *dn, char *cred, int method );

        int ldap_bind_s( LDAP *ld, char *dn, char *cred, int method );

        int ldap_simple_bind( LDAP *ld, char *dn, char *passwd );

        int ldap_simple_bind_s( LDAP *ld, char *dn, char *passwd );

        int ldap_kerberos_bind( LDAP *ld, char *dn );

        int ldap_kerberos_bind_s( LDAP *ld, char *dn );
/*
   Parameters are:

        ld     
                The connection handle;
                连接句柄              

        dn     
                The name of the entry to bind as;
                要绑定到的entry的name

        cred   
                The credentials with which to authenticate;
                用于认证的证书

        method 
                One of LDAP_AUTH_SIMPLE, LDAP_AUTH_KRBV41, or LDAP_AUTH_KRBV42, indicating the authentication method to use;
                LDAP_AUTH_SIMPLE, LDAP_AUTH_KRBV41,或LDAP_AUTH_KRBV42，指示要使用的身份认证方式

        passwd 
                For ldap_simple_bind(), the password to compare to the entry's userPassword attribute;
                对于ldap_simple_bind()，这个参数(password)要与entry的attribute：userPassword进行比较

*/
```
There are three types of bind calls, providing simple authentication, kerberos authentication, and general routines to do either one. In the case of Kerberos version 4 authentication using the general ldap_bind() routines, the credentials are ignored, as the routines assume a valid ticket granting ticket already exists which can be used to retrieve the appropriate service tickets.
有三种类型的绑定调用，提供: 简单身份验证、kerberos身份验证 和 执行任一操作的常规例程。
在使用通用ldap_bind()例程的 Kerberos 版本4 身份验证的情况下，证书将被忽略，
        因为例程假定已存在一个授予票证的有效票证，该票证可用于检索适当的服务票证。

Synchronous versions of the routines have names that end in _s. These routines return the result of the bind operation, either the constant LDAP_SUCCESS if the operation was successful, or another LDAP error code if it was not. See the section below on error handling for more information about possible errors and how to interpret them.
例程的**同步版本** 具有 以_s结尾的名称。
这些例程 返回绑定操作的结果，
        如果操作成功则返回 常量LDAP_SUCCESS，
        否则返回另一个 LDAP错误代码。
有关可能的错误以及如何解释它们的更多信息，请参阅下面关于错误处理的部分。

Asynchronous versions of these routines return the message id of the bind operation initiated. A subsequent call to ldap_result(), described below, can be used to obtain the result of the bind. In case of error, these routines will return -1, setting the ld_errno field in the LDAP structure appropriately.
这些例程的**异步版本**返回 初始绑定操作时的message-ID。
对 ldap_result() 的后续调用（如下所述）可用于获取绑定的结果。
如果出现错误，这些例程将返回 -1，并设置 LDAP结构体 中的ld_errno字段。

Note that no other operations over the connection should be attempted before a bind call has successfully completed. Subsequent bind calls can be used to re-authenticate over the same connection.
请注意，在绑定调用成功完成之前，不应尝试通过连接进行其他操作。
随后的绑定调用可用于通过同一连接重新进行身份验证。



## 4.3.  Closing the connection(解除绑定并关闭连接)

ldap_unbind() is used to unbind from the directory and close the connection.
ldap_unbind()用于 从目录中解除绑定 并关闭连接。
```c
        int ldap_unbind( LDAP *ld );

/*
   Parameters are:
   参数是

        ld      The connection handle.
                连接句柄
*/
```
ldap_unbind() works synchronously, unbinding from the directory, closing the connection, and freeing up the ld structure before returning. ldap_unbind() returns LDAP_SUCCESS (or another LDAP error code if the request cannot be sent to the LDAP server).  After a call to ldap_unbind(), the ld connection handle is invalid.
ldap_unbind()执行的是同步操作，从目录中解除绑定，关闭连接，并在返回之前释放 ld结构体。 
ldap_unbind() 返回 LDAP_SUCCESS（如果请求无法发送到 LDAP服务器，则返回另一个 LDAP错误代码）。 
调用 ldap_unbind() 后，ld连接句柄无效。



## 4.4.  Searching(搜索)

ldap_search() and friends are used to search the LDAP directory, returning a requested set of attributes for each entry matched. There are three variations.
ldap_search()系列函数，用于搜索LDAP目录，为每个匹配的条目/entry 返回一组请求的属性/attribute。
有三种变体。
```c
           struct timeval {
                   long    tv_sec;
                   long    tv_usec;
           };
           int ldap_search(
                   LDAP    *ld,
                   char    *base,
                   int     scope,
                   char    *filter,
                   char    *attrs[],
                   int     attrsonly
           );
           int ldap_search_s(
                   LDAP            *ld,
                   char            *base,
                   int             scope,
                   char            *filter,
                   char            *attrs[],
                   int             attrsonly,
                   LDAPMessage     **res
           );
           int ldap_search_st(
                   LDAP            *ld,
                   char            *base,
                   int             scope,
                   char            *filter,
                   char            *attrs[],
                   int             attrsonly,
                   struct timeval  *timeout,
                   LDAPMessage     **res
           );

/*
   Parameters are:
   参数是

   ld        
        The connection handle;

   base      
        The dn of the entry at which to start the search;
        开始搜索的enrty的dn(name)

   scope     
        One of LDAP_SCOPE_BASE, LDAP_SCOPE_ONELEVEL, or LDAP_SCOPE_SUBTREE, indicating the scope of the search;
        LDAP_SCOPE_BASE、LDAP_SCOPE_ONELEVEL或LDAP_SCOPE_SUBTREE 中的一个，表示搜索范围;

   filter    
        A character string as described in RFC 1558 [3], representing the search filter;
        RFC1558[3]中描述的字符串，表示搜索过滤器;

   attrs     
        A NULL-terminated array of strings indicating which attributes to return for each matching entry. Passing NULL for this parameter causes all available attributes to be retrieved;
        以null结尾的 字符串数组，指示为每个匹配项返回哪些属性。
        为这个参数传递NULL将导致检索所有可用的属性;

   attrsonly 
        A boolean value that should be zero if both attribute types and values are to be returned, non-zero if only types are wanted;
        一个布尔值，
            如果同时返回属性类型和值，则为零;
            如果只需要类型，则为非零;

   timeout   
        For the ldap_search_st() call, this specifies the local search timeout value;
        对于ldap_search_st()调用，它指定本地搜索超时值;

   res       
        For the synchronous calls, this is a result parameter which will contain the results of the search upon completion of the call.
        对于同步调用，这是一个result参数，它将在调用完成时包含搜索的结果。


There are three fields in the ld connection handle which control how the search is performed. They are:
ld连接句柄中有三个字段，它们控制如何执行搜索。它们是:

   ld_sizelimit 
   个数限制
        A limit on the number of entries to return from the search. A value of zero means no limit;
        从搜索返回的条目数量的限制。
        值为零表示没有限制;

   ld_timelimit 
   时间限制
        A limit on the number of seconds to spend on the search. A value of zero means no limit;
        对搜索的秒数进行限制。
        值为零表示没有限制;

   ld_deref
   解引用
        One of LDAP_DEREF_NEVER, LDAP_DEREF_SEARCHING, LDAP_DEREF_FINDING, or LDAP_DEREF_ALWAYS, specifying how aliases should be handled during the search. The LDAP_DEREF_SEARCHING value means aliases should be dereferenced during the search but not when locating the base object of the search. The LDAP_DEREF_FINDING value means aliases should be dereferenced when locating the base object but not during the search.
        LDAP_DEREF_NEVER、LDAP_DEREF_SEARCHING、LDAP_DEREF_FINDING或LDAP_DEREF_ALWAYS 中的一个，指定在搜索期间应如何处理别名。LDAP_DEREF_SEARCHING值意味着在搜索期间应该对别名解引用，但在定位搜索的基本对象/base-object时不应解引用。
        LDAP_DEREF_FINDING值意味着应该在定位基对象/base-object时对别名解引用，但在搜索期间不这样做。

*/

```

An asynchronous search is initiated by calling ldap_search(). It returns the message id of the initiated search. The results of the search can be obtained by a subsequent call to ldap_result().  The results can be parsed by the result parsing routines described in detail later.  In case of error, -1 is returned and the ld_errno field in the LDAP structure is set appropriately.
**异步搜索是通过调用ldap_search()来启动的。它返回发起搜索的message-id。**
    **调用ldap_result()来获得搜索结果。**
    可以**由后面详细描述的 结果解析例程 来解析结果。**
如果出现错误，则返回-1，并适当设置LDAP结构体中的ld_errno字段。

A synchronous search is performed by calling ldap_search_s() or ldap_search_st(). The routines are identical, except that ldap_search_st() takes an additional parameter specifying a timeout for the search.  Both routines return an indication of the result of the search, either LDAP_SUCCESS or some error indication (see Error Handling below).  The entries returned from the search (if any) are contained in the res parameter. This parameter is opaque to the caller.  Entries, attributes, values, etc., should be extracted by calling the parsing routines described below. The results contained in res should be freed when no longer in use by calling ldap_msgfree(), described later.
**通过调用ldap_search_s()或ldap_search_st()执行同步搜索。**
例程是相同的，除了ldap_search_st()需要一个额外的参数 来指定搜索超时。
这两个例程**都返回一个表示搜索结果的指示，要么是LDAP_SUCCESS，要么是一些错误指示**(请参阅下面的错误处理)。
从搜索**返回的条目(如果有的话)包含在res参数中**。
这个参数对调用者是不透明的。
**条目、属性、值等应该通过调用下面描述的解析例程来提取。**
**res中包含的结果 应该在不再使用时 通过调用ldap_msgfree()释放**，稍后将对此进行描述。



## 4.5.  Reading an entry(读一个entry)

LDAP does not support a read operation directly. Instead, this operation is emulated by a search with base set to the DN of the entry to read, scope set to LDAP_SCOPE_BASE, and filter set to "(objectclass=*)". attrs contains the list of attributes to return.
LDAP不支持 直接读取操作。 
相反，此操作是通过：
    将base设置为要读取的条目的DN、
    scope设置为LDAP_SCOPE_BASE 
    并将filter设置为“(objectclass=*)” 的搜索 来模拟的。 
attrs 包含要返回的属性列表。



## 4.6.  Listing the children of an entry(列出一个entry的孩子)

LDAP does not support a list operation directly. Instead, this operation is emulated by a search with base set to the DN of the entry to list, scope set to LDAP_SCOPE_ONELEVEL, and filter set to "(objectclass=*)". attrs contains the list of attributes to return for each child entry.
LDAP 不直接支持list操作。 
相反，此操作是通过：
    将base设置为要列出的条目的DN、
    scope设置为 LDAP_SCOPE_ONELEVEL 
    并将filter设置为“(objectclass=*)” 的搜索 来模拟的。 
attrs 包含 要为每个子条目返回的属性列表。



## 4.7.  Modifying an entry(修改一个entry)

The ldap_modify() and ldap_modify_s() routines are used to modify an existing LDAP entry.
ldap_modify()和ldap_modify_s()例程 用于修改现有的 LDAP条目。
```c
           typedef struct ldapmod {
                   int             mod_op;
                   char            *mod_type;
                   union {
                           char            **modv_strvals;
                           struct berval   **modv_bvals;
                   } mod_vals;
           } LDAPMod;
           #define mod_values      mod_vals.modv_strvals
           #define mod_bvalues     mod_vals.modv_bvals

           int ldap_modify( LDAP *ld, char *dn, LDAPMod *mods[] );

           int ldap_modify_s( LDAP *ld, char *dn, LDAPMod *mods[] );
/* 
   Parameters are:

   ld       The connection handle;

   dn       
            The name of the entry to modify;
            要修改的entry的name

   mods     
            A NULL-terminated array of modifications to make to the entry.
            以NULL结尾的字符串数组，要应用到entry的修改

The fields in the LDAPMod structure have the following meanings:
LDAPMod结构体中的字段，含义如下：

   mod_op   
            The modification operation to perform. It should be one of LDAP_MOD_ADD, LDAP_MOD_DELETE, or LDAP_MOD_REPLACE. This field also indicates the type of values included in the mod_vals union. It is ORed with LDAP_MOD_BVALUES to select the mod_bvalues form. Otherwise, the mod_values form is used;
            要执行的修改操作。(即：要对DN或DN中的属性 执行什么操作)
            它应该是 LDAP_MOD_ADD、LDAP_MOD_DELETE 或 LDAP_MOD_REPLACE 之一。
            该字段还指示了包含在 mod_vals联合体 中的值的类型。
                它与 LDAP_MOD_BVALUES 进行 OR 运算以选择 mod_bvalues 形式。
                否则，使用 mod_values 形式；

   mod_type 
            The type of the attribute to modify;
            要修改的属性的类型；
            (即：要修改DN中的哪个属性)

   mod_vals 
            The values (if any) to add, delete, or replace. Only one of the mod_values or mod_bvalues variants should be used, selected by ORing the mod_op field with the constant LDAP_MOD_BVALUES. mod_values is a NULL-terminated array of zero-terminated strings and mod_bvalues is a NULL-terminated array of berval structures that can be used to pass binary values such as images.
            要添加、删除或替换的值（如果有）。
            只应使用 mod_values 或 mod_bvalues 变量之一，
                通过将 mod_op 字段与常量 LDAP_MOD_BVALUES 进行 OR 运算来选择。 
            mod_values 是一个以 NULL结尾的 字符串(以0终止) 数组， 
            mod_bvalues 是一个以 NULL 结尾的 berval结构体 数组，可用于传递二进制值，例如图像。

*/
```

For LDAP_MOD_ADD modifications, the given values are added to the entry, creating the attribute if necessary.  For LDAP_MOD_DELETE modifications, the given values are deleted from the entry, removing the attribute if no values remain.  If the entire attribute is to be deleted, the mod_vals field should be set to NULL.  For LDAP_MOD_REPLACE modifications, the attribute will have the listed values after the modification, having been created if necessary.  All modifications are performed in the order in which they are listed.
对于 **LDAP_MOD_ADD**，给定的值 被添加到条目中，必要时创建属性。

对于 **LDAP_MOD_DELETE**，从条目中删除给定的值，如果没有值，则删除该属性。 
如果要删除整个属性，则应将 mod_vals 字段设置为 NULL。 

对于 **LDAP_MOD_REPLACE**，属性将在修改后具有列出的值，必要时已创建。 
所有修改都按它们列出的顺序执行。

ldap_modify_s() returns the LDAP error code  resulting  from the modify  operation.   This  code  can  be interpreted by ldap_perror() and friends.
ldap_modify_s() 返回 由修改操作产生的 LDAP 错误代码。 
这段代码可以被 ldap_perror()系列函数 解释。

ldap_modify() returns the message id of the request it initiates, or -1 on error.  The result of the operation can be obtained by calling ldap_result().
ldap_modify() 返回 它发起的请求的message-id，或 出错时返回-1。 
可以通过调用 ldap_result() 获得操作的结果。



## 4.8.  Modifying the RDN of an entry(修改entry的DN)

The ldap_modrdn() and ldap_modrdn_s() routines are used to change the name of an LDAP entry.
ldap_modrdn()和ldap_modrdn_s()例程 用于更改 LDAP entry的name。
```c
           int ldap_modrdn(
                   LDAP    *ld,
                   char    *dn,
                   char    *newrdn,
                   int     deleteoldrdn
           );
           int ldap_modrdn_s(
                   LDAP    *ld,
                   char    *dn,
                   char    *newrdn,
                   int     deleteoldrdn
           );

/*
   Parameters are:

   ld            
        The connection handle;

   dn            
        The name of the entry whose RDN is to be changed;
        entry的name，它的RDN将被修改

   newrdn        
        The new RDN to give the entry;
        给entry的 新的RDN

   deleteoldrdn  
        A boolean value, if non-zero indicating that the old RDN value(s) should be removed, if zero indicating that the old RDN value(s) should be retained as non- distinguished values of the entry.
        一个布尔值，
                如果非零 表示应删除   旧RDN值，
                如果为零 则表示应保留 旧RDN值 作为条目的非区分值。
*/

```
The ldap_modrdn_s() routine is synchronous, returning the LDAP error code indicating the outcome of the operation.
ldap_modrdn_s() 例程是同步的，返回 指示操作结果的 LDAP错误代码。

The ldap_modrdn() routine is asynchronous, returning the message id of the operation it initiates, or -1 in case of trouble. The result of the operation can be obtained by calling ldap_result().
ldap_modrdn() 例程是异步的，返回 发起操作的message-id，如果出现问题，返回 -1。 
可以通过调用 ldap_result() 获得操作的结果。



## 4.9.  Adding an entry(添加一个entry)

ldap_add() and ldap_add_s() are used to add entries to the LDAP directory.
ldap_add()和ldap_add_s() 用于向LDAP目录添加entry。
```c
           int ldap_add( LDAP *ld, char *dn, LDAPMod *attrs[] );
    
           int ldap_add_s( LDAP *ld, char *dn, LDAPMod *attrs[] );

/*
   Parameters are:

   ld    
        The connection handle;

   dn    
        The name of the entry to add;
        要添加的entry的name。

   attrs 
        The entry's attributes, specified using the LDAPMod structure defined for ldap_modify(). 
        The mod_type and mod_vals fields should be filled in.  
        The mod_op field is ignored unless ORed with the constant LDAP_MOD_BVALUES, used to select the mod_bvalues case of the mod_vals union.
        条目的属性，使用 为ldap_modify()定义的LDAPMod结构体 指定。 
        应填写 mod_type 和 mod_vals 字段。 
        mod_op 字段将被忽略，除非与常量 LDAP_MOD_BVALUES 进行 OR 运算，用于选择 mod_vals联合体 的 mod_bvalues。
*/
```
Note that the parent of the entry must already exist.
请注意，条目的父项必须已经存在。

ldap_add_s() is synchronous, returning the LDAP error code indicating the outcome of the operation.
ldap_add_s() 是同步的，返回 指示操作结果的 LDAP错误代码。

ldap_add() is asynchronous, returning the message id of the operation it initiates, or -1 in case of trouble. The result of the operation can be obtained by calling ldap_result().
ldap_add() 是异步的，返回 发起操作的message-id，或 出错时返回-1。 
可以通过调用 ldap_result() 获得操作的结果。




## 4.10.  Deleting an entry(删除一个entry)

ldap_delete() and ldap_delete_s() are used to delete entries from the LDAP directory.
ldap_delete() 和 ldap_delete_s() 用于从 LDAP 目录中删除条目/entry。
```c
           int ldap_delete( LDAP *ld, char *dn );
    
           int ldap_delete_s( LDAP *ld, char *dn );

/*
   Parameters are:

   ld       
        The connection handle;

   dn       
        The name of the entry to delete.
        要删除entry的name。
*/
```
Note that the entry to delete must be a leaf entry (i.e., it must have no children). Deletion of entire subtrees is not supported by LDAP.
请注意，要删除的条目必须是叶条目（即，它必须没有子项）。 
LDAP 不支持删除整个子树。

ldap_delete_s() is synchronous, returning the LDAP error code indicating the outcome of the operation.
ldap_delete_s() 是同步的，返回 指示操作结果的 LDAP错误代码。

ldap_delete() is asynchronous, returning the message id of the operation it initiates, or -1 in case of trouble. The result of the operation can be obtained by calling ldap_result().
ldap_delete() 是异步的，返回 发起操作的message-id，或 出错返回-1。 
可以通过调用 ldap_result() 获得操作的结果。




# 5.  Calls for abandoning an operation(放弃一个操作)

ldap_abandon() is used to abandon an operation in progress.
ldap_abandon() 用于放弃正在进行的操作。
```c
           int ldap_abandon( LDAP *ld, int msgid );
```
ldap_abandon() abandons the operation with message id msgid. 
It returns zero if the abandon was successful, -1 otherwise. 
After a successful call to ldap_abandon(), results with the given message id are never returned from a call to ldap_result().
ldap_abandon()放弃message-id 为 msgid 的操作。 
如果 放弃成功则返回零，否则返回-1。 
在成功调用 ldap_abandon() 后，永远不会从ldap_result()返回给定message-id的结果。



# 6.  Calls for obtaining results(获取结果)

ldap_result() is used to obtain the result of a previous asynchronously initiated operation. ldap_msgfree() frees the results obtained from a previous call to ldap_result(), or a synchronous search routine.
ldap_result() 用于获取先前异步启动的操作的结果。 
ldap_msgfree() 释放从先前调用 ldap_result() 或同步搜索例程中获得的结果。

```c
           int ldap_result(
                   LDAP            *ld,
                   int             msgid,
                   int             all,
                   struct timeval  *timeout,
                   LDAPMessage     **res
           );
    
           int ldap_msgfree( LDAPMessage *res );

/*
   Parameters are:

   ld       
        The connection handle;

   msgid    
        The message id of the operation whose results are to be returned, or the constant LDAP_RES_ANY if any result is desired;
        要返回其结果的 操作的message-id，如果需要任何结果，则为常量 LDAP_RES_ANY；

   all      
        A boolean parameter that only has meaning for search results. If non-zero it indicates that all results of a search should be retrieved before any are returned. If zero, search results (entries) will be returned one at a time as they arrive;

   timeout  
        A timeout specifying how long to wait for results to be returned.  A NULL value causes ldap_result() to block until results are available.  A timeout value of zero second specifies a polling behavior;

   res      
        For ldap_result(), a result parameter that will contain the result(s) of the operation. For ldap_msgfree(), the result chain to be freed, obtained from a previous call to ldap_result() or ldap_search_s() or ldap_search_st().
*/
```
Upon successful completion, ldap_result() returns the type of the result returned in the res parameter. This will be one of the following constants.
```c
             LDAP_RES_BIND
             LDAP_RES_SEARCH_ENTRY
             LDAP_RES_SEARCH_RESULT
             LDAP_RES_MODIFY
             LDAP_RES_ADD
             LDAP_RES_DELETE
             LDAP_RES_MODRDN
             LDAP_RES_COMPARE
```
ldap_result() returns 0 if the timeout expired and -1 if an error occurs, in which case the ld_errno field of the ld structure will be set accordingly.

ldap_msgfree() frees the result structure pointed to be res and returns the type of the message it freed.








Howes & Smith                Informational                     [Page 12]

RFC 1823                        LDAP API                     August 1995


# 7.  Calls for error handling

   The following calls are used to interpret errors returned by other
   LDAP API routines.

           int ldap_result2error(
                   LDAP            *ld,
                   LDAPMessage     *res,
                   int             freeit
           );
    
           char *ldap_err2string( int err );
    
           void ldap_perror( LDAP *ld, char *msg );

   Parameters are:

   ld       The connection handle;

   res      The result of an LDAP operation as returned by ldap_result()
            or one of the synchronous API operation calls;

   freeit   A boolean parameter indicating whether the res parameter
            should be freed (non-zero) or not (zero);

   err      An LDAP error code, as returned by ldap_result2error() or
            one of the synchronous API operation calls;

   msg      A message to be displayed before the LDAP error message.

   ldap_result2error() is used to convert the LDAP result message
   obtained from ldap_result(), or the res parameter returned by one of
   the synchronous API operation calls, into a numeric LDAP error code.
   It also parses the ld_matched and ld_error portions of the result
   message and puts them into the connection handle information. All the
   synchronous operation routines call ldap_result2error() before
   returning, ensuring that these fields are set correctly. The relevant
   fields in the connection structue are:

   ld_matched In the event of an LDAP_NO_SUCH_OBJECT error return, this
              parameter contains the extent of the DN matched;

   ld_error   This parameter contains the error message sent in the
              result by the LDAP server.

   ld_errno   The LDAP error code indicating the outcome of the
              operation. It is one of the following constants:




Howes & Smith                Informational                     [Page 13]

RFC 1823                        LDAP API                     August 1995


           LDAP_SUCCESS
           LDAP_OPERATIONS_ERROR
           LDAP_PROTOCOL_ERROR
           LDAP_TIMELIMIT_EXCEEDED
           LDAP_SIZELIMIT_EXCEEDED
           LDAP_COMPARE_FALSE
           LDAP_COMPARE_TRUE
           LDAP_STRONG_AUTH_NOT_SUPPORTED
           LDAP_STRONG_AUTH_REQUIRED
           LDAP_NO_SUCH_ATTRIBUTE
           LDAP_UNDEFINED_TYPE
           LDAP_INAPPROPRIATE_MATCHING
           LDAP_CONSTRAINT_VIOLATION
           LDAP_TYPE_OR_VALUE_EXISTS
           LDAP_INVALID_SYNTAX
           LDAP_NO_SUCH_OBJECT
           LDAP_ALIAS_PROBLEM
           LDAP_INVALID_DN_SYNTAX
           LDAP_IS_LEAF
           LDAP_ALIAS_DEREF_PROBLEM
           LDAP_INAPPROPRIATE_AUTH
           LDAP_INVALID_CREDENTIALS
           LDAP_INSUFFICIENT_ACCESS
           LDAP_BUSY
           LDAP_UNAVAILABLE
           LDAP_UNWILLING_TO_PERFORM
           LDAP_LOOP_DETECT
           LDAP_NAMING_VIOLATION
           LDAP_OBJECT_CLASS_VIOLATION
           LDAP_NOT_ALLOWED_ON_NONLEAF
           LDAP_NOT_ALLOWED_ON_RDN
           LDAP_ALREADY_EXISTS
           LDAP_NO_OBJECT_CLASS_MODS
           LDAP_RESULTS_TOO_LARGE
           LDAP_OTHER
           LDAP_SERVER_DOWN
           LDAP_LOCAL_ERROR
           LDAP_ENCODING_ERROR
           LDAP_DECODING_ERROR
           LDAP_TIMEOUT
           LDAP_AUTH_UNKNOWN
           LDAP_FILTER_ERROR
           LDAP_USER_CANCELLED
           LDAP_PARAM_ERROR
           LDAP_NO_MEMORY






Howes & Smith                Informational                     [Page 14]

RFC 1823                        LDAP API                     August 1995


   ldap_err2string() is used to convert a numeric LDAP error code, as
   returned by ldap_result2error() or one of the synchronous API
   operation calls, into an informative NULL-terminated character string
   message describing the error.  It returns a pointer to static data.

   ldap_perror() is used to print the message supplied in msg, followed
   by an indication of the error contained in the ld_errno field of the
   ld connection handle, to standard error.

# 8.  Calls for parsing search entries

   The following calls are used to parse the entries returned by
   ldap_search() and friends. These entries are returned in an opaque
   structure that should only be accessed by calling the routines
   described below. Routines are provided to step through the entries
   returned, step through the attributes of an entry, retrieve the name
   of an entry, and retrieve the values associated with a given
   attribute in an entry.

8.1.  Stepping through a set of entries

   The ldap_first_entry() and ldap_next_entry() routines are used to
   step through a set of entries in a search result.
   ldap_count_entries() is used to count the number of entries returned.

           LDAPMesage *ldap_first_entry( LDAP *ld, LDAPMessage *res );
    
           LDAPMesage *ldap_next_entry( LDAP *ld, LDAPMessage *entry );
    
           int ldap_count_entries( LDAP *ld, LDAPMessage *res );

   Parameters are:

   ld     The connection handle;

   res    The search result, as obtained by a call to one of the syn-
          chronous search routines or ldap_result();

   entry  The entry returned by a previous call to ldap_first_entry() or
          ldap_next_entry().

   ldap_first_entry() and ldap_next_entry() will return NULL when no
   more entries exist to be returned. NULL is also returned if an error
   occurs while stepping through the entries, in which case the ld_errno
   field of the ld connection handle will be set to indicate the error.

   ldap_count_entries() returns the number of entries contained in a
   chain of entries. It can also be used to count the number of entries



Howes & Smith                Informational                     [Page 15]

RFC 1823                        LDAP API                     August 1995


   that remain in a chain if called with an entry returned by
   ldap_first_entry() or ldap_next_entry().

8.2.  Stepping through the attributes of an entry

   The ldap_first_attribute() and ldap_next_attribute() calls are used
   to step through the list of attribute types returned with an entry.

           char *ldap_first_attribute(
                   LDAP            *ld,
                   LDAPMessage     *entry,
                   void            **ptr
           );
           char *ldap_next_attribute(
                   LDAP            *ld,
                   LDAPMessage     *entry,
                   void            *ptr
           );

   Parameters are:

   ld     The connection handle;

   entry  The entry whose attributes are to be stepped through, as
          returned by ldap_first_entry() or ldap_next_entry();

   ptr    In ldap_first_attribute(), the address of a pointer used
          internally to keep track of the current position in the entry.
          In ldap_next_attribute(), the pointer returned by a previous
          call to ldap_first_attribute().

   ldap_first_attribute() and ldap_next_attribute() will return NULL
   when the end of the attributes is reached, or if there is an error,
   in which case the ld_errno field in the ld connection handle will be
   set to indicate the error.

   Both routines return a pointer to a per-connection buffer containing
   the current attribute name. This should be treated like static data.
   ldap_first_attribute() will allocate and return in ptr a pointer to a
   BerElement used to keep track of the current position. This pointer
   should be passed in subsequent calls to ldap_next_attribute() to step
   through the entry's attributes.

   The attribute names returned are suitable for passing in a call to
   ldap_get_values() and friends to retrieve the associated values.






Howes & Smith                Informational                     [Page 16]

RFC 1823                        LDAP API                     August 1995


8.3.  Retrieving the values of an attribute

   ldap_get_values() and ldap_get_values_len() are used to retrieve the
   values of a given attribute from an entry. ldap_count_values() and
   ldap_count_values_len() are used to count the returned values.
   ldap_value_free() and ldap_value_free_len() are used to free the
   values.

           typedef struct berval {
                   unsigned long   bv_len;
                   char            *bv_val;
           };
    
           char **ldap_get_values(
                   LDAP            *ld,
                   LDAPMessage     *entry,
                   char            *attr
           );
    
           struct berval **ldap_get_values_len(
                   LDAP            *ld,
                   LDAPMessage     *entry,
                   char            *attr
           );
    
           int ldap_count_values( char **vals );
    
           int ldap_count_values_len( struct berval **vals );
    
           int ldap_value_free( char **vals );
    
           int ldap_value_free_len( struct berval **vals );

   Parameters are:

   ld     The connection handle;

   entry  The entry from which to retrieve values, as returned by
          ldap_first_entry() or ldap_next_entry();

   attr   The attribute whose values are to be retrieved, as returned by
          ldap_first_attribute() or ldap_next_attribute(), or a caller-
          supplied string (e.g., "mail");

   vals   The values returned by a previous call to ldap_get_values() or
          ldap_get_values_len().





Howes & Smith                Informational                     [Page 17]

RFC 1823                        LDAP API                     August 1995


   Two forms of the various calls are provided. The first form is only
   suitable for use with non-binary character string data only. The
   second _len form is used with any kind of data.

   Note that the values returned are malloc'ed and should be freed by
   calling either ldap_value_free() or ldap_value_free_len() when no
   longer in use.

8.4.  Retrieving the name of an entry

   ldap_get_dn() is used to retrieve the name of an entry.
   ldap_explode_dn() is used to break up the name into its component
   parts. ldap_dn2ufn() is used to convert the name into a more "user
   friendly" format.

           char *ldap_get_dn( LDAP *ld, LDAPMessage *entry );
    
           char **ldap_explode_dn( char *dn, int notypes );
    
           char *ldap_dn2ufn( char *dn );

   Parameters are:

   ld      The connection handle;

   entry   The entry whose name is to be retrieved, as returned by
           ldap_first_entry() or ldap_next_entry();

   dn      The dn to explode, as returned by ldap_get_dn();

   notypes A boolean parameter, if non-zero indicating that the dn com-
           ponents should have their type information stripped off
           (i.e., "cn=Babs" would become "Babs").

   ldap_get_dn() will return NULL if there is some error parsing the dn,
   setting ld_errno in the ld connection handle to indicate the error.
   It returns a pointer to malloc'ed space that the caller should free
   by calling free() when it is no longer in use.  Note the format of
   the DNs returned is given by [4].

   ldap_explode_dn() returns a char * array containing the RDN
   components of the DN supplied, with or without types as indicated by
   the notypes parameter. The array returned should be freed when it is
   no longer in use by calling ldap_value_free().

   ldap_dn2ufn() converts the DN into the user friendly format described
   in [5]. The UFN returned is malloc'ed space that should be freed by a
   call to free() when no longer in use.



Howes & Smith                Informational                     [Page 18]

RFC 1823                        LDAP API                     August 1995


# 9.  Security Considerations

   LDAP supports minimal security during connection authentication.

# 10.  Acknowledgements

   This material is based upon work supported by the National Science
   Foundation under Grant No. NCR-9416667.

# 11.  Bibliography

   [1] The Directory: Selected Attribute Syntaxes.  CCITT,
       Recommendation X.520.

   [2] Howes, T., Kille, S., Yeong, W., and C. Robbins, "The String
       Representation of Standard Attribute Syntaxes", University of
       Michigan, ISODE Consortium, Performance Systems International,
       NeXor Ltd., RFC 1778, March 1995.

   [3] Howes, T., "A String Representation of LDAP Search Filters", RFC
       1558, University of Michigan, December 1993.

   [4] Kille, S., "A String Representation of Distinguished Names", RFC
       1779, ISODE Consortium, March 1995.

   [5] Kille, S., "Using the OSI Directory to Achieve User Friendly
       Naming",  RFC 1781, ISODE Consortium, March 1995.

   [6] S.P. Miller, B.C. Neuman, J.I. Schiller, J.H. Saltzer, "Kerberos
       Authentication and Authorization System", MIT Project Athena
       Documentation Section  E.2.1, December 1987

   [7] Yeong, W., Howes, T., and S. Kille, "Lightweight Directory Access
       Protocol," RFC 1777, Performance Systems International,
       University of Michigan, ISODE Consortium, March 1995.


# 12.  Authors' Addresses

       Tim Howes
       University of Michigan
       ITD Research Systems
       535 W William St.
       Ann Arbor, MI 48103-4943
       USA
    
       Phone: +1 313 747-4454
       EMail: tim@umich.edu


       Mark Smith
       University of Michigan
       ITD Research Systems
       535 W William St.
       Ann Arbor, MI 48103-4943
       USA
    
       Phone: +1 313 764-2277
       EMail: mcs@umich.edu


# 13.  Appendix A - Sample LDAP API Code
```c
   #include <ldap.h>

   main()
   {
           LDAP            *ld;
           LDAPMessage     *res, *e;
           int             i;
           char            *a, *dn;
           void            *ptr;
           char            **vals;

           /* open a connection */
           if ( (ld = ldap_open( "dotted.host.name", LDAP_PORT )) == NULL )
                   exit( 1 );

           /* authenticate as nobody */
           if ( ldap_simple_bind_s( ld, NULL, NULL ) != LDAP_SUCCESS ) {
                   ldap_perror( ld, "ldap_simple_bind_s" );
                   exit( 1 );
           }

           /* search for entries with cn of "Babs Jensen",
                   return all attrs  */
           if ( ldap_search_s( ld, "o=University of Michigan, c=US",
               LDAP_SCOPE_SUBTREE, "(cn=Babs Jensen)", NULL, 0, &res )
               != LDAP_SUCCESS ) {
                   ldap_perror( ld, "ldap_search_s" );
                   exit( 1 );
           }

           /* step through each entry returned */
           for ( e = ldap_first_entry( ld, res ); e != NULL;
               e = ldap_next_entry( ld, e ) ) {
                   /* print its name */
                   dn = ldap_get_dn( ld, e );
                   printf( "dn: %s0, dn );
                   free( dn );

                   /* print each attribute */
                   for ( a = ldap_first_attribute( ld, e, &ptr );
                           a != NULL;
                       a = ldap_next_attribute( ld, e, ptr ) ) {
                           printf( "attribute: %s0, a );

                           /* print each value */
                           vals = ldap_get_values( ld, e, a );
                           for ( i = 0; vals[i] != NULL; i++ ) {
                                   printf( "value: %s0, vals[i] );
                           }
                           ldap_value_free( vals );
                   }
           }
           /* free the search results */
           ldap_msgfree( res );

           /* close and free connection resources */
           ldap_unbind( ld );
   }
```

Howes & Smith                Informational                     [Page 22]

