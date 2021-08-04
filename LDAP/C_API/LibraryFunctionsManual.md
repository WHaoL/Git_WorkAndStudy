

# [ldap_open(3)](https://www.openldap.org/software/man.cgi?query=ldap_open&sektion=3&apropos=0&manpath=OpenLDAP+2.1-Release)  (2.1版本的)      

open  a  connection  to an LDAP server (deprecated, use ldap_init(3))
打开到LDAP服务器的连接(已弃用，使用ldap_init(3))

ldap_init,ldap_open - Initialize the LDAP library and open a connection to an LDAP server
初始化LDAP库并连接到一个LDAP-server。

```c
       #include <ldap.h>

       LDAP *ldap_open(host, port)
       char *host;
       int port;

       LDAP *ldap_init(host, port)
       char *host;
       int port;
```

## 描述(!!!)
ldap_open() opens a connection to an LDAP server and allocates an  LDAP structure which is used to identify the connection and to maintain per-connection information.  ldap_init() allocates an  LDAP  structure  but does not open an initial connection.  One of these two routines must be called before any operations are attempted.
ldap_open()打开到LDAP-server的连接，并分配一个 用于标识连接和维护每个连接信息的LDAP结构体。
ldap_init()分配一个LDAP结构体，但不打开初始连接。
在尝试任何操作之前，必须调用这两个例程中的一个。

ldap_open() takes host, the  hostname  on  which  the  LDAP  server  is running, and port, the port number to which to connect.  If the default IANA-assigned port of 389 is desired, LDAP_PORT should be specified for port.   The  host parameter may contain a blank-separated list of hosts to try to connect to, and each host  may  optionally  by  of  the  form host:port.   If  present,  the  :port  overrides  the port parameter to ldap_open().  Upon successfully making a connection to an LDAP  server, ldap_open()  returns  a  pointer  to an LDAP structure (defined below), which  should  be  passed   to   subsequent   calls   to   ldap_bind(), ldap_search(),  etc. Certain fields in the LDAP structure can be set to indicate size limit, time limit, and how  aliases  are  handled  during operations.  See <ldap.h> for more details.
ldap_open()接受host(运行LDAP-server的主机名)和port(要连接到的端口号)。
        如果需要使用IANA分配的默认端口389，则应该为端口指定LDAP_PORT。
        host参数可以包含一个 以空白分隔的主机列表 来尝试连接，并且每个主机可以选择使用host:port的形式。
        如果存在，:port将覆盖ldap_open()的端口参数。
在成功地建立到LDAP-server的连接后，ldap_open()返回一个指向LDAP结构体(定义如下)的指针，该指针应该传递给 对ldap_bind()、ldap_search()等的后续调用。
可以设置LDAP结构体中的某些字段，以指示大小限制、时间限制以及操作期间如何处理别名。
有关更多细节请参阅<ldap.h>。

```c
            typedef struct ldap {
                 /* ... other stuff you should not mess with ... */
                 char      ld_lberoptions;
                 int       ld_deref;
            #define LDAP_DEREF_NEVER 0          // never
            #define LDAP_DEREF_SEARCHING  1     // searching
            #define LDAP_DEREF_FINDING    2     // finding
            #define LDAP_DEREF_ALWAYS     3     // always
                 int       ld_timelimit;        // 时间限制
                 int       ld_sizelimit;        // 大小限制
            #define LDAP_NO_LIMIT         0     // 不限制
                 int       ld_errno;        //错误号码errno
                 char      *ld_error;       //错误信息
                 char      *ld_matched;     
                 int       ld_refhoplimit;
                 unsigned long  ld_options;
            #define LDAP_OPT_REFERRALS      0x00000002   /* set by default */   // referrals
            #define LDAP_OPT_RESTART 0x00000004                                 // restart
                 /* ... other stuff you should not mess with ... */ 
                 // 还有一些你不应该碰的东西
            } LDAP;
```
ldap_init()  acts just like ldap_open(), but does not open a connection to the LDAP server.  The actual connection open  will  occur  when  the first  operation is attempted.  At this time, ldap_init() is preferred. ldap_open() will be depreciated in a later release.
ldap_init()的作用与ldap_open()类似，但不打开到LDAP服务器的连接。
    实际打开连接 将在尝试第一个操作时发生。
        此时，首选ldap_init()。ldap_open()将在以后的版本中贬值。

## ERRORS
If an error occurs, these routines will return NULL and errno should be set appropriately.
如果出错，返回NULL 并 设置errno

