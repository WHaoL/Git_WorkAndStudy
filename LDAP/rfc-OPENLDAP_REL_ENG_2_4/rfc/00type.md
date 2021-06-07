@[TOC](目录)






```cpp
/*

	着重理清LDAP协议和OpenLDAP 数据类型的对应关系，以及数据的走向，框架中的数据的组织形式

	第一遍看 协议 和 源码中的数据类型的定义/格式 
	
	第二遍 看数据的分配/操作/流向

	第三遍 看数据的流向/框架的数据和模块的组织
*/
```

# 1. LDAP协议定义的数据类型

## 1.1 common elements 

```txt

RFC 4511	4.1. Common Elements

		------------------------------------
		LDAPMessage
			使用LDAP协议 交换数据时，公共信息 封装在 LDAPMessage中；


			LDAPMessage ::= SEQUENCE {                      -- 序列
				messageID       MessageID,                     -- 消息ID -- messageID
				protocolOp      CHOICE {                       -- 执行什么操作
					bindRequest           BindRequest,
					bindResponse          BindResponse,
					unbindRequest         UnbindRequest,
					searchRequest         SearchRequest,
					searchResEntry        SearchResultEntry,
					searchResDone         SearchResultDone,
					searchResRef          SearchResultReference,
					modifyRequest         ModifyRequest,
					modifyResponse        ModifyResponse,
					addRequest            AddRequest,
					addResponse           AddResponse,
					delRequest            DelRequest,
					delResponse           DelResponse,
					modDNRequest          ModifyDNRequest,
					modDNResponse         ModifyDNResponse,
					compareRequest        CompareRequest,
					compareResponse       CompareResponse,
					abandonRequest        AbandonRequest,
					extendedReq           ExtendedRequest,
					extendedResp          ExtendedResponse,
					...,
					intermediateResponse  IntermediateResponse },
				controls       [0] Controls OPTIONAL }           -- 控件
		
			MessageID ::= INTEGER (0 ..  maxInt) 
			maxInt INTEGER ::= 2147483647 -- (2^^31 - 1)  

			MessageID：
				非0整数；
				同一会话中不可重复；
				0是 留给通知消息的；
				client发送的消息里携带，(对于同一个client)server回复消息时携带同样的messageID。
		------------------------------------
		String Types：
			LDAPString是一种字符串；
			编码为OCTET STRING。
				LDAPString ::= OCTET STRING -- UTF-8 encoded,
											-- [ISO10646] characters
		------------------------------------
		LDAPOID： 
			点分十进制字符串；
			编码为OCTET STRING；
			取值范围是： [RFC4512]的第1.4节中给出的<numericoid>定义。
		------------------------------------
			LDAPDN: 
				代表/表示 DN；
				是LDAPString字符串。

				LDAPDN ::= LDAPString
						-- Constrained to <distinguishedName> [RFC4514]		

			RelativeLDAPDN：
				代表/表示 RDN；
				是LDAPString字符串。

				RelativeLDAPDN ::= LDAPString
                           		   -- Constrained to <name-component> [RFC4514]
		------------------------------------
			AttributeDescription：
				是 LDAPString字符串；
				包含一个attribute type 和 0个或多个options。

				AttributeDescription ::= LDAPString
										-- Constrained to <attributedescription>
										-- [RFC4512]				
		------------------------------------
			AttributeValue：
				值是，OCTET STRING格式的字符串，包含了一个编码后的属性值；
				大小没有限制；
				client只能在请求中发送有效的属性值。

				AttributeValue ::= OCTET STRING
		------------------------------------
			AttributeValueAssertion： 
				包含 属性描述 和 断言值的匹配规则
				断言值的语法 取决于上下文

				AttributeValueAssertion ::= SEQUENCE {
					attributeDesc   AttributeDescription, --属性描述
					assertionValue  AssertionValue }      -- 断言值
				AssertionValue ::= OCTET STRING		      -- 断言值 编码为 OCTET STRING

		------------------------------------
			Attributes：
				组成部分： 一个attribute description，多个attribute values(是无序的)
				至少需要一个值
			PartialAttribute
				组成部分： 一个attribute description，多个attribute values(是无序的)
				允许0个值


				PartialAttribute ::= SEQUENCE {
					type       AttributeDescription,
					vals       SET OF value AttributeValue }
				Attribute ::= PartialAttribute(WITH COMPONENTS {
					...,
					vals (SIZE(1..MAX))})
		------------------------------------
			MatchingRuleId：
				取值： 短名称 或 <numericoid>(点分十进制字符串)
				例如，“caseIgnoreMatch”或“2.5.13.2”。

        		MatchingRuleId ::= LDAPString
		------------------------------------
		LDAPResult： 
			server回复给client；
			指示了对client请求的处理状态；

				LDAPResult ::= SEQUENCE {
					resultCode         ENUMERATED {                -- 1. 返回码 (从枚举值中选择一个)
						success                      (0),
						operationsError              (1),
						protocolError                (2),
						timeLimitExceeded            (3),
						sizeLimitExceeded            (4),
						compareFalse                 (5),
						compareTrue                  (6),
						authMethodNotSupported       (7),
						strongerAuthRequired         (8), #
							-- 9 reserved --
						referral                     (10),
						adminLimitExceeded           (11),
						unavailableCriticalExtension (12), #不可用的关键扩展
						confidentialityRequired      (13), #需要保密
						saslBindInProgress           (14),
						noSuchAttribute              (16),
						undefinedAttributeType       (17),
						inappropriateMatching        (18),
						constraintViolation          (19), #违反约束
						attributeOrValueExists       (20),
						invalidAttributeSyntax       (21),
							-- 22-31 unused --
						noSuchObject                 (32),
						aliasProblem                 (33), #别名问题
						invalidDNSyntax              (34),
							-- 35 reserved for undefined isLeaf --
						aliasDereferencingProblem    (36), #别名解除引用问题
							-- 37-47 unused --
						inappropriateAuthentication  (48), #不适当的认证
						invalidCredentials           (49), #无效证书
						insufficientAccessRights     (50), #访问权限不足
						busy                         (51),
						unavailable                  (52),
						unwillingToPerform           (53),
						loopDetect                   (54), #循环检测
							-- 55-63 unused --
						namingViolation              (64), #命名违规
						objectClassViolation         (65),
						notAllowedOnNonLeaf          (66), #不允许在非叶子上
						notAllowedOnRDN              (67),
						entryAlreadyExists           (68),
						objectClassModsProhibited    (69), #禁止...
							-- 70 reserved for CLDAP --
						affectsMultipleDSAs          (71), #影响多个DSA
							-- 72-79 unused --
						other                        (80),
						...  },
					matchedDN          LDAPDN,                 #   -- 2. 匹配的DN
					diagnosticMessage  LDAPString,             #   -- 3. 错误信息 即errorMessage
					referral           [3] Referral OPTIONAL } #   -- 4. 引用(URI)
				
				参看： 
					/OPENLDAP_REL_ENG_2_4/libraries/libldap/error.c
					中的  * Parse LDAPResult Messages:
			
			对LDAPResult的各个字段的说明： 
				resultCode/结果码， 
					是个枚举，
					对于一个操作的多个错误，只返回一个resultCode
					server只返回 最能代表错误性质的 resultCode
				diagnosticMessage/诊断信息 ，
					(即errorMessage)
					用于补充resultCode
					是个文本字符串
				matchedDN
					matchedDN的值 由服务器/server返回；
					对于结果代码/resultCode为： noSuchObject、aliasProblem、invalidDNSyntax、aliasDereferencingProblem
						的消息/message，
						服务器返回DIT中，可以为此操作找到的 最深的条目的DN
						(即：所查找对象的 最后一个条目的名称)
					参看：
						/OPENLDAP_REL_ENG_2_4/contrib/ldapc++/src/LDAPResult.h 
						的const std::string& getMatchedDN() const;
				referral
					当LDAPResult.resultCode=referral时，
					LDAPResult.referral中必须包含至少一个URI，用以指示 其他的ldap-server可以处理client的请求；
					client会连接referral中的URI，以继续执行操作；
						不可以使用(!!!) 相同参数的相同请求 去 重复连接同一服务器/server

					Referral ::= SEQUENCE SIZE (1..MAX) OF uri URI
					URI ::= LDAPString     -- limited to characters permitted in
										-- URIs

					实现了LDAP 并可以通过TCP/IP访问的server，
						此server的URI被写为LDAP URL
					referral的值是LDAP URLs时 遵循以下规则：   [RFC 4511 的 4.1.10.  Referral]
						dn
							如果别名被解引用，LDAP URL的<dn>部分必须存在，并带有新的目标对象名称；
        					建议使用<dn>部分，以避免歧义；
							如果 <dn> 部分存在，则client在其下一个请求中使用此名称来进行操作 ；
        				filter
							某些服务器（例如，参与分布式索引）可能会在搜索操作的referral URL 中提供不同的过滤器；
							如果LDAP URL存在<filter>部分，则客户端在其下一个请求中使用此过滤器来进行此搜索；
						scope
        					对于搜索，建议存在<scope>部分，以避免歧义；
							如果缺少 <scope> 部分，客户端将使用原始搜索的范围来进行操作；
		------------------------------------
			Controls/控件
				用在何处： 附加到LDAPMessage.Controls=Controls'sName；
				功能：    扩展现有LDAP操作的语义和参数；
				一个或多个控件可以附加到单个 LDAPmessage;
				只影响 附加到的LDAPMessage的...			

				client发送的 control称为 “(request controls)请求控件”
				server 发送的 control 称为“(response controls)响应控件”

					Controls ::= SEQUENCE OF control Control
					Control ::= SEQUENCE {
						controlType             LDAPOID,                   #control的OID
						criticality             BOOLEAN DEFAULT FALSE,     #布尔值，默认false
						controlValue            OCTET STRING OPTIONAL }		

					Control的 controlType 字段						
						是control的OID表示
						点分十进制 
						request control对应的 response control 共享controlType的值
					Control的 criticality 字段
						仅当control附到request message(UnbindRequest除外)时，此字段才有意义，
							即：LDAPMessage.protocolOp=xxxRequest时；
						当control附到response message和UnbindRequest时，此字段应设置为FALSE，接收方应忽略这个字段
						当此字段设置为TRUE时，表明：
							必须使用control才能执行操作
				
						如果server 
							识别不了control的类型，或者 不愿意使用control执行操作，
							并且 criticality字段为TRUE，
								则server 无法执行操作 
							并且server 在response message中 将resultCode设置为unavailableCriticalExtension
						如果server 
							识别不了control的类型，或者 不愿意使用control执行操作，
							并且 criticality字段为FALSE，
								则server忽略control
					Control的 controlValue 字段
						包含了与controlType相关的信息
						值是 OCTET STRING，可能是0字节
				
				server在
					root DSE([RFC4512]的第5.1节)的 "supportedControl"的属性中 列出了
					它/server 识别的 request control的controlType
				
				control的定义
					control的OID
					...
		------------------------------------

```

