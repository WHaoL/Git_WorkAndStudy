@[TOC](目录)






```cpp
/*

	着重理清LDAP协议和OpenLDAP 数据类型的对应关系，以及数据的走向，框架中的数据的组织形式

	第一遍看 协议 和 源码中的数据类型的定义/格式 
	
	第二遍 看数据的分配/操作/流向

	第三遍 看数据的流向/框架的数据和模块的组织
*/
```


```bash

Table of Contents

   1. Introduction ....................................................3
      1.1. Relationship to Other LDAP Specifications ..................3
   2. Conventions .....................................................3
   3. Protocol Model ..................................................4
      3.1. Operation and LDAP Message Layer Relationship ..............5 操作和LDAP消息层 的关系
   4. Elements of Protocol ............................................5
      4.1. Common Elements ............................................5
           4.1.1. Message Envelope ....................................6 消息/信息封装
           4.1.2. String Types ........................................7 字符串类型
           4.1.3. Distinguished Name and Relative Distinguished Name ..8 DN和RDN
           4.1.4. Attribute Descriptions ..............................8 属性描述
           4.1.5. Attribute Value .....................................8 属性值
           4.1.6. Attribute Value Assertion ...........................9 属性值断言
           4.1.7. Attribute and PartialAttribute ......................9 属性和部分属性
           4.1.8. Matching Rule Identifier ...........................10 匹配规则标识符
           4.1.9. Result Message .....................................10 结果信息
           4.1.10. Referral ..........................................12 引用/转介
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                     [Page 1]

RFC 4511                         LDAPv3                        June 2006


           4.1.11. Controls ..........................................14 控件
      4.2. Bind Operation ............................................16 绑定操作
           4.2.1. Processing of the Bind Request .....................17 对绑定请求的处理
           4.2.2. Bind Response ......................................18 绑定响应
      4.3. Unbind Operation ..........................................18 解绑操作
      4.4. Unsolicited Notification ..................................19 主动通知
           4.4.1. Notice of Disconnection ............................19 断开通知
      4.5. Search Operation ..........................................20 搜索操作
           4.5.1. Search Request .....................................20 搜索请求
           4.5.2. Search Result ......................................27 搜索结果
           4.5.3. Continuation References in the Search Result .......28 搜索结果中的继续引用
      4.6. Modify Operation ..........................................31 修改操作
      4.7. Add Operation .............................................33 添加操作
      4.8. Delete Operation ..........................................34 删除操作
      4.9. Modify DN Operation .......................................34 修改DN的操作
      4.10. Compare Operation ........................................36 比较操作
      4.11. Abandon Operation ........................................36 放弃/丢弃操作
      4.12. Extended Operation .......................................37 扩展操作
      4.13. IntermediateResponse Message .............................39 中间响应消息
           4.13.1. Usage with LDAP ExtendedRequest and                   与LDAP的  
                   ExtendedResponse ..................................40     扩展请求/ExtendedRequest 和 扩展响应/ExtendedResponse 一起使用
           4.13.2. Usage with LDAP Request Controls ..................40 与LDAP的 控制请求/Request Controls 一起使用
      4.14. StartTLS Operation .......................................40 StartTLS操作
           4.14.1. StartTLS Request ..................................40 StartTLS请求
           4.14.2. StartTLS Response .................................41 StartTLS响应
           4.14.3. Removal of the TLS Layer ..........................41 删除TLS层
   5. Protocol Encoding, Connection, and Transfer ....................42 协议的编码，连接和传输
      5.1. Protocol Encoding .........................................42 协议的编码
      5.2. Transmission Control Protocol (TCP) .......................43 传输控制协议/TCP 
      5.3. Termination of the LDAP session ...........................43 LDAP会话的终止
   6. Security Considerations ........................................43 安全注意事项
   7. Acknowledgements ...............................................45 致谢
   8. Normative References ...........................................46 规范性引用
   9. Informative References .........................................48 参考文献
   10. IANA Considerations ...........................................48 
   Appendix A. LDAP Result Codes .....................................49 LDAP返回码
      A.1. Non-Error Result Codes ....................................49 非错误的 返回码
      A.2. Result Codes ..............................................49 返回码
   Appendix B. Complete ASN.1 Definition .............................54 完整的ASN.1定义
   Appendix C. Changes ...............................................60 变化
      C.1. Changes Made to RFC 2251 ..................................60 对RFC2251所做的更改
      C.2. Changes Made to RFC 2830 ..................................66
      C.3. Changes Made to RFC 3771 ..................................66
#---------------------------------------------------------------------------------------

```