## OPTIONS(!!!)
Options  that affect a particular LDAP instance may be set by modifying the ld_options field in the LDAP  structure.   This  field  is  set  to LDAP_OPT_REFERRALS  in  ldap_open()  and  ldap_init(), which causes the library to automatically follow referrals to other servers that may  be returned in response to an LDAP operation.
可以通过修改LDAP结构体中的ld_options字段，来设置影响特定LDAP实例的选项。
在ldap_open()和ldap_init()中，该字段被设置为LDAP_OPT_REFERRALS，这将导致库自动跟踪对其他服务器的引用，这些服务器可能在响应LDAP操作时返回。

The other supported option is LDAP_OPT_RESTART, which if set will cause the LDAP library to restart  the  select(2)  system  call  when  it  is interrupted  by  the system (i.e., errno is set to EINTR).  This option is not supported on the Macintosh and under MS-DOS.
另一个支持的选项是LDAP_OPT_RESTART，如果设置该选项，将导致LDAP库在被系统中断时重新启动select(2)系统调用(即，将errno设置为EINTR)。
在Macintosh和MS-DOS下不支持此选项。

An option can be turned off by clearing  the  appropriate  bit  in  the ld_options field.
可以通过清除ld_options字段中的适当位来关闭某个选项。

## NOTES
There  are  other  elements  in  the LDAP structure that you should not change. You should not make any assumptions about the order of elements in the LDAP structure.
LDAP结构体中还有其他元素不应该更改。
您不应该对LDAP结构体中元素的顺序做任何假设。

## SEE ALSO(另请参阅)
ldap(3), ldap_bind(3), errno(3)




# ldap_init(3) (2.1版本的)
见 ldap_open(3)部分





# 1. [ldap_open(3)](https://www.openldap.org/software/man.cgi?query=ldap_open&apropos=0&sektion=3&manpath=OpenLDAP+2.4-Release&arch=default&format=html)(2.4版本) (ldap_init,ldap_initialize,ldap_open)

## NAME
ldap_init(), ldap_initialize(), ldap_open() 
    Initialize the LDAP library and open a connection to an LDAP server
    初始化LDAP库并打开到LDAP服务器的连接

## LIBRARY
       OpenLDAP LDAP (libldap, -lldap)

## SYNOPSIS
```c
       #include <ldap.h>

       LDAP *ldap_open(host, port)
       char *host;
       int port;

       LDAP *ldap_init(host, port)
       char *host;
       int port;

       int ldap_initialize(ldp, uri)
       LDAP **ldp;
       char *uri;

       int ldap_set_urllist_proc(ld, proc, params)
       LDAP *ld;
       LDAP_URLLIST_PROC *proc;
       void *params;

       int (LDAP_URLLIST_PROC)(ld, urllist, url, params);
       LDAP *ld;
       LDAPURLDesc **urllist;
       LDAPURLDesc **url;
       void *params;

       #include <openldap.h>

       int ldap_init_fd(fd, proto, uri, ldp)
       ber_socket_t fd;
       int proto;
       char *uri;
       LDAP **ldp;
```

## DESCRIPTION
ldap_open() opens a connection to an LDAP server and allocates an  LDAP structure which is used to identify the connection and to maintain per-connection information.  ldap_init() allocates an  LDAP  structure  but does  not  open  an initial connection.  ldap_initialize() allocates an LDAP structure but does not open an initial connection.  ldap_init_fd() allocates  an  LDAP  structure  using  an  existing  connection  on the provided socket.  One of these  routines  must  be  called  before  any operations are attempted.
ldap_open()打开到LDAP服务器的连接，并分配一个 用于标识连接和维护每个连接信息的LDAP结构体。
ldap_init()分配一个LDAP结构体，但不打开初始连接。
ldap_initialize()分配一个LDAP结构体，但不打开初始连接。
ldap_init_fd()使用 提供的套接字上的 现有连接分配LDAP结构体。
在尝试任何操作之前，必须调用其中一个例程。

ldap_open()  takes  host,  the  hostname  on  which  the LDAP server is running, and port, the port number to which to connect.  If the default IANA-assigned port of 389 is desired, LDAP_PORT should be specified for port.  The host parameter may contain a blank-separated list  of  hosts to  try  to  connect  to,  and  each host may optionally by of the form host:port.  If present, the  :port  overrides  the  port  parameter  to ldap_open().   Upon successfully making a connection to an LDAP server, ldap_open() returns a pointer to an opaque LDAP structure, which should be  passed  to  subsequent  calls  to  ldap_bind(), ldap_search(), etc. Certain fields in the LDAP structure can be set to indicate size limit, time  limit,  and  how  aliases are handled during operations; read and write access to those fields must occur by  calling  ldap_get_option(3) and ldap_set_option(3) respectively, whenever possible.
ldap_open()接受host(运行LDAP服务器的主机名)和port(要连接到的端口号)。
        如果需要使用IANA分配的默认端口389，则应该为端口指定LDAP_PORT。
        host参数可以包含一个以空白分隔的主机列表来尝试连接，并且每个主机可以选择使用host:port的形式。
                如果存在，:port将覆盖ldap_open()的端口参数。