## 1.2 Bind Operation
```txt
RFC 4511	4.2. Bind Operation
	
	------------------------------------
	Bind Operation
		主要用于交换 身份验证/认证信息

        BindRequest ::= [APPLICATION 0] SEQUENCE {
             version                 INTEGER (1 ..  127),      #版本号 -- (整数)
             name                    LDAPDN,                   #DN 
             authentication          AuthenticationChoice }    #选择 认证 的方式
        AuthenticationChoice ::= CHOICE {
             simple                  [0] OCTET STRING,            #简单认证
                                     -- 1 and 2 reserved 
             sasl                    [3] SaslCredentials,         #SASL认证
             ...  }
        SaslCredentials ::= SEQUENCE {                            #SASL认证
             mechanism               LDAPString,                     #指定一个字符串，代表了 一种机制
             credentials             OCTET STRING OPTIONAL }         #证书，以 OCTET STRING编码

		BindRequest各个字段：
			version
				指示 要在LDAP message layer上使用的协议的版本
				client指出它所需要的版本
				如果server不支持指定的版本，
					那么使用BindResponse响应，
					并且 resultCode设置为了 protocolError
			name 
				匿名绑定/SASL认证 时，name可能为null值
				不为空，则为client希望绑定到的name/DN
         		当server试图定位name/DN 时， 不应该 解引用
      			client 用于 指出 它希望绑定到的DN (!!!)
			authentication
				此类型可以扩展；
				client用于指定验证机制
				如果server不支持这种验证机制，
					使用BindResponse响应
					并将resultCode 设置为 authMethodNotSupported
				若是指定为simple
					那么传输到server的秘密是明文 使用UTF-8编码
	------------------------------------
	
	------------------------------------
	------------------------------------
	------------------------------------
	------------------------------------
	------------------------------------
	------------------------------------
```
### 1.2.1 Bind Request 
```txt
		------------------------------------
		------------------------------------
		------------------------------------
```
### 1.2.2 Bind Response 
```txt
		------------------------------------
		------------------------------------
		------------------------------------
```