# RFC
```bash

# https://ldap.com/ldap-related-rfcs/

	1. 定义 LDAP 协议和其他核心规范的 RFC (RFCs Defining the LDAP Protocol and Other Core Specifications)
	2. 包含信息文档、建议和最佳实践的 RFC  (RFCs Containing Informational Documents, Recommendations, and Best Practices)
	3. RFC 定义控制和扩展操作        (RFCs Defining Controls and Extended Operations)
	4. 定义核心 LDAP Schema的 RFC  (RFCs Defining Core LDAP Schema)
	5. 包含附加 LDAP 架构定义的 RFC (RFCs Containing Additional LDAP Schema Definitions)
	6. 包含通常与 LDAP 结合使用的其他规范的 RFC(RFCs Containing Other Specifications Commonly Used in Conjunction with LDAP)
	7.  为信息目的提供的过时 RFC(Obsolete RFCs Provided for Informational Purposes)


# https://ldap.com/ldapv3-wire-protocol-reference/


## 1.1 common elements 

```txt

RFC 4511	4.1. Common Elements

		------------------------------------
		LDAPMessage： https://ldap.com/ldapv3-wire-protocol-reference-ldap-message/
		 RFC 4511 section 4.1.1

		LDAPMessage
			使用LDAP协议 交换数据时，公共信息 封装在 LDAPMessage中；

			所有LDAPv3请求和响应都封装在LDAPMessage的BER sequence中

			LDAP Request
				每种类型的LDAP request都有一些不同，
				每个request都被封装在LDAPMessage序列的protocolOp字段中
			LDAP Response
				大多数类型的LDAP response非常相似
					除了protocolOp字段对于每种操作具有不同的BER类型
				每个response都被封装在LDAPMessage序列的protocolOp字段中
					add/compare/delete/modify/modify DN 的 响应消息的结构是一样的


			LDAPMessage ::= SEQUENCE {                      -- 序列
				messageID       MessageID,                     -- 消息ID -- messageID
				protocolOp      CHOICE {                       -- 执行什么操作
					bindRequest           BindRequest,		   -- -- [APPLICATION 0]
					bindResponse          BindResponse,		   -- -- [APPLICATION 1]
					unbindRequest         UnbindRequest,	   -- -- [APPLICATION 2]
					searchRequest         SearchRequest,	   -- -- [APPLICATION 3]
					searchResEntry        SearchResultEntry,   -- -- [APPLICATION 4]
					searchResDone         SearchResultDone,	   -- -- [APPLICATION 5]
					searchResRef          SearchResultReference,-- -- [APPLICATION 19]
					modifyRequest         ModifyRequest,	   -- -- [APPLICATION 6]
					modifyResponse        ModifyResponse,	   -- -- [APPLICATION 7]
					addRequest            AddRequest,		   -- -- [APPLICATION 8]
					addResponse           AddResponse,		   -- -- [APPLICATION 9]
					delRequest            DelRequest,          -- -- [APPLICATION 10]
					delResponse           DelResponse,		   -- -- [APPLICATION 11]
					modDNRequest          ModifyDNRequest,	   -- -- [APPLICATION 12]
					modDNResponse         ModifyDNResponse,	   -- -- [APPLICATION 13]
					compareRequest        CompareRequest,	   -- -- [APPLICATION 14]
					compareResponse       CompareResponse,	   -- -- [APPLICATION 15]
					abandonRequest        AbandonRequest,      -- -- [APPLICATION 16]
					extendedReq           ExtendedRequest,	   -- -- [APPLICATION 23]
					extendedResp          ExtendedResponse	   -- -- [APPLICATION 24]
					...,
					intermediateResponse  IntermediateResponse },-- -- [APPLICATION 25]
				controls       [0] Controls OPTIONAL }           -- 控件
		
			MessageID ::= INTEGER (0 ..  maxInt) 
			maxInt INTEGER ::= 2147483647 -- (2^^31 - 1)  

			MessageID：
				非0整数；
				同一会话中不可重复；
				0是给 主动通知的特殊类型的消息保留的(server在没有任请求的情况下向cient发送的消息)；
				client发送的消息时在 0-2147483647之间选择一个(该ID 尚未被该连接上的任何未完成请求使用)
		总结:
			LDAPMessage包含3个组件
				messageID	--消息ID
				protocolOp	--协议操作
				controls	--一组可选的控件
			LDAPMessage序列的messageID元素
				用于关联请求和响应(server为该请求返回的响应 都具有与该请求相同的messageID)
					1.允许LDAP异步运行，单个client可以由多个未完成的请求
					2.允许多个应用程序线程 共享同一个连接
					3.允许单个线程同时提交多个请求(但是一个请求的内容不能依赖于正在提交的另一个请求的响应)
			LDAPMessage序列的protocolOp元素
				它封装了有关请求或响应的所有详细信息，因此其格式因请求或响应的内容而异。
			LDAPMessage序列的controls
				一个LDAPMessage序列 可以任选地包括一组 提供有关该操作的附加信息的 控件/control；
				如果client发送给server的request中包含了control，
					那么control提供了 server应该如何处理该请求的 附加信息；
				如果server回复给client的response中包含control，
					那么control 向client提供了 操作的处理方式的 附加信息，
					响应control通常由请求control触发

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

		LDAPResult序列：https://ldap.com/ldapv3-wire-protocol-reference-ldap-result/
		 RFC 4511 4.1.9

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

				类型定义：
					Controls ::= SEQUENCE OF control Control
					Control ::= SEQUENCE {
						controlType             LDAPOID,                   #control的OID
						criticality             BOOLEAN DEFAULT FALSE,     #布尔值，默认false
						controlValue            OCTET STRING OPTIONAL }		
					LDAPOID ::= OCTET STRING -- Constrained to <numericoid>
							   -- [RFC4512]

				因为LDAPMessage是个序列，所以Controls是一个序列中的序列，每个序列最多包含3个元素
					controlType ： 点分十进制的数字组合
						控件类型的OID
						request control对应的 response control 共享controlType的值
					criticality ： bool值
						指示 是否将control视为对操作处理至关重要；
							当此字段设置为TRUE时，表明server必须使用control才能执行操作
						仅当control附到request message(UnbindRequest除外)时，此字段才有意义，
							即：LDAPMessage.protocolOp=xxxRequest时；
						当control附到response message和/或UnbindRequest时，此字段应设置为FALSE，接收方应忽略这个字段
						如果server 
							识别不了control的类型，或者 不愿意使用control执行操作，
							并且 criticality字段为TRUE，
								则server 无法执行操作 
									那么server 在response message中 
									将resultCode设置为unavailableCriticalExtension
						如果server 
							识别不了control的类型，或者 不愿意使用control执行操作，
							并且 criticality字段为FALSE，
								则server忽略control(好像control不存在一样)
					controlValue ： 
						controlType的值OID 是传达了control的信息，
							也足以表达client想要server使用哪个control进行处理
							但通常 还需要提供附加信息
						controlValue的值提供了 server使用control进行处理时 所需的 附加信息
						例子： 
							如果某一次请求中controlType指定的OID，表明了这个control是个排序控件
								那么，指示server对结果进行排序后，再返回给client
							但是排序的顺序需要client指出
								通过controlValue指出排序顺序(正序/逆序/...)
				
				server在
					root DSE([RFC4512]的第5.1节)的 "supportedControl"的属性中 列出了
					它/server 识别的 request control的controlType
				
				control的定义
					control的OID
					...
		------------------------------------