在成功地建立到LDAP服务器的连接后，ldap_open()返回一个指向不透明LDAP结构的指针，
        该指针应该被传递给 对ldap_bind()、ldap_search()等的后续调用。
可以设置LDAP结构体中的某些字段，以指示大小限制、时间限制以及操作期间如何处理别名;
        只要可能，对这些字段的读写访问必须通过分别调用ldap_get_option(3)和ldap_set_option(3)实现。

ldap_init()  acts just like ldap_open(), but does not open a connection to the LDAP server.  The actual connection open  will  occur  when  the first operation is attempted.
ldap_init()的作用与ldap_open()类似，但不打开到LDAP服务器的连接。
实际打开连接 将在尝试第一个操作时发生。

ldap_initialize()  acts  like  ldap_init(),  but  it returns an integer indicating either success or the  failure  reason,  and  it  allows  to specify  details  for  the connection in the schema portion of the URI. The uri parameter may be a comma- or whitespace-separated list of  URIs containing  only the schema, the host, and the port fields.  Apart from ldap, other (non-standard) recognized values of the  schema  field  are ldaps (LDAP over TLS), ldapi (LDAP over IPC), and cldap (connectionless LDAP).  If other fields are present, the behavior is undefined.
ldap_initialize()类似于ldap_init()，
        但是它返回一个整数，指示成功或失败的原因，
        并且它允许在URI的schema部分中指定连接的详细信息。
uri参数可以是一个逗号或空格分隔的uri列表，其中只包含schema、host和port字段。
除了ldap之外，schema字段的其他(非标准)可识别值是ldaps(基于TLS的ldap)、ldapi(基于IPC的ldap)和cldap(无连接ldap)。
    总结：即schema字段可能的取值是： ldap  ldaps ldapi cldap
如果存在其他字段，则未定义该行为。

At this time, ldap_open() and ldap_init() are deprecated  in  favor  of ldap_initialize(),  essentially  because the latter allows to specify a schema in the URI and it explicitly returns an error code.
此时，ldap_open()和ldap_init()已弃用，
        而赞成ldap_initialize()，
        这主要是因为后者允许在URI中指定schema，并显式返回错误代码。

ldap_init_fd() allows an LDAP structure  to  be  initialized  using  an already-opened  connection.  The  proto  parameter  should  be  one  of LDAP_PROTO_TCP, LDAP_PROTO_UDP,  or  LDAP_PROTO_IPC  for  a  connection using TCP, UDP, or IPC, respectively. The value LDAP_PROTO_EXT may also be specified if user-supplied sockbuf handlers are going  to  be  used. Note  that  support for UDP is not implemented unless libldap was built with LDAP_CONNECTIONLESS defined.  The uri parameter may optionally  be provided for informational purposes.
ldap_init_fd()
        允许使用已经打开的连接初始化LDAP结构体。
        对于使用TCP、UDP或IPC的连接，proto参数应该分别为LDAP_PROTO_TCP、LDAP_PROTO_UDP或LDAP_PROTO_IPC之一。
            如果要使用用户提供的sockbuf处理程序，还可以指定值LDAP_PROTO_EXT。
        注意，除非libdap是用定义的LDAP_CONNECTIONLESS构建的，否则不会实现对UDP的支持。
        出于信息目的，可以选择提供uri参数。

ldap_set_urllist_proc()   allows   to  set  a  function  proc  of  type LDAP_URLLIST_PROC that is called when a successful  connection  can  be established.   This  function receives the list of URIs parsed from the uri string originally passed to ldap_initialize(),  and  the  one  that successfully  connected.  The function may manipulate the URI list; the typical use consists in moving the successful URI to the  head  of  the list,  so  that subsequent attempts to connect to one of the URIs using the same LDAP handle will try it first.  If ld is null, proc is set  as a global parameter that is inherited by all handlers within the process that  are  created  after  the  call  to  ldap_set_urllist_proc().   By default,  no LDAP_URLLIST_PROC is set.  In a multithreaded environment, ldap_set_urllist_proc() must be called before any concurrent  operation using the LDAP handle is started.
ldap_set_urllist_proc()
        允许设置一个类型为LDAP_URLLIST_PROC的函数指针proc，该函数指针proc在可以成功/success建立连接时被调用。
            这个函数接收 从 最初传递给ldap_initialize()的uri字符串 和 成功连接的uri字符串 解析出的URI列表。
            该函数可以操作URI列表;
                典型的用法是将success的URI移动到列表的头部，以便后续使用相同LDAP句柄 连接URI的尝试 首先尝试它。
        如果ld为空，则将proc设置为一个全局参数，该参数由调用ldap_set_urllist_proc()之后创建的进程中的所有处理程序继承。
        默认情况下，没有设置LDAP_URLLIST_PROC。