# 2. OpenLDAP源码的数据类型

## 2.1 LDAPMessage
```cpp
// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/include/ldap.h
/*
 * This structure represents both ldap messages and ldap responses.
 * These are really the same, except in the case of search responses,
 * where a response has multiple messages.
 */
typedef struct ldapmsg LDAPMessage;

// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/libldap/ldap-int.h
/*
 * This structure represents both ldap messages and ldap responses.
 * These are really the same, except in the case of search responses,
 * where a response has multiple messages.
 */
struct ldapmsg {
	ber_int_t		lm_msgid;	/* the message id */  
	ber_tag_t		lm_msgtype;	/* the message type */ 						//似乎是unsigned long
	BerElement		*lm_ber;	/* the ber encoded message contents */
	struct ldapmsg	*lm_chain;	/* for search - next msg in the resp */
	struct ldapmsg	*lm_chain_tail;
	struct ldapmsg	*lm_next;	/* next response */
	time_t			lm_time;	/* used to maintain cache */
};
```

### 2.1.1 - LDAPMessage中的BerElement
```cpp
// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/include/lber.h
typedef struct berelement BerElement;

// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/liblber/lber-int.h 
/* Data encoded in ASN.1 BER format */
struct berelement {
	struct		lber_options ber_opts;
#define ber_valid		ber_opts.lbo_valid
#define ber_options		ber_opts.lbo_options
#define ber_debug		ber_opts.lbo_debug

	/*
	 * The members below, when not NULL/LBER_DEFAULT/etc, are:
	 *   ber_buf       Data buffer.  Other pointers normally point into it. //BER数据的buffer，其他指针通常指向这个buffer
	 *   ber_rwptr     Read/write cursor for Sockbuf I/O.					//为Sockbuf I/O定义的 读写指针
	 *   ber_memctx    Context passed to ber_memalloc() & co.				//上下文传递给 ber_memalloc() & co
	 * When decoding data (reading it from the BerElement):				//--从BerElement对象读取数据
	 *   ber_end       End of BER data.									//	--BER数据的尾部
	 *   ber_ptr       Read cursor, except for 1st octet of tags.		// 	--读指针，除了tag的第一个8位
	 *   ber_tag       1st octet of next tag, saved from *ber_ptr when  //	--下一个tag的第一个8位字节，当 ber_ptr指向一个tag  并且 >ber_buf ， 从ber_buf保存。
	 *                 ber_ptr may be pointing at a tag and is >ber_buf.//    --
	 *                 The octet *ber_ptr itself may get overwritten with//   --8位字节 *ber_ptr本身可能被 '\0'覆盖 ，用于终止全面的元素
	 *                 a \0, to terminate the preceding element.        //
	 * When encoding data (writing it to the BerElement):				//--向BerElement对象写入数据
	 *   ber_end       End of allocated buffer - 1 (allowing a final \0).//		分配的buffer的尾部 (大小是buffer-1 ， 以'\0'结尾)，
	 *   ber_ptr       Last complete BER element (normally write cursor).
	 *   ber_sos_ptr   NULL or write cursor for incomplete sequence or set.
	 *   ber_sos_inner offset(seq/set length octets) if ber_sos_ptr!=NULL.
	 *   ber_tag       Default tag for next ber_printf() element.
	 *   ber_usertag   Boolean set by ber_printf "!" if it sets ber_tag.
	 *   ber_len       Reused for ber_sos_inner.
	 * When output to a Sockbuf:
	 *   ber_ptr       End of encoded data to write.
	 * When input from a Sockbuf:
	 *   See ber_get_next().
	 */

	/* Do not change the order of these 3 fields! see ber_get_next */
	ber_tag_t	ber_tag;
	ber_len_t	ber_len;
	ber_tag_t	ber_usertag;

	char		*ber_buf;	
	char		*ber_ptr;	
	char		*ber_end;	

	char		*ber_sos_ptr;
#	define		ber_sos_inner	ber_len /* reused for binary compat */

	char		*ber_rwptr;	
	void		*ber_memctx;
};

// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/liblber/lber-int.h
struct lber_options {
	short 				lbo_valid;
	unsigned short		lbo_options;
	int					lbo_debug;
};


```