```
### 一个DelRequest的例子：

https://ldap.com/ldapv3-wire-protocol-reference-ldap-message/ 

```txt
网址： https://ldap.com/ldapv3-wire-protocol-reference-ldap-message/

前言： 
	虽然我们还没有深入学习任何 协议操作/protocolOp 和 控件/Controls 
	但提供一个简单的 LDAPMessage仍有裨益

例子的要求：
	an LDAP message with a message ID of five that requests deleting the dc=example,dc=com entry and includes a subtree delete request control to indicate that the server should also remove any entries that exist below the target entry.
	即：
		messageID=5
		删除条目 dc=example,dc=com 
		包含一个conrtol，指示server 删除 这个条目的所有子树

所需要用到的定义如下： 
	DelRequest ::= [APPLICATION 10] LDAPDN
	LDAPDN ::= LDAPString
			-- Constrained to <distinguishedName> [RFC4514]
	LDAPString ::= OCTET STRING -- UTF-8 encoded,
				-- [ISO10646] characters
简要总结： 
	该 删除请求 协议操作被简单的编码为 OCTET STRING ；
	其 BER类型为 特定于应用程序的10(0x4a) ；
	请求中附带的控件为：删除子树控件/control，其OID为1.2.840.113556.1.4.805；并且没有值(值是附加在controlValue中)；
	其 criticality/关键性 可能是true或false，我们将其设置为true，
		这样若是server无法删除子树，操作就会失败，
		这样就能区分 server是否支持 子树删除控件 以及 处理中的一些其他问题