在多线程环境中，必须在启动使用LDAP句柄的任何并发操作之前调用ldap_set_urllist_proc()。

Note:  the first call into the LDAP library also initializes the global options for the library. As such  the  first  call  should  be  single-threaded or otherwise protected to insure that only one call is active. It is recommended that ldap_get_option() or ldap_set_option()  be  used in the program's main thread before any additional threads are created. See ldap_get_option(3).
注意:对LDAP库的第一次调用也初始化该库的全局选项。
因此，第一个调用应该是单线程的，或者以其他方式保护，以确保只有一个调用是活动的。
建议在创建任何其他线程之前，在程序的主线程中使用ldap_get_option()或ldap_set_option()。
参阅ldap_get_option(3)。

## ERRORS
If an error occurs, ldap_open() and ldap_init() will  return  NULL  and errno    should    be   set   appropriately.    ldap_initialize()   and ldap_init_fd() will directly return the LDAP  code  associated  to  the error (or LDAP_SUCCESS in case of success); errno should be set as well whenever appropriate.  ldap_set_urllist_proc()  returns  LDAP_OPT_ERROR on error, and LDAP_OPT_SUCCESS on success.
如果发生错误，
        ldap_open()和ldap_init()将返回NULL，并且应该适当设置errno。
        ldap_initialize()和ldap_init_fd()将直接返回与错误相关的LDAP代码(如果成功则返回LDAP_SUCCESS);也应该在适当的时候设置Errno。
        ldap_set_urllist_proc()在出错时返回LDAP_OPT_ERROR，在成功时返回LDAP_OPT_SUCCESS。



## SEE ALSO
ldap(3),  ldap_bind(3),  ldap_get_option(3),  ldap_set_option(3), lber-sockbuf(3), errno(3)

## ACKNOWLEDGEMENTS
OpenLDAP Software is developed and maintained by The  OpenLDAP  Project<http://www.openldap.org/>.   OpenLDAP  Software  is  derived  from the University of Michigan LDAP 3.3 Release.

OpenLDAP 2.4.59                   
2021/06/03                      
LDAP_OPEN(3)

## 补充

### ldap_open_defconn()
```c
/* Caller must hold the conn_mutex since simultaneous accesses are possible */
// 调用者 必须持有conn_mutex,因为可能会同时访问(形成竞争...)
int ldap_open_defconn( LDAP *ld )
{
	ld->ld_defconn = ldap_new_connection( ld,
		&ld->ld_options.ldo_defludp, 1, 1, NULL, 0, 0 );

	if( ld->ld_defconn == NULL ) {
		ld->ld_errno = LDAP_SERVER_DOWN;
		return -1;
	}

	++ld->ld_defconn->lconn_refcnt;	/* so it never gets closed/freed */
	return 0;
}
```

### ldap_open()
```c
/*
 * ldap_open - initialize and connect to an ldap server.  A magic cookie to
 * be used for future communication is returned on success, NULL on failure.
 * "host" may be a space-separated list of hosts or IP addresses
 *
 * Example:
 *	LDAP	*ld;
 *	ld = ldap_open( hostname, port );
 */

LDAP *
ldap_open( LDAP_CONST char *host, int port )
{
	int rc;
	LDAP		*ld;                    // 用于标识连接和维护连接信息

	Debug( LDAP_DEBUG_TRACE, "ldap_open(%s, %d)\n",
		host, port, 0 );

	ld = ldap_init( host, port );       //  初始化 struct ldap
	if ( ld == NULL ) {
		return( NULL );
	}

	LDAP_MUTEX_LOCK( &ld->ld_conn_mutex );      //加锁
	rc = ldap_open_defconn( ld );               // 连接
	LDAP_MUTEX_UNLOCK( &ld->ld_conn_mutex );    //解锁

	if( rc < 0 ) {
		ldap_ld_free( ld, 0, NULL, NULL );
		ld = NULL;
	}

	Debug( LDAP_DEBUG_TRACE, "ldap_open: %s\n",
		ld != NULL ? "succeeded" : "failed", 0, 0 );

	return ld;
}
```



### struct ldap

```c
struct ldap {
	/* thread shared */
	struct ldap_common	*ldc; //代表了一个ldap connection

	/* thread specific */
	ber_int_t		ld_errno;
	char			*ld_error;
	char			*ld_matched;
	char			**ld_referrals;
};
```