#### 2.1.1.1 - LBER_CALLOC 为 BerElement分配内存
```cpp

// 分配一个 BerElement类型的 内存
// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/liblber/io.c
BerElement *
ber_alloc_t( int options )
{
	BerElement	*ber;

	ber = (BerElement *) LBER_CALLOC( 1, sizeof(BerElement) );

	if ( ber == NULL ) {
		return NULL;
	}

	ber->ber_valid = LBER_VALID_BERELEMENT; // 有效的BER元素/element
	ber->ber_tag = LBER_DEFAULT;			// tag使用BER的默认值   默认值是-1
	ber->ber_options = options;				// 
	ber->ber_debug = ber_int_debug;			// 

	assert( LBER_VALID( ber ) );
	return ber;
}


// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/liblber/lber-int.h
#define LBER_CALLOC(n,s)	ber_memcalloc((n),(s))

// /home/gos/workspace/src_OPENLDAP_REL_ENG_2_4/libraries/liblber/memory.c
void *
ber_memcalloc( ber_len_t n, ber_len_t s )
{
	return ber_memcalloc_x( n, s, NULL );
}
void *
ber_memrealloc_x( void* p, ber_len_t s, void *ctx ) //这个函数先不看
{
	void *new = NULL;

	/* realloc(NULL,s) -> malloc(s) */
	if( p == NULL ) {
		return ber_memalloc_x( s, ctx );
	}
	
	/* realloc(p,0) -> free(p) */
	if( s == 0 ) {
		ber_memfree_x( p, ctx );
		return NULL;
	}

	BER_MEM_VALID( p );

	if( ber_int_memory_fns == NULL || ctx == NULL ) {
#ifdef LDAP_MEMORY_DEBUG
		ber_int_t oldlen;
		struct ber_mem_hdr *mh = (struct ber_mem_hdr *)
			((char *)p - sizeof(struct ber_mem_hdr));
		assert( mh->bm_top == LBER_MEM_JUNK);
		assert( testdatatop( mh));
		assert( testend( (char *)&mh[1] + mh->bm_length) );
		oldlen = mh->bm_length;

		p = realloc( mh, s + sizeof(struct ber_mem_hdr) + sizeof(ber_int_t) );
		if( p == NULL ) {
			ber_errno = LBER_ERROR_MEMORY;
			return NULL;
		}

			mh = p;
		mh->bm_length = s;
		setend( (char *)&mh[1] + mh->bm_length );
		if( s > oldlen ) {
			/* poison any new memory */
			memset( (char *)&mh[1] + oldlen, 0xff, s - oldlen);
		}

		assert( mh->bm_top == LBER_MEM_JUNK);
		assert( testdatatop( mh));

		ber_int_meminuse += s - oldlen;
#ifdef LDAP_MEMORY_TRACE
		fprintf(stderr, "0x%08lx 0x%08lx -a- %ld ber_memrealloc %ld\n",
			(long)mh->bm_sequence, (long)mh, (long)mh->bm_length,
			ber_int_meminuse);
#endif
			BER_MEM_VALID( &mh[1] );
		return &mh[1];
#else
		new = realloc( p, s );
#endif
	} else {
		new = (*ber_int_memory_fns->bmf_realloc)( p, s, ctx );
	}

	if( new == NULL ) {
		ber_errno = LBER_ERROR_MEMORY;
	}

	return new;
}
```


```cpp

```


```cpp

```



```cpp

```