综上所述，DelRequest的LDAPMessage编码如下： 
	30 35 02 01 05 4a 11 64 63 3d 65 78 61 6d 70 6c
	65 2c 64 63 3d 63 6f 6d a0 1d 30 1b 04 16 31 2e
	32 2e 38 34 30 2e 31 31 33 35 35 36 2e 31 2e 34
	2e 38 30 35 01 01 ff

这是一个带有注释的格式化版本，以便于解释。对于后续部分，将仅提供格式化的表示。
	30 35 -- Begin the LDAPMessage sequence
	   02 01 05 -- The message ID (integer value 5)
	   4a 11 64 63 3d 65 78 61 6d 70 -- The delete request protocol op
	         6c 65 2c 64 63 3d 63 6f -- (octet string
	         6d                      -- dc=example,dc=com)
	   a0 1d -- Begin the sequence for the set of controls
	      30 1b -- Begin the sequence for the first control
	         04 16 31 2e 32 2e 38 34 30 2e -- The control OID
	 31 31 33 35 35 36 2e 31 -- (octet string
	 2e 34 2e 38 30 35       -- 1.2.840.113556.1.4.805)
	         01 01 ff -- The control criticality (Boolean true)

30 35 -- 开始 LDAPMessage 序列
   02 01 05 -- 消息 ID（整数值 5）
   4a 11 64 63 3d 65 78 61 6d 70 -- 删除请求协议 op 
         6c 65 2c 64 63 3d 63 et 6f -- (oct字符串
         6d -- dc=example,dc=com) 
   a0 1d -- 开始一组控件的序列 
      30 1b -- 开始第一个控件的序列
         04 16 31 2e 32 2e 38 34 30 2e -- 控件 OID 
 31 31 33 35 35 36 2e 31 -- (octet string 
 2e 34 2e 38 30 35 -- 1.2.840.113556.1.4.805) 
         01 01 ff -- 控制临界值（布尔真）

```


## 1.2 Bind Operation
```txt
RFC 4511	4.2. Bind Operation
	
	------------------------------------
	Bind Operation
		主要用于交换 身份验证/认证信息

		BindRequest
			(我推测：BindRequest被封装进LDAPMessage的protocolOp字段)

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
			
			
		
		Processing of the Bind Request
			server
				处理BindRequest；
				在处理BindResuest之前，对于未完成的操作 要么等待操作的完成 要么放弃操作；
				然后执行  单步绑定过程 或者 多步绑定过程(每一步都需要server返回一个BindResponse 来指示认证的状态);
				如果正在处理BindRequest，那么不应该 处理/响应 接收到的 请求	
			client 
				发出BindRequest之后，如果还没有接收到 BindResponse，那么它不应该发送更多的LDAP-PDU ；
				可以发送多个BindRequest 来更改 身份验证 和/或 安全关联 或 完成多阶段绑定过程。
				对于SASL验证机制
					可能多次调用BindRequest；
					作为 多阶段绑定 的一部分，两个BindRequest之间 client不得调用其他操作
				终止SASL绑定协商
					发送一个BindRequest，
						其中的SaslCredentials字段中的值不同，或者
						AuthenticationChoice选择的不是SASL 
				如果发送request时没有bind，并收到了operationsError
					那么发送BindRequest；
					如果失败了，那么终止这个LDAP-session，重新建立连接并发送BindRequest
				发送的BindRequest中的 sasl的 mechanism字段 是个空字符串
					那么server返回BindResponse，并将resultCode设置为authMethodNotSupported
					如果使用相同的SASL mechanism再次尝试，那么将终止协商



		Bind Response
			(我推测：BindResponse被封装进LDAPMessage的protocolOp字段)

			BindResponse ::= [APPLICATION 1] SEQUENCE {
				COMPONENTS OF LDAPResult,						-- LDAPResult的组成部分
				serverSaslCreds    [7] OCTET STRING OPTIONAL }
			
			绑定成功时
				BindResponse 的 LDAPResult.resultCode = success

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

## OID 
```bash
## https://ldap.com/ldap-oid-reference-guide/ 

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
