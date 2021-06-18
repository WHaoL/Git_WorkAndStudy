Network Working Group                                J. Sermersheim, Ed.
Request for Comments: 4511                                  Novell, Inc.
Obsoletes: 2251, 2830, 3771                                    June 2006
Category: Standards Track

RFC 4511                         LDAPv3                        June 2006



#   Lightweight Directory Access Protocol (LDAP): The Protocol

  轻量级目录访问协议(LDAP): 协议

## Status of This Memo

This document specifies an Internet standards track protocol for the  Internet community, and requests discussion and suggestions for improvements.  Please refer to the current edition of the "Internet Official Protocol Standards" (STD 1) for the standardization state  and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice(版权)

   Copyright (C) The Internet Society (2006).

## Abstract(概述)

This document describes the protocol elements, along with their semantics and encodings, of the Lightweight Directory Access Protocol (LDAP).  LDAP provides access to distributed directory services that act in accordance with X.500 data and service models.  These protocol elements are based on those described in the X.500 Directory Access Protocol (DAP).
本文档描述了轻量级目录访问协议(LDAP)的 协议元素及其语义和编码。 LDAP 提供对 按照X.500数据和服务模型 运行的分布式目录服务 的访问。  这些协议元素 基于X.500目录访问协议 (DAP) 中描述的那些元素。

# Table of Contents(目录)

## 1. Introduction(简介)

The Directory is "a collection of open systems cooperating to provide directory services" [X.500].  A directory user, which may be a human or other entity, accesses the Directory through a client (or Directory User Agent (DUA)).  The client, on behalf of the directory user, interacts with one or more servers (or Directory System Agents (DSA)).  Clients interact with servers using a directory access protocol.
目录是“合作提供目录服务的开放系统的集合”[X.500]。 
目录用户/user（可以是人或其他实体）通过 客户端/client（或目录用户代理 (DUA)）访问目录。 
客户端/client  代表 目录用户/user 与一台或多台服务器（或目录系统代理 (DSA)）交互。 
客户端使用目录访问协议与服务器交互。



This document details the protocol elements of the Lightweight Directory Access Protocol (LDAP), along with their semantics. Following the description of protocol elements, it describes the way in which the protocol elements are encoded and transferred.
本文档详细介绍了轻量级目录访问协议 (LDAP) 的协议元素及其语义。
在协议元素的描述之后，它描述了协议元素的编码和传输方式。



### 1.1. Relationship to Other LDAP Specifications(本文档与其他LDAP规范的关系)

This document is an integral part of the LDAP Technical Specification[RFC4510], which obsoletes the previously defined LDAP technical  specification, RFC 3377, in its entirety.
本文档是 LDAP 技术规范 [RFC 4510] 的组成部分，该规范完全废弃了先前定义的 LDAP 技术规范 RFC 3377。



This document, together with [RFC4510], [RFC4513], and [RFC4512],   obsoletes RFC 2251 in its entirety.  Section 3.3 is obsoleted by[RFC4510].  Sections 4.2.1 (portions) and 4.2.2 are obsoleted by[RFC4513].  Sections 3.2, 3.4, 4.1.3 (last paragraph), 4.1.4, 4.1.5,  4.1.5.1, 4.1.9 (last paragraph), 5.1, 6.1, and 6.2 (last paragraph)  are obsoleted by [RFC4512].  The remainder of RFC 2251 is obsoleted   by this document.  Appendix C.1 summarizes substantive changes in the   remainder.

本文档与 [RFC4510]、[RFC4513] 和 [RFC4512] 一起完全废弃了 RFC 2251。 3.3 节已被[RFC4510] 废弃。 4.2.1 节（部分）和 4.2.2 节被[RFC4513]废弃。 3.2、3.4、4.1.3（最后一段）、4.1.4、4.1.5、4.1.5.1、4.1.9（最后一段）、5.1、6.1和6.2（最后一段）已被[RFC4512]废弃。 RFC 2251 的其余部分已被本文档废弃。 附录 C.1 总结了其余部分的实质性变化。



This document obsoletes RFC 2830, Sections 2 and 4.  The remainder of  RFC 2830 is obsoleted by [RFC4513].  Appendix C.2 summarizes  substantive changes to the remaining sections.
本文档废弃了 RFC 2830 的第 2 节和第 4 节。RFC 2830 的其余部分已被 [RFC 4513] 废弃。 附录 C.2 总结了对其余部分的实质性更改。


This document also obsoletes RFC 3771 in entirety.
本文档还完全废弃了 RFC 3771。



## 2. Conventions(约定的术语)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT","SHOULD", "SHOULD NOT", "RECOMMENDED", and "MAY" in this document are
to be interpreted as described in [RFC2119].
本文档中的关键词 "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",   "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"是按照   [RFC2119]中的描述进行解释



Character names in this document use the notation for code points and names from the Unicode Standard [Unicode].  For example, the letter "a" may be represented as either <U+0061> or <LATIN SMALL LETTER A>.
   本文档中的字符名称使用来自 Unicode标准[Unicode]的 代码点和名称 符号。例如，字母“a”可以表示为 <U+0061> 或 <LATIN SMALL LETTER A>。

Note: a glossary of terms used in Unicode can be found in [Glossary].  Information on the Unicode character encoding model can be found in   [CharModel].
注意：Unicode中使用的术语词汇表可以在[词汇表]中找到。 有关 Unicode 字符编码模型的信息可以在 [CharModel] 中找到。



The term "transport connection" refers to the underlying transport services used to carry the protocol exchange, as well as associations established by these services.    
术语"transport connection"是指 用于进行协议交换的 基本传输服务，以及由这些服务建立的关联。



The term "TLS layer" refers to Transport Layer Security (TLS) services used in providing security services, as well as associations established by these services.
术语"TLS layer"是指用于 提供安全服务的 传输层安全(TLS)服务，以及由这些服务建立的关联。



The term "SASL layer" refers to Simply Authentication and Security Layer (SASL) services used in providing security services, as well as associations established by these services.
术语"SASL layer" 是指 用于提供安全服务 以及由这些服务建立的关联的  简单身份验证和安全层（SASL）服务。



The term "LDAP message layer" refers to the LDAP Message Protocol Data Unit (PDU) services used in providing directory services, as well as associations established by these services.
术语"LDAP message layer"是指   在 提供目录服务 以及 由这些服务建立的关联 中 使用的  LDAP-Message协议数据单元(PDU)服务。



The term "LDAP session" refers to combined services (transport connection, TLS layer, SASL layer, LDAP message layer) and their associations.
术语"LDAP session/会话"是指组合的服务（传输连接，TLS层，SASL层，LDAP消息层）及其关联。 



See the table in Section 5 for an illustration of these four terms.
      有关这四个术语的说明，请参见第5节中的表。



## 3. Protocol Model(协议模型)

The general model adopted by this protocol is one of clients performing protocol operations against servers.  In this model, a client transmits a protocol request describing the operation to be performed to a server.  The server is then responsible for performing the necessary operation(s) in the Directory.  Upon completion of an operation, the server typically returns a response containing appropriate data to the requesting client.
该协议采用的通用模型是 客户端/client 对 服务器/serve 执行协议操作。 在该模型中，客户端向服务器发送 要执行操作的协议请求。 然后服务器负责在号码簿中执行必要的操作。 操作完成后，服务器通常会向发出请求的客户端返回包含适当数据的响应。
总结： 即client发出请求，server处理 并 回复响应



Protocol operations are generally independent of one another.  Each operation is processed as an atomic action, leaving the directory in a consistent state.
协议操作通常彼此独立。 每个操作都作为一个原子操作进行处理，使目录保持一致状态。
总结：   
   每个操作都是独立的 
   每个操作都是原子性的



Although servers are required to return responses whenever such responses are defined in the protocol, there is no requirement for synchronous behavior on the part of either clients or servers. Requests and responses for multiple operations generally may be exchanged between a client and server in any order.  If required, synchronous behavior may be controlled by client applications.
尽管只要在协议中定义了这样的响应，服务器就需要返回响应，但客户端或服务器都不需要同步行为。 多个操作的请求和响应通常可以以任何顺序在客户端和服务器之间交换。 如果需要，客户端应用程序可以控制同步行为。
总结： 
   默认情况下，响应的顺序和请求的顺序，并不相同；可以以任意顺序 交换请求和响应。 (即 默认情况下是异步的)
   如果需要： client可以控制 同步/交换 行为



The core protocol operations defined in this document can be mapped  to a subset of the X.500 (1993) Directory Abstract Service [X.511].  However, there is not a one-to-one mapping between LDAP operations  and X.500 Directory Access Protocol (DAP) operations.  Server  implementations acting as a gateway to X.500 directories may need to  make multiple DAP requests to service a single LDAP request.
本文档中定义的核心协议操作可以映射到 X.500 (1993) 目录服务 [X.511] 的一个子集。 但是，LDAP 操作和 X.500 目录访问协议 (DAP) 操作之间没有一对一的映射。 充当 X.500 目录网关的服务器实现可能需要发出多个 DAP 请求来为单个 LDAP 请求提供服务。
   总结： 
      本文档定义的核心操作是 X.500的子集 
       X.500的网关服务器 可能需要向X.500发出多个DAP请求 ，来为单个LDAP请求提供服务



### 3.1. Operation and LDAP Message Layer Relationship

操作与 LDAP消息层 关系

Protocol operations are exchanged at the LDAP message layer.  When  the transport connection is closed, any uncompleted operations at the  LDAP message layer are abandoned (when possible) or are completed  without transmission of the response (when abandoning them is not possible).  Also, when the transport connection is closed, the client MUST NOT assume that any uncompleted update operations have succeeded or failed.
协议操作在 LDAP 消息层交换。 当传输连接关闭时，LDAP消息层中任何未完成的操作都将被放弃（如果可能）或在不传输响应的情况下完成（如果放弃它们是不可能的）。 此外，当传输连接关闭时，客户端不得假定任何未完成的更新操作已成功或失败。
总结： 
    协议操作 在 LDAP message layer 交换。 
    当传输连接关闭时： 
        对于server的LDAP message layer上的任何未完成的操作：
        如果可以被放弃，那么放弃 
        如果不能被放弃，那么执行完毕



## 4. Elements of Protocol(协议元素)

The protocol is described using Abstract Syntax Notation One([ASN.1]) and is transferred using a subset of ASN.1 Basic Encoding Rules ([BER]).  Section 5 specifies how the protocol elements are encoded and transferred.
该协议使用抽象语法符号一（[ASN.1]）进行描述，并使用 ASN.1 基本编码规则（[BER]）的子集进行传输。 第 5 节指定协议元素如何编码和传输。
总结： 
    本协议 
        使用 ASN.1语法进行描述，
        使用 ASN.1的基本编码规则[BER]的子集 进行编码传输。 



In order to support future extensions to this protocol, extensibility is implied where it is allowed per ASN.1 (i.e., sequence, set, choice, and enumerated types are extensible).  In addition, ellipses  (...) have been supplied in ASN.1 types that are explicitly extensible as discussed in [RFC4520].  Because of the implied  extensibility, clients and servers MUST (unless otherwise specified)  ignore trailing SEQUENCE components whose tags they do not recognize.
为了支持此协议的未来扩展，在每个 ASN.1 允许(扩展)的地方暗示了可扩展性（即sequence/序列、set/集合、choice/选择和enumerated/枚举类型是可扩展的）。 此外，省略号 (...) 已在 ASN.1 类型中提供，如 [RFC4520] 中所讨论的，这些类型可显式扩展。 由于隐含的可扩展性，客户端和服务器必须（除非另有说明）忽略 其标签无法识别 的 尾随的SEQUENCE 组件 。
总结：
    sequence/set/choice/enumerated 都是本协议规定的 可扩展的 类型



Changes to the protocol other than through the extension mechanisms described here require a different version number.  A client indicates the version it is using as part of the BindRequest, described in Section 4.2.  If a client has not sent a Bind, the server MUST assume the client is using version 3 or later.
除了通过这里描述的扩展机制之外，协议的更改需要一个不同的版本号。 客户端指示它正在使用的版本作为 BindRequest 的一部分，如 4.2 节所述。 如果客户端没有发送绑定，服务器必须假设客户端使用的是版本 3 或更高版本。
总结：
    client在BindRequest中必须告诉server 自己使用的版本号 (!!!)
    client没有发送Bind的话，server假定client使用的是 版本3或者更高版本   



Clients may attempt to determine the protocol versions a server supports by reading the 'supportedLDAPVersion' attribute from the  root DSE (DSA-Specific Entry) [RFC4512].
客户端可以尝试通过从根DSE (DSA-Specific Entry)读取'supportedLDAPVersion'属性来确定服务器支持的协议版本[RFC4512]。
    总结： 
        client 读取 root DSE的supportedLDAPVersion属性，
        来尝试确定 server支持哪些版本/version



### 4.1.  Common Elements(公共/通用元素)

This section describes the LDAPMessage envelope Protocol Data Unit(PDU) format, as well as data type definitions, which are used in the protocol operations.
本节介绍 
   LDAPMessage 封装 协议数据单元(PDU/Protocol Data Unit) 格式，以及协议操作中使用的数据类型定义。
总结： 
   本节(4.1)介绍 如何使用LDAPMessage封装PDU(Protocol Data Unit)
   以及 协议操作(protocolOp)中使用的数据类型(data-type)



#### 4.1.1.  Message Envelope(封装消息)

For the purposes of protocol exchanges, all protocol operations are  encapsulated in a common envelope, the LDAPMessage, which is defined as follows:
为了实现协议交换的目的，所有协议操作都封装在一个通用的信封中，即LDAPMessage，它的定义如下:
总结： 
   所有 协议操作，封装在LDAPMessage中。(!!!)



```ASN.1
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
    MessageID ::= INTEGER (0 ..  maxInt)                -- 消息ID是个整数，介于0和maxint之间 (请求和响应时，client和server使用同一消息ID )
    maxInt INTEGER ::= 2147483647 -- (2^^31 - 1) --     -- 
```



The ASN.1 type Controls is defined in Section 4.1.11.
ASN.1类型的控件，在4.1.11节中定义 [Page 14]



The function of the LDAPMessage is to provide an envelope containing  common fields required in all protocol exchanges.  At this time, the only common fields are the messageID and the controls.
LDAPMessage的功能是提供一个信封，其中包含所有协议交换所需的公共字段。此时，唯一常用的字段是messageID和controls/控件。
总结：
    LDAPMessage是一个sequence
    LDAPMessage中封装了所有协议交换所需的公共字段
        常用的字段是messageID和controls
    

If the server receives an LDAPMessage from the client in which the  LDAPMessage SEQUENCE tag cannot be recognized, the messageID cannot  be parsed, the tag of the protocolOp is not recognized as a request,  or the encoding structures or lengths of data fields are found to be  incorrect, then the server SHOULD return the Notice of Disconnection described in Section 4.4.1, with the resultCode set to protocolError, and MUST immediately terminate the LDAP session as described in  Section 5.3.
如果服务器从客户端收到一个LDAPMessage，其中LDAPMessage SEQUENCE tag不能识别，messageID不能解析，protocolOp tag 不能识别为请求，或者数据字段的编码结构或长度不正确，然后服务器应该返回4.4.1中描述的断开连接通知，resultCode设置为protocolError，并且必须立即终止5.3中描述的LDAP会话。


In other cases where the client or server cannot parse an LDAP PDU,   it SHOULD abruptly terminate the LDAP session (Section 5.3) where  further communication (including providing notice) would be  pernicious.  Otherwise, server implementations MUST return an  appropriate response to the request, with the resultCode set to  protocolError.
在其他情况下，客户端或服务器不能解析LDAP PDU，它应该突然终止LDAP会话(章节5.3)，在那里进一步的通信(包括提供通知)将是有害的。否则，服务器实现必须返回一个适当的响应，并将resultCode设置为protocolError。
总结：
    如果server/client 无法解析某个 PDU，
        那么立即终止通信
        并将 响应中的 resultCode设置为protocolError



##### 4.1.1.1.  MessageID(消息ID)

All LDAPMessage envelopes encapsulating responses contain the  messageID value of the corresponding request LDAPMessage.
所有封装的 response-LDAPMessage 都包含相应request-LDAPMessage 的 messageID 值。


The messageID of a request MUST have a non-zero value different from  the messageID of any other request in progress in the same LDAP session.  The zero value is reserved for the unsolicited notification  message.
request的messageID 必须是非零值，不同于在同一 LDAP 会话中进行的 任何其他request的 messageID。 0值是为 主动提供的 通知消息保留的。
总结： 
    messageID
        是非0值
        不能与同一会话中的其他messageID相同
        0值是为 通知消息保留的
    

Typical clients increment a counter for each request.
典型的客户端为每个请求增加一个计数器。



A client MUST NOT send a request with the same messageID as an  earlier request in the same LDAP session unless it can be determined  that the server is no longer servicing the earlier request (e.g.,  after the final response is received, or a subsequent Bind completes).  Otherwise, the behavior is undefined.  For this purpose,  note that Abandon and successfully abandoned operations do not send  responses.
客户端不得在同一 LDAP 会话中发送与先前request相同messageID 的request，除非可以确定服务器不再为先前的request提供服务（例如，在收到最终响应之后，或后续绑定完成后） ）。 否则，行为是未定义的。 为此，请注意放弃和成功放弃的操作不会发送响应。
总结： 
    在同一会话中，client发送的messageID不能重复 (除非server已经不为某一个messageID提供服务)
    放弃 / 成功放弃 操作不会发送响应    



#### 4.1.2.  String Types(string类型)

The LDAPString is a notational convenience to indicate that, although  strings of LDAPString type encode as ASN.1 OCTET STRING types, the [ISO10646] character set (a superset of [Unicode]) is used, encoded  following the UTF-8 [RFC3629] algorithm.  Note that Unicode characters U+0000 through U+007F are the same as ASCII 0 through 127,  respectively, and have the same single octet UTF-8 encoding.  Other Unicode characters have a multiple octet UTF-8 encoding.

LDAPString 是一种符号方便，尽管 LDAPString 类型的字符串编码为 ASN.1 OCTET STRING 类型，但使用了 [ISO10646] 字符集（[Unicode] 的超集），按照 UTF-8 [RFC3629] 进行编码 算法。 请注意，Unicode 字符 U+0000 到 U+007F 分别与 ASCII 0 到 127 相同，并且具有相同的单个八位字节 UTF-8 编码(single octet UTF-8 encoding)。 其他 Unicode 字符具有多个八位字节 UTF-8 编码(multiple octet UTF-8 encoding)。

```ASN.1
LDAPString ::= OCTET STRING -- UTF-8 encoded,
                            -- [ISO10646] characters总结：
```
总结： 
    LDAPString是一种符号方便，是字符串
        LDAPStrin被编码为 ASN.1 OCTET STRING类型
        并且编码为 Unicode的UTF-8
        因为 Unicode的U+0000到U+007F 与 ASCII的0到127相同
    即 单字节-8位的UTF-8编码 的字符串 (!!!)



The LDAPOID is a notational convenience to indicate that the  permitted value of this string is a (UTF-8 encoded) dotted-decimal  representation of an OBJECT IDENTIFIER.  Although an LDAPOID is encoded as an OCTET STRING, values are limited to the definition of   <numericoid> given in Section 1.4 of [RFC4512].
LDAPOID 是一种符号方便，用于指示此 string/字符串 的允许值是对象标识符/OID的（UTF-8 编码）点分十进制表示。 尽管 LDAPOID 被编码为 OCTET STRING，但值仅限于 [RFC4512] 的第 1.4 节中给出的 <numericoid> 定义。
```ASN.1
LDAPOID ::= OCTET STRING -- Constrained to <numericoid>
                         -- [RFC4512]
```
For example,
```ASN.1
    1.3.6.1.4.1.1466.1.2.3
```
总结： 
   LDAPOID是一种符号方便；
   LDAPOID是一种 点分十进制 表示的string/字符串 (UTF-8编码)，尽管LDAPOID被编码为 OCTET STRING，
​        但 值 仅限于 [RFC4512]的1.4节定义的 <numericoid>





#### 4.1.3.  Distinguished Name and Relative Distinguished Name(DN和RDN)

An LDAPDN is defined to be the representation of a Distinguished Name (DN) after encoding according to the specification in [RFC4514].
根据 [RFC 4514] 中的规范进行编码后，LDAPDN 被定义为  可分辨名称 (DN)   的表示。
```ASN.1
    LDAPDN ::= LDAPString
               -- Constrained to <distinguishedName> [RFC4514]
```
总结： 
    LDAPDN 代表/表示了 DN
   LDAPDN的类型是：LDAPString



A RelativeLDAPDN is defined to be the representation of a Relative  Distinguished Name (RDN) after encoding according to the specification in [RFC4514].
根据 [RFC 4514] 中的规范进行编码后，RelativeLDAPDN被定义为 相对可分辨名称 (RDN) 的表示。
```ASN.1
    RelativeLDAPDN ::= LDAPString
                       -- Constrained to <name-component> [RFC4514]
```
总结： 
   RelativeLDAPDN 代表/表示了 RDN
​   RelativeLDAPDN的类型是：LDAPString



#### 4.1.4.  Attribute Descriptions(属性描述)

The definition and encoding rules for attribute descriptions are  defined in Section 2.5 of [RFC4512].  Briefly, an attribute  description is an attribute type and zero or more options.
属性描述的 定义和编码规则在 [RFC4512] 的第 2.5 节中定义。 简而言之，属性描述 是一种属性类型和0个或多个选项。
```ASN.1
    AttributeDescription ::= LDAPString
                            -- Constrained to <attributedescription>
                            -- [RFC4512]
```
总结： 
    AttributeDescription的类型是：LDAPString
    AttributeDescription包含 一个attribute type 和 0个或多个options



#### 4.1.5.  Attribute Value(属性值)

A field of type AttributeValue is an OCTET STRING containing an  encoded attribute value.  The attribute value is encoded according to  the LDAP-specific encoding definition of its corresponding syntax. The LDAP-specific encoding definitions for different syntaxes and attribute types may be found in other documents and in particular  [RFC4517].
AttributeValue类型的字段 是一个OCTET STRING 包含了一个编码后的 attribute-value/属性值 。 attribute-value/属性值 根据 特定于LDAP编码定义 的相应语法 进行编码。   特定于LDAP编码的 不同语法和属性类型 定义  可以在其他文档中找到(特别是 [RFC4517]) 。
```ASN.1
    AttributeValue ::= OCTET STRING
```
总结： 
    AttributeValue的 值 编码为OCTET STRING



Note that there is no defined limit on the size of this encoding;  thus, protocol values may include multi-megabyte attribute values (e.g., photographs).
请注意，此编码的大小没有定义限制； 因此，协议值可以包括多兆字节的属性值（例如，照片）。
总结： 
    AttributeValue值的 编码大小没有限制



Attribute values may be defined that have arbitrary and non-printable  syntax.  Implementations MUST NOT display or attempt to decode an attribute value if its syntax is not known.  The implementation may attempt to discover the subschema of the source entry and to retrieve the descriptions of 'attributeTypes' from it [RFC4512].
可以定义具有任意和不可打印语法的属性值。实现 绝对不能 显示或试图解码 一个语法未知的属性值。该实现可能试图发现源条目的子模式，并从中检索'attributeTypes'的描述[RFC4512]。

Clients MUST only send attribute values in a request that are valid  according to the syntax defined for the attributes.
客户端 /client  必须根据属性定义的语法 只在请求request/中发送有效的属性值。

总结： 
      客户端 /client  必须根据属性定义的语法 只在请求request/中发送有效的属性值。



#### 4.1.6.  Attribute Value Assertion(属性值的断言)

The AttributeValueAssertion (AVA) type definition is similar to the  one in the X.500 Directory standards.  It contains an attribute description and a matching rule ([RFC4512], Section 4.1.3) assertion  value suitable for that type.  Elements of this type are typically used to assert that the value in assertionValue matches a value of an attribute.

AttributeValueAssertion (AVA) 类型定义类似于 X.500 Directory 标准中的(类型定义)。 它包含适合该类型的属性描述和匹配规则（[RFC4512]，第 4.1.3 节）断言值。 此类型的元素通常用于 断言 assertionValue's value 与attribute's value 匹配。

```ASN.1
    AttributeValueAssertion ::= SEQUENCE {
         attributeDesc   AttributeDescription,
         assertionValue  AssertionValue }

    AssertionValue ::= OCTET STRING
```

总结： 
    AttributeValueAssertion被编码为sequence ，AssertionValue 被编码为OCTET STRING；
    AttributeValueAssertion包含该类型/type的 
        attribute-description   				attributeDesc -- 属性描述 
        matching-rule-assertion-value  assertionValue - (匹配规则)断言值

​	AttributeValueAssertion通常用于 断言/判断/assert   assertionValue's value 与attribute's value 的匹配/match



The syntax of the AssertionValue depends on the context of the LDAP operation being performed.  For example, the syntax of the EQUALITY matching rule for an attribute is used when performing a Compare operation.  Often this is the same syntax used for values of the  attribute type, but in some cases the assertion syntax differs from the value syntax.  See objectIdentiferFirstComponentMatch in  [RFC4517] for an example.

AssertionValue 的语法取决于 正在执行的 LDAP 操作的上下文。 例如，在执行比较操作时使用属性/attribute的 EQUALITY 匹配规则的语法。 通常这与用于属性类型值的语法相同，但在某些情况下，断言语法与值语法不同。 有关示例，请参阅 [RFC4517] 中的 objectIdentiferFirstComponentMatch。
总结： 
    AssertionValue的 syntax/语法 取决于正在执行的 LDAP操作的 context/上下文
    例如：
            在 执行比较操作时 使用 属性/attribute的 EQUALITY匹配规则 语法
    通常，对于 属性类型的值(attribute type‘s value) 应用同样的语法
            但是，某些情况下 断言 语法与 值语法不同



#### 4.1.7.  Attribute and PartialAttribute(属性和部分属性)

Attributes and partial attributes consist of an attribute description and attribute values.  A PartialAttribute allows zero values, while Attribute requires at least one value.
属性和部分属性由 属性描述/attribute-description和属性值/attribute-values 组成。 部分属性允许零值，而属性至少需要一个值。
```ASN.1
        PartialAttribute ::= SEQUENCE {
             type       AttributeDescription,
             vals       SET OF value AttributeValue }
             
        Attribute ::= PartialAttribute(WITH COMPONENTS {
             ...,
             vals (SIZE(1..MAX))})
```
总结： 
    Attributes / PartialAttribute都是由
        一个attribute-description
        和一个attribute-values的set 组成
    PartialAttribute 允许0个值
    Attributes 至少需要一个值



No two of the attribute values may be equivalent as described by Section 2.2 of [RFC4512].  The set of attribute values is unordered. Implementations MUST NOT rely upon the ordering being repeatable.
如 [RFC 4512] 的第 2.2 节所述，没有两个属性值可能是等效的。 属性值集/attribute-values's set 是无序的。 实现 不能/不得/禁止  依赖于可重复的排序。
总结： 
        attribute-values 是set 是无序的



#### 4.1.8.  Matching Rule Identifier(匹配规则 的 标识符)

Matching rules are defined in Section 4.1.3 of [RFC4512].  A matching rule is identified in the protocol by the printable representation of either its <numericoid> or one of its short name descriptors [RFC4512], e.g., 'caseIgnoreMatch' or '2.5.13.2'.
匹配规则在 [RFC4512] 的第 4.1.3 节中定义。 协议中定义的匹配规则 通过  其 可打印的 <numericoid> 或短名称 [RFC4512]  表示来标识，例如，“caseIgnoreMatch”或“2.5.13.2”。
```ASN.1
    MatchingRuleId ::= LDAPString
```


#### 4.1.9.  Result Message返回结果消息

The LDAPResult is the construct used in this protocol to return success or failure indications from servers to clients.  To various  requests, servers will return responses containing the elements found  in LDAPResult to indicate the final status of the protocol operation  request.
LDAPResult 是此协议中用于从服务器向客户端 返回成功或失败指示 的构造/结构。 对于各种request，服务器将返回 包含在 LDAPResult 中找到的元素的 响应，以指示 协议操作请求/protocolOp-request 的最终状态。
总结： 
    LDAPResult是个构造；
​	 servers 向 clients 返回 LDAPResult；
​	 LDAPResult是 server给client的响应/response；
    LDAPResult中包含的 elements/元素 表明了 请求操作的 最终状态。



```ASN.1
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
         referral           [3] Referral OPTIONAL } #   -- 4. 引用(指定了一个URI)
    
    --参看： 
        --/OPENLDAP_REL_ENG_2_4/libraries/libldap/error.c
        --中的  * Parse LDAPResult Messages:
```


The resultCode enumeration is extensible as defined in Section 3.8 of  [RFC4520].  The meanings of the listed result codes are given in  Appendix A.  If a server detects multiple errors for an operation,  only one result code is returned.  The server should return the  result code that best indicates the nature of the error encountered.  Servers may return substituted result codes to prevent unauthorized  disclosures.
resultCode枚举 是可扩展的，如 [RFC4520] 的第 3.8 节中所定义。 在附录A中给出了 列出的结果码的含义。如果服务器检测到一个操作的多个错误，则只返回一个结果码/result-code。 服务器应返回最能表明所遇到错误性质的结果代码/result-code。 服务器可能会返回替换的结果代码以防止未经授权的披露。
总结： 
    LDAPResult中的 resultCode/结果码 字段 是个枚举
        对于一个操作的多个错误，只返回一个result-code
        server只返回 最能代表错误性质的 result-code



The diagnosticMessage field of this construct may, at the server's option, be used to return a string containing a textual, human-readable diagnostic message (terminal control and page formatting characters should be avoided).  As this diagnostic message is not standardized, implementations MUST NOT rely on the values returned. Diagnostic messages typically supplement the resultCode with additional information.  If the server chooses not to return a textual diagnostic, the diagnosticMessage field MUST be empty.
根据服务器的选择，该构造的diagnosticMessage(诊断消息) 字段可用于返回 一个包含文本的、人类可读的诊断信息 字符串（应避免 终端控制和页面格式化字符）。 由于此诊断消息未标准化，因此实现不得依赖于返回的值。 诊断消息通常用附加信息补充 resultCode。 如果服务器选择不返回文本诊断，则diagnosticMessage 字段必须为空。
总结： 
    LDAPResult中的 diagnosticMessage(诊断信息)字段
        用于返回 一个 包含文本的 人类可读的诊断信息 字符串
        用于补充resultCode
        当服务器选择不返回文本诊断时，这个字段必须为空



For certain result codes (typically, but not restricted to  noSuchObject, aliasProblem, invalidDNSyntax, and  aliasDereferencingProblem), the matchedDN field is set (subject to access controls) to the name of the last entry (object or alias) used in finding the target (or base) object.  This will be a truncated   form of the provided name or, if an alias was dereferenced while attempting to locate the entry, of the resulting name.  Otherwise, the matchedDN field is empty.
1) 对于某些结果代码（通常但不限于 noSuchObject、aliasProblem、invalidDNSyntax 和 aliasDereferencingProblem），matchedDN 字段被设置（受访问控制）为用于 查找目标(或基础)对象的 最后一个条目(对象或别名)的名称。 2) 如果在尝试定位条目时解引用别名，结果名称将是所提供名称的截断形式。 3) 否则，matchedDN 字段为空。 
总结： 
    LDAPResult中的 matchedDN 字段
        1) 对于结果代码/resultCode 为 noSuchObject、aliasProblem、invalidDNSyntax、aliasDereferencingProblem的消息/message，
            服务器返回 在DIT中 可以为此操作找到的 最深的条目的DN
            (即：所查找对象的 最后一个条目的名称)
            参看：
                /OPENLDAP_REL_ENG_2_4/contrib/ldapc++/src/LDAPResult.h 
                的const std::string& getMatchedDN() const;

​		2) 如果在尝试定位条目时解引用别名，结果名称将是所提供名称的截断形式

​		3) 否则，matchedDN 字段为空。 



#### 4.1.10.  Referral(引用)

The referral result code indicates that the contacted server cannot or will not perform the operation and that one or more other servers may be able to.  Reasons for this include:
resultCode中的referral表示：被联系的服务器不能或不会执行操作，而一个或多个其他服务器可能能够执行。 原因包括：

   - The target entry of the request is not held locally, but the server has knowledge of its possible existence elsewhere.
        请求的目标条目不在本地(本服务器)保存，但服务器知道它可能存在于其他地方。
     
   - The operation is restricted on this server -- perhaps due to a read-only copy of an entry to be modified.
        该操作在此服务器上受到限制——可能是由于要修改的 是此条目的只读副本。

总结： 
    LDAPResult的resultCode字段的值 如果是 referral
        表明 此服务器无法执行 所请求的操作，但其他服务器可以执行 所请求的操作
        原因包括: 
            所请求的条目不在这个服务器上
            请求修改某条目，但此条目在此服务器上 只是个可读的副本

The referral field is present in an LDAPResult if the resultCode is set to referral, and it is absent with all other result codes.  It contains one or more references to one or more servers or services that may be accessed via LDAP or other protocols.  Referrals can be returned in  to any operation request (except Unbind and Abandon, which do not have responses).  At least one URI MUST be present in the Referral.
如果 LDAPResult的resultCode字段被设置为referral，则referral字段存在于 LDAPResult 中，当resultCode字段被设置为其他值时 都不存在referral字段。 它包含可通过 LDAP 或其他协议访问的一个或多个服务器或服务的一个或多个引用。 任何操作请求都可以返回referral（Unbind 和 Abandon 除外，它们没有响应）。 referral中必须至少存在一个 URI。
总结： 
    当LDAPResult的resultCode 字段的值 被设置为referral时
        referral字段出现在LDAPResult中，
    对 任何操作请求的响应 都可以返回 referral
    referral中字段 中 至少存在一个URI

During a Search operation, after the baseObject is located, and entries are being evaluated, the referral is not returned.  Instead, continuation references, described in Section 4.5.3, are returned when other servers would need to be contacted to complete the operation.
在搜索操作期间，在定位 baseObject 并评估条目后，不会返回referral。 相反，当需要联系其他服务器以完成操作时，将返回第 4.5.3 节中描述的延续引用/continuation-references。
总结： 
        当需要联系其他服务器以完成操作时，将返回reference(引用)

```ASN.1
    Referral ::= SEQUENCE SIZE (1..MAX) OF uri URI

    URI ::= LDAPString     -- limited to characters permitted in
                           -- URIs
```



If the client wishes to progress the operation, it contacts one of the supported services found in the referral.  If multiple URIs are present, the client assumes that any supported URI may be used to progress the operation.
如果客户端希望推进操作，它会联系/连接referral中找到的支持服务之一。 如果存在多个 URI，则客户端假定任何受支持的 URI 均可用于推进操作。
总结： 
        client会连接referral中的URI，以继续执行操作

Clients that follow referrals MUST ensure that they do not loop between servers.  They MUST NOT repeatedly contact the same server for the same request with the same parameters.  Some clients use a counter that is incremented each time referral handling occurs for an operation, and these kinds of clients MUST be able to handle at least ten nested referrals while progressing the operation.
追踪referral的客户端必须确保它们不会在服务器之间循环。 对于具有相同参数的相同请求，他们不得重复联系同一服务器。 一些客户端使用一个计数器，每次发生操作的引用/referral处理时都会增加该计数器，并且这些类型的客户端必须能够在进行操作时处理至少十个嵌套引用/referral。
总结： 
        client会连接referral中的URI 
                但是，具有相同参数的相同请求 不能重复连接同一服务器/server 



A URI for a server implementing LDAP and accessible via TCP/IP (v4 or v6) [RFC793][RFC791] is written as an LDAP URL according to  [RFC4516].
(实现了LDAP 并可通过TCP/IP(v4或v6)[RFC793] [RFC791]访问的)服务器/server 的URI   根据[RFC4516] 被写为 LDAP URL。

Referral values that are LDAP URLs follow these rules:
referral的值是LDAP URLs时 遵循以下规则：

   - If an alias was dereferenced, the <dn> part of the LDAP URL MUST be present, with the new target object name.
        如果别名被解引用，LDAP URL的<dn>部分必须存在，并带有新的目标对象的名称。
     
   - It is RECOMMENDED that the <dn> part be present to avoid ambiguity.
        建议使用/存在<dn>部分，以避免歧义。
   - If the <dn> part is present, the client uses this name in its next request to progress the operation, and if it is not present the client uses the same name as in the original request.
        如果 <dn> 部分存在，则客户端在其下一个请求中使用此名称来进行操作，如果不存在，则客户端使用与原始请求中相同的名称。
   - Some servers (e.g., participating in distributed indexing) may provide a different filter in a URL of a referral for a Search operation.
        某些服务器（例如，参与分布式索引）可能会在搜索操作的referral URL 中提供不同的过滤器。
   - If the <filter> part of the LDAP URL is present, the client uses this filter in its next request to progress this Search, and if it is not present the client uses the same filter as it used for that Search.
        如果LDAP URL中存在<filter>部分，则客户端在其下一个请求中使用此过滤器来进行此搜索，
        如果不存在，则客户端使用 与用于该搜索的过滤器 相同的过滤器。
   - For Search, it is RECOMMENDED that the <scope> part be present to avoid ambiguity.
        对于搜索，建议存在<scope>部分，以避免歧义。
   - If the <scope> part is missing, the scope of the original Search is used by the client to progress the operation.
        如果缺少 <scope> 部分，客户端将使用原始搜索的scope来进行操作。
   - Other aspects of the new request may be the same as or different from the request that generated the referral.
        新请求的其他方面可能与生成referral的请求相同或不同。

Other kinds of URIs may be returned.  The syntax and semantics of such URIs is left to future specifications.  Clients may ignore URIs that they do not support.
可能会返回其他类型的 URI。此类 URI 的语法和语义留给未来的规范。 客户端可能会忽略他们不支持的 URI。

UTF-8 encoded characters appearing in the string representation of a  DN, search filter, or other fields of the referral value may not be  legal for URIs (e.g., spaces) and MUST be escaped using the % method in [RFC3986].
出现在  DN的字符串表示、搜索过滤器 或 referral值的其他字段  中的UTF-8编码字符， 对于 URI(例如，空格)可能不合法，并且必须使用 [RFC3986] 中的 % 方法进行转义。

#### 4.1.11.  Controls(控件)

Controls provide a mechanism whereby the semantics and arguments of existing LDAP operations may be extended.  One or more controls may be attached to a single LDAP message.  A control only affects the semantics of the message it is attached to.  
控件提供了一种机制，可以扩展现有 LDAP 操作的语义和参数。一个或多个控件可以附加到单个 LDAP message。 控件只影响它所附加到的message的语义。
总结： 
        Controls可以扩展现有LDAP操作的语义和参数
        Controls只影响它所附加到的message的语义

Controls sent by clients are termed 'request controls', and those sent by servers are termed 'response controls'.
client 发送的 Controls 称为“(request controls)请求控件”，
server 发送的 Controls 称为“(response controls)响应控件”。

```ASN.1
    Controls ::= SEQUENCE OF control Control

    Control ::= SEQUENCE {
         controlType             LDAPOID,                   #control的OID
         criticality             BOOLEAN DEFAULT FALSE,     #布尔值，默认false
         controlValue            OCTET STRING OPTIONAL }
```

The controlType field is the dotted-decimal representation of an OBJECT IDENTIFIER that uniquely identifies the control.  This provides unambiguous naming of controls.  Often, response control(s) solicited by a request control share controlType values with the request control.
controlType字段 是唯一标识 control 的 OBJECT IDENTIFIER(OID) 的 点分十进制表示。 
这提供了明确的control命名。通常，请求控件  请求的响应控件 与请求控件 共享controlType 值。
总结： 
    Control的 controlType字段 的值     是该control的OID 的 点分十进制字符串表示
    response control和request control使用相同的 controlType值

The criticality field only has meaning in controls attached to request messages (except UnbindRequest).  For controls attached to response messages and the UnbindRequest, the criticality field SHOULD be FALSE, and MUST be ignored by the receiving protocol peer.  A value of TRUE indicates that it is unacceptable to perform the operation without applying the semantics of the control. Specifically, the criticality field is applied as follows:
关键性(criticality) 字段  仅在 控件/control 附加到 request-message中 才有意义（UnbindRequest 除外）。 
对于附加到response-message和 UnbindRequest 的控件/control，criticality字段应该是FALSE，并且(控件/control)必须被接收协议对等方忽略。 
criticality字段的值是TRUE 值表示 在不应用控件/control语义的情况下 执行操作是不可接受的。 
具体来说，criticality字段的应用如下：
总结： 
    Control的criticality字段
        仅在control附加到 request message(UnbindRequest除外)时，criticality字段 才有意义
        对于control附加到 response message和UnbindRequest时 ，criticality字段 应该设置为FALSE，并且接收方必须忽略 该control/控件
        criticality设置为TRUE，则表明：不使用 控件/control语义的情况下 不可执行操作(即 为TRUE时，必须使用control执行操作)

   - If the server does not recognize the control type, determines that it is not appropriate for the operation, or is otherwise unwilling to perform the operation with the control, and if the criticality field is TRUE, the server MUST NOT perform the operation, and for operations that have a response message, it MUST return with the resultCode set to unavailableCriticalExtension.
        如果服务器/server  不识别control/控件类型，确定它不适合操作，或者不愿意使用control/控件执行操作，并且如果criticality字段为 TRUE，
            则服务器/server 不能/禁止 执行操作，
            并且对于 具有响应消息(response message)的操作，它必须返回响应 并将 resultCode 设置为 unavailableCriticalExtension/不可用的关键扩展。
     总结：如果server 
             不能够识别control的类型 / control不适合操作 / 不愿意使用control执行操作，并且criticality设置为 TRUE
                 则server不能执行操作
                 并且将resultCode字段设置为 unavailableCriticalExtension


   - If the server does not recognize the control type, determines that it is not appropriate for the operation, or is otherwise unwilling to perform the operation with the control, and if the criticality field is FALSE, the server MUST ignore the control.
        如果服务器不识别控件类型，确定它不适合操作，或者不愿意用控件执行操作，并且如果criticality/关键性 字段为 FALSE，
            则服务器必须忽略控件。
     总结：如果server 
             不能够识别control的类型/control不适合操作/不愿意使用control执行操作，并且criticality设置为 FALSE
             则server必须忽略control

   - Regardless of criticality, if a control is applied to an operation, it is applied consistently and impartially to the entire operation.
        无论关键程度如何，如果将control应用于一项操作，它就会一致且公正地应用于整个操作。

The controlValue may contain information associated with the controlType.  Its format is defined by the specification of the control.  Implementations MUST be prepared to handle arbitrary contents of the controlValue octet string, including zero bytes.  It is absent only if there is no value information that is associated with a control of its type.  When a controlValue is defined in terms of ASN.1, and BER-encoded according to Section 5.1, it also follows the extensibility rules in Section 4.
controlValue 可能包含与 controlType 相关的信息。 它的格式由control的规范定义。 
        实现 必须准备好处理 controlValue octet string的任意内容，包括零字节。
        仅当没有与 控件/control的类型 相关联的值信息时，它才不存在。 
        当根据 ASN.1 定义 controlValue 并根据第 5.1 节进行 BER 编码时，它也遵循第 4 节中的可扩展性规则。
    总结： 
        Control的controlValue字段
            包含与controlType相关的信息
            值 是 OCTET STRING，可能是0字节
            没有和control的type相关的value-information时，才忽略它

   Servers list the controlType of request controls they recognize in  the 'supportedControl' attribute in the root DSE (Section 5.1 of  [RFC4512]).
        服务器在 root DSE([RFC4512]的第5.1节)的 “supportedControl”属性中
        列出了它们识别的 请求控件(request control) 的controlType/控件类型。

Controls SHOULD NOT be combined unless the semantics of the combination has been specified.  The semantics of control combinations, if specified, are generally found in the control specification most recently published.  When a combination of controls is encountered whose semantics are invalid, not specified (or not known), the message is considered not well-formed; thus, the operation fails with protocolError.  Controls with a criticality of FALSE may be ignored in order to arrive at a valid combination. Additionally, unless order-dependent semantics are given in a specification, the order of a combination of controls in the SEQUENCE is ignored.  Where the order is to be ignored but cannot be ignored by the server, the message is considered not well-formed, and the operation fails with protocolError.  Again, controls with a criticality of FALSE may be ignored in order to arrive at a valid combination.
        除非指定了组合的语义，否则不应 组合控件/Controls。 
        控件组合的语义（如果指定），通常可以在最近发布的 控件/control规范 中找到。 
        当遇到语义无效、未指定（或未知）的控件组合时，则认为message格式不正确； 因此，操作失败 并提示protocolError。 
        为了达到有效的组合，可以忽略 criticality值为FALSE 的control。 
此外，除非在规范中给出依赖于顺序的语义，否则 SEQUENCE 中控件组合的顺序将被忽略。 
        如果order/顺序要忽略但服务器不能忽略，则认为消息格式不正确，并且，操作失败 并提示protocolError。 
        同样，为了达到有效的组合，可以忽略 criticality值为FALSE的control。

This document does not specify any controls.  Controls may be specified in other documents.  Documents detailing control extensions are to provide for each control:
本文档未指定任何控件/control。 控件/control 可能在其他文件中规定。 将为每个控件提供，详细说明控件扩展的文档：

   - the OBJECT IDENTIFIER assigned to the control,
        分配给control的 OID(对象标识符)，

   - direction as to what value the sender should provide for the criticality field (note: the semantics of the criticality field are defined above should not be altered by the control's specification),
        关于发送方应该为criticality字段提供什么值的方向（注意：上面定义的criticality字段的语义不应被控件/control的规范改变），
     
   - whether the controlValue field is present, and if so, the format ofits contents,
        controlValue字段是否存在，如果存在，其内容的格式，
     
   - the semantics of the control, and
        控件的语义，以及，

   - optionally, semantics regarding the combination of the control withother controls.
        可选地，关于控件与其他控件组合的语义。



### 4.2.  Bind Operation(绑定操作(即验证身份))

The function of the Bind operation is to allow authentication information to be exchanged between the client and server.  The Bind operation should be thought of as the "authenticate" operation. Operational, authentication, and security-related semantics of this operation are given in [RFC4513].
绑定操作功能是允许 在客户端和服务器之间 交换身份认证信息。 绑定操作  应该被认为是 “认证/authenticate”操作。 [RFC4513] 中给出了该操作的：操作、认证和安全相关语义。 
总结： 
      绑定操作，主要用于 身份验证/认证

The Bind request is defined as follows:
      绑定请求(Bind request) 定义如下：

```ASN.1
    BindRequest ::= [APPLICATION 0] SEQUENCE {
         version                 INTEGER (1 ..  127),      --版本号 -- (整数)
         name                    LDAPDN,                   --DN 
         authentication          AuthenticationChoice }    --选择 认证 的方式

    AuthenticationChoice ::= CHOICE {
         simple                  [0] OCTET STRING,            	-- 简单认证
                                 -- 1 and 2 reserved 			--1 和 2 保留
         sasl                    [3] SaslCredentials,         	-- SASL认证
         ...  }

    SaslCredentials ::= SEQUENCE {                            	---SASL认证
         mechanism               LDAPString,                     --指定一个字符串，代表了 一种机制
         credentials             OCTET STRING OPTIONAL }         --证书，以 OCTET STRING编码
```

   Fields of the BindRequest are:
   BindRequest的各个字段

   - version: A version number indicating the version of the protocol to be used at the LDAP message layer.  This document describes version 3 of the protocol.  There is no version negotiation.  The client sets this field to the version it desires.  If the server does not support the specified version, it MUST respond with a BindResponse where the resultCode is set to protocolError.
     version字段：一个版本号，指示要在 LDAP消息层(LDAP message layer) 使用的协议的版本。 本文档描述了协议的第3版。 
     没有版本协商。 客户端/client 将此字段设置为其所需的版本。 如果服务器/server 不支持指定的版本，它必须以 BindResponse 响应，其中 resultCode 设置为 protocolError。 
     总结：
              BindRequest的 version字段 ，client 用于 指出它所需要的版本 (!!!)
             若是server 不支持 client指定的version，那么返回 BindResponse 并 resultCode设置为protocolError 
     
   - name: If not empty, the name of the Directory object that the client wishes to bind as.  This field may take on a null value (a zero-length string) for the purposes of anonymous binds ([RFC4513], Section 5.1) or when using SASL [RFC4422] authentication ([RFC4513], Section 5.2).  Where the server attempts to locate the named object, it SHALL NOT perform alias dereferencing.
     name字段：如果不为空，则为客户端 希望绑定的 目录对象的名称。 
     出于匿名绑定([RFC4513]，第 5.1 节)或使用 SASL[RFC4422]身份验证([RFC4513]，第 5.2节)的目的，该字段可能采用 空/null 值（长度为0的字符串）。 
     当服务器试图定位命名对象时，它不应执行别名解引用。 
     总结：
     ​	BindRequest的 name字段，
     ​		不为空 则为client希望绑定到的DN；
     ​         匿名绑定 或 SASL认证 时，name可能为null值；
     ​         当server试图定位name/DN 时， 不应该 解引用。
     ​      即：client 用于 指出 它希望绑定到的DN (!!!)
     
   - authentication: Information used in authentication.  This type is extensible as defined in Section 3.7 of [RFC4520].  Servers that do not support a choice supplied by a client return a BindResponse with the resultCode set to authMethodNotSupported.
     authentication/认证 字段：(包含了)用于认证的信息。 这种类型是可扩展的，如 [RFC4520] 的第 3.7 节中所定义。 
     若服务器不支持client提供的CHOICE，则返回一个 BindResponse，并将 resultCode 设置为 authMethodNotSupported。
     总结： 
         BindRequest的 authentication字段：
            1) client 用于指定 验证/认证方式 (!!!)
            2) 若client指定了 认证方式，但是如果server不支持 这种认证方式
                  则返回 BindResponse
                  并将 resultCode 设置为 authMethodNotSupported

Textual passwords (consisting of a character sequence with a known character set and encoding) transferred to the server using the simple AuthenticationChoice SHALL be transferred as UTF-8 [RFC3629] encoded [Unicode].  Prior to transfer, clients SHOULD prepare text passwords as "query" strings by applying the SASLprep [RFC4013] profile of the stringprep [RFC3454] algorithm.  Passwords consisting of other data (such as random octets) MUST NOT be altered.  The determination of whether a password is textual is a local client matter.
若 使用AuthenticationChoice(即authentication字段)的simple方式 将 文本/明文密码(使用 已知字符集和编码 组成的字符序列)  传输到服务器，
    那么 "应该"  使用 UTF-8[RFC3629]编码[Unicode] 传输。 
在传输之前，客户端 "应该" 通过应用 stringprep[RFC3454]算法的 SASLprep[RFC4013]配置文件，
    来准备 文本/明文密码 作为"query"字符串。 
"禁止" 更改 由其他数据（例如随机八位字节）组成的密码。 
确定密码是否为文本 是本地客户端的事情。
总结： 
    当client使用sample验证时，使用UTF-8 对 文本/明文密码进行编码传输

#### 4.2.1.  Processing of the Bind Request(处理绑定请求)

Before processing a BindRequest, all uncompleted operations MUST either complete or be abandoned.  The server may either wait for the uncompleted operations to complete, or abandon them.  The server then proceeds to authenticate the client in either a single-step or multi-step Bind process.  Each step requires the server to return a BindResponse to indicate the status of authentication.
在处理 BindRequest 之前，所有未完成的操作 必须：要么完成，要么被放弃；服务器/server 可以等待未完成的操作完成，或者放弃它们。 
然后服务器继续 以单步或多步绑定过程 对客户端进行身份验证；每一步都需要服务器返回一个 BindResponse 来指示认证的状态。
总结： 
        server 去处理 绑定请求(Bind Request)
        server 在处理BindResuest之前，对于未完成的操作 要么等待操作的完成 要么放弃操作
        然后serer执行单步绑定过程 或者  步绑定过程；每一步都需要server返回一个BindResponse 来指示认证的状态

After sending a BindRequest, clients MUST NOT send further LDAP PDUs until receiving the BindResponse.  Similarly, servers SHOULD NOT process or respond to requests received while processing a BindRequest.
client在发送 BindRequest 之后，并且在收到BindResponse之前 ， "禁止" 发送更多的 LDAP PDU。 
同样，服务器 正在处理BindRequest时， "禁止" 处理或响应 收到的请求。
总结： 
        client 发出BindRequest之后，如果还没有接收到 BindResponse，那么它不应该发送更多的LDAP-PDU ；
        server如果正在处理BindRequest，那么它不应该 处理/响应 接收到的 请求

If the client did not bind before sending a request and receives an operationsError to that request, it may then send a BindRequest.  If this also fails or the client chooses not to bind on the existing LDAP session, it may terminate the LDAP session, re-establish it, and begin again by first sending a BindRequest.  This will aid in interoperating with servers implementing other versions of LDAP.
如果client 
    1)在发送request之前没有绑定 并且 收到了 该request的 操作错误码/operationsError，
        那么它可能发送一个 BindRequest。 
    2)如果这也失败了 或者 client选择不绑定现有的 LDAP-session/会话，
        它可能会终止这个 LDAP-session/会话，
        重新建立它，
        然后通过首先发送 BindRequest 重新开始。 
这将有助于实现 与 其他LDAP版本的服务器 进行互操作。

Clients may send multiple Bind requests to change the authentication and/or security associations or to complete a multi-stage Bind process.  Authentication from earlier binds is subsequently ignored.
client 可以发送多个绑定请求(Bind request) 
    来更改身份验证  和/或 安全关联 或 完成多阶段绑定过程。 
随后忽略来自早期绑定的身份验证。

For some SASL authentication mechanisms, it may be necessary for the  client to invoke the BindRequest multiple times ([RFC4513], Section 5.2).  Clients MUST NOT invoke operations between two Bind requests made as part of a multi-stage Bind.
对于某些 SASL身份验证机制，client 可能需要多次调用 BindRequest（[RFC4513]，第 5.2 节）。 
作为多阶段绑定的一部分，的 在两个绑定请求(Bind request)之间, client不得调用(其他)操作。
总结： 
    对于SASL身份验证机制，client可能需要发送多个BindRequest
    并且 在执行多阶段绑定 的 两个绑定请求(Bind request)之间，client不得调用其他操作

A client may abort a SASL bind negotiation by sending a BindRequest with a different value in the mechanism field of SaslCredentials, or an AuthenticationChoice other than sasl.
 client可以通过发送
        1)一个 在AuthenticationChoice字段中的SaslCredentials字段中的mechanism字段的值  (与原SASL绑定协商)具有不同值的 BindRequest ；或者
        2)一个 AuthenticationChoice字段的值不是sasl；
    来 终止 SASL绑定协商。



If the client sends a BindRequest with the sasl mechanism field as an empty string, the server MUST return a BindResponse with the resultCode set to authMethodNotSupported.  This will allow the client to abort a negotiation if it wishes to try again with the same SASL mechanism.
如果client发送一个BindRequest 并且其中的 sasl 's' mechanism字段 是个空字符串，
    server必须返回一个 BindResponse 并将 resultCode 设置为 authMethodNotSupported。 
如果client使用相同的 SASL mechanism/机制 再次尝试，这将允许client中止协商。



#### 4.2.2.  Bind Response(绑定请求的响应)

The Bind response is defined as follows.
绑定响应定义如下。

```ASN.1
    BindResponse ::= [APPLICATION 1] SEQUENCE {
         COMPONENTS OF LDAPResult,
         serverSaslCreds    [7] OCTET STRING OPTIONAL }
```
总结： 
    BindResponse是LDAPResult的组成部分

BindResponse consists simply of an indication from the server of the status of the client's request for authentication.
BindResponse仅包含
	一个 来自server的 关于client身份验证请求状态的指示。
总结： 
    BindResponse 是server返回给client的，包含了 LDAPResult + 一个状态指示
    它是 client请求身份验证 的状态指示

A successful Bind operation is indicated by a BindResponse with a resultCode set to success.  Otherwise, an appropriate result code is set in the BindResponse.  For BindResponse, the protocolError result code may be used to indicate that the version number supplied by the client is unsupported.
绑定操作成功时，由一个 BindResponse 指示 ，
​	此时BindResponse中 将resultCode 设置为 success。 
否则，在 BindResponse 中设置适当的 (result code)结果代码。 
​	例如：将 BindResponse中的result code设置为protocolError，来指示 不支持客户端提供的版本号。
总结： 
​    绑定操作成功后，
​        server将回复BindResponse，并将resultCode 设置为 success 
​    绑定失败时，
​         server将回复BindResponse，并使用protocolError 指示不支持此version   



If the client receives a BindResponse where the resultCode is set to  protocolError, it is to assume that the server does not support this version of LDAP.  While the client may be able proceed with another version of this protocol (which may or may not require closing and re-establishing the transport connection), how to proceed with another version of this protocol is beyond the scope of this document.  Clients that are unable or unwilling to proceed SHOULD terminate the LDAP session.
如果client收到一个 BindResponse，并且resultCode被设置为protocolError，则假定服务器不支持此版本/version的 LDAP。 
虽然client可能能够继续使用此协议的另一个版本/version（这可能需要或可能不需要 关闭和重新建立传输连接），但如何继续使用此协议的另一个版本超出了本文档的描述范围。 
不能或不愿继续的 client "应该" 终止LDAP会话。
总结： 
    client收到一个BindResponse，并且发现 resultCode字段的值为protocolError， 那么，就了解到server不支持 我刚刚发送时 指示的version；
    如果client不想/不能继续会话，就应该终止会话；
    关于客户端在收到protocolError时 如何选择正确的version，超出了本文档的范围；

The serverSaslCreds field is used as part of a SASL-defined bind mechanism to allow the client to authenticate the server to which it is communicating, or to perform "challenge-response" authentication. If the client bound with the simple choice, or the SASL mechanism does not require the server to return information to the client, then this field SHALL NOT be included in the BindResponse.
serverSaslCreds字段，用作 SASL定义的绑定机制 的一部分，
	以允许client对其正在通信的server进行身份验证，或执行"challenge-response"身份验证。 
	如果client绑定了simple的CHOICE，或者 SASL机制不要求server向client返回信息，则该字段不应包含在 BindResponse 中。
总结： 
	当client选择的验证机制是sasl，
        那么server 的BindResponse中将会有serverSaslCreds这个字段，用以 允许client 验证server的身份；
    当client选择的验证机制是simple，或者不允许server向client返回信息，
        那么server 的BindResponse中不应该包含serverSaslCreds这个字段；
         

### 4.3.  Unbind Operation(解除绑定)

The function of the Unbind operation is to terminate an LDAP session. The Unbind operation is not the antithesis of the Bind operation as the name implies.  The naming of these operations are historical. The Unbind operation should be thought of as the "quit" operation.
Unbind操作的功能是：终止LDAP会话。      顾名思义，Unbind操作 并不是 Bind操作 的对立面。 这些操作的命名是历史性的。 
Unbind 操作应该被认为是"quit/退出"操作。
总结： 
   Unbind操作，用来终止LDAP会话

The Unbind operation is defined as follows:
绑定操作定义如下

```ASN.1
    UnbindRequest ::= [APPLICATION 2] NULL
```

The client, upon transmission of the UnbindRequest, and the server, upon receipt of the UnbindRequest, are to gracefully terminate the LDAP session as described in Section 5.3.  Uncompleted operations are handled as specified in Section 3.1.
客户端在传输 UnbindRequest 后，服务器在接收到 UnbindRequest 时，将如第 5.3 节所述优雅地终止 LDAP 会话。 未完成的操作按照第 3.1 节中的规定处理。
总结： 
   client发出UnbindRequest，
      并且server收到UnbindRequest之后，就会终止LDAP会话
      未完成的操作按照第 3.1 节中的规定处理
         因为会话/连接 已经关闭，所以： 未完成的操作都将被放弃；如果无法被放弃，那么执行完毕



### 4.4.  Unsolicited Notification((server发送的)主动通知)

An unsolicited notification is an LDAPMessage sent from the server to the client that is not in response to any LDAPMessage received by the server.  It is used to signal an extraordinary condition in the server or in the LDAP session between the client and the server.  The notification is of an advisory nature, and the server will not expect any response to be returned from the client.
主动通知是从server发送到client的 LDAPMessage，它不是server对收到的任何LDAPMessage的 响应/response。 
它用于表示：server中 或 client与server之间的LDAP会话中 的异常情况。 
该通知具有警示性质，server不会期望从client返回任何响应。
总结： 
   Unsolicited Notification/主动通知 是server主动发送给client的
   用于告诉client：server出现了异常 或者  client和server之间的LDAP会话出现了异常

The unsolicited notification is structured as an LDAPMessage in which the messageID is zero and protocolOp is set to the extendedResp choice using the ExtendedResponse type (See Section 4.12).  The responseName field of the ExtendedResponse always contains an LDAPOID that is unique for this notification.
主动通知(unsolicited notification) 被构造为LDAPMessage，其中 messageID字段为零，并且protocolOp字段被设置为使用ExtendedResponse类型的 extendedResp选项（参见第4.12节）。 
ExtendedResponse类型的 responseName字段 始终包含此通知  唯一的LDAPOID。
总结： 
   Unsolicited Notification/主动通知 被构建为 LDAPMessage，其中：
      messageID为0
      protocolOp字段为ExtendedResponse类型的extendedResp
      ExtendedResponse的responseName字段，包含了LDAPOID

One unsolicited notification (Notice of Disconnection) is defined in this document.  The specification of an unsolicited notification consists of:
本文档中定义了一种主动通知（断开连接的通知）。 主动通知的规范包括：

   - the OBJECT IDENTIFIER assigned to the notification (to be specified in the responseName,
     分配给通知的OID (在 responseName 中指定),
     
   - the format of the contents of the responseValue (if any),
     responseValue 内容的格式（如果有），

   - the circumstances which will cause the notification to be sent, and
     导致通知被发送的情况，以及,

   - the semantics of the message.
     message/消息的语义。

总结： 
   主动通知== LDAPMessage { messageID=0;  protocolOp=extendedResp } 
   本文档中定义了一种主动通知（断开连接的通知）
   主动通知的规范： 
      1) 分配给通知的OID (在 responseName 中指定),
      2) responseValue 内容的格式（如果有），
      3) 导致通知被发送的情况，
      4) message/消息的语义



#### 4.4.1.  Notice of Disconnection(断开连接通知)

This notification may be used by the server to advise the client that the server is about to terminate the LDAP session on its own initiative.  This notification is intended to assist clients in distinguishing between an exceptional server condition and a transient network failure.  Note that this notification is not a response to an Unbind requested by the client.  Uncompleted operations are handled as specified in Section 3.1.
server可以使用此通知来通知client，server将主动终止 LDAP会话。  此通知旨在帮助client区分：server的异常状况 和 暂时的网络故障。 
请注意，此通知不是server对client的Unbind-request的响应。    未完成的操作按照第 3.1 节中的规定处理。

The responseName is 1.3.6.1.4.1.1466.20036, the responseValue field is absent, and the resultCode is used to indicate the reason for the disconnection.  When the strongerAuthRequired resultCode is returned with this message, it indicates that the server has detected that an established security association between the client and server has unexpectedly failed or been compromised.
主动断开连接通知，是一个LDAPMessage { messageID=0;  protocolOp=extendedResp } 
​	responseName字段的值为1.3.6.1.4.1.1466.20036，
​	responseValue字段不存在，
​	resultCode用于指示断开的原因。 
​		当此message的 resultCode为strongAuthRequired 时，
​		表明server已检测到 client和server之间建立的安全关联 意外失败或被破坏。

Upon transmission of the Notice of Disconnection, the server gracefully terminates the LDAP session as described in Section 5.3.
在传输了 断开连接通知 后，server会如第 5.3 节所述优雅地终止 LDAP会话。



### 4.5.  Search Operation(搜索操作)

The Search operation is used to request a server to return, subject  to access controls and other restrictions, a set of entries matching  a complex search criterion.  This can be used to read attributes from  a single entry, from entries immediately subordinate to a particular  entry, or from a whole subtree of entries.
搜索操作 用于：请求server 根据访问控制和其他限制 返回一组 匹配复杂搜索条件的 条目。 
这可用于从 单个条目、直接从属于特定条目的条目 或从 条目的整个子树 中 读取属性。
总结： 
   搜索操作，是client向server请求数据
      

#### 4.5.1.  Search Request(搜索请求)

   The Search request is defined as follows:
   搜索请求定义如下

```ASN.1
        SearchRequest ::= [APPLICATION 3] SEQUENCE {
             baseObject      LDAPDN,                  -- baseND 指定搜索的baseDN 
             scope           ENUMERATED {             -- scope  指定搜索的scope
                  baseObject              (0),        -- -- 搜索 baseDN自身
                  singleLevel             (1),        -- -- 搜索 baseDN的第一代儿子
                  wholeSubtree            (2),        -- -- 搜索 baseDN自身以及baseDN的所有子树
                  ...  },
             derefAliases    ENUMERATED {             -- 指示是否解引用别名
                  neverDerefAliases       (0),        -- -- 在搜索或定位baseDN(自身)时，不要解引用
                  derefInSearching        (1),        -- -- 在搜索baseDN的子树/下级时， 解引用 搜索范围内的任何别名 ( 1)scope是wholeSubtree时，那么会继续搜索 解引用对象的子树 2)scope是singleLevel时，那么会搜索 解引用对象本身 但不搜索解引用对象的子树 )
                  derefFindingBaseObj     (2),        -- -- 在定位baseDN对象(自身)时解引用， 但搜索baseDN的子树时不执行解引用 
                  derefAlways             (3) },      -- -- 在搜索或定位baseDN(自身)时，解引用
             sizeLimit       INTEGER (0 ..  maxInt),  -- 限制 搜索返回条目的最大个数，为0则不限制
             timeLimit       INTEGER (0 ..  maxInt),  -- 限制 搜索所允许的最大时长，为0则不限制
             typesOnly       BOOLEAN,                 -- 为TRUE，只返回属性的描述；为FALSE，返回属性的描述和值
             filter          Filter,                  -- 根据条件匹配条目
             attributes      AttributeSelection }
    
        AttributeSelection ::= SEQUENCE OF selector LDAPString
                        -- The LDAPString is constrained to
                        -- <attributeSelector> in Section 4.5.1.8

        -- /OPENLDAP_REL_ENG_2_4/libraries/libldap/filter.c 和此处相同
        -- A Filter looks like this (RFC 4511 as extended by RFC 4526):
        Filter ::= CHOICE {
             and             [0] SET SIZE (1..MAX) OF filter Filter, -- 与
             or              [1] SET SIZE (1..MAX) OF filter Filter, -- 或 
             not             [2] Filter,                             -- 非
             equalityMatch   [3] AttributeValueAssertion,            -- 相等匹配：由属性和子类型的EQUALITY匹配规则定义
             substrings      [4] SubstringFilter,                    -- 子字符串匹配：详见SubstringFilter的规则和语法定义
             greaterOrEqual  [5] AttributeValueAssertion,            -- (范围 >=)：匹配规则 由属性类型或子类型的 ORDERING匹配规则定义
             lessOrEqual     [6] AttributeValueAssertion,            -- (范围 <=)：匹配规则 由属性类型或子类型的 ORDERING和EQUALITY匹配规则定义
             present         [7] AttributeDescription,               -- 指定的属性描述 若存在于属性或子类型中，那么filter为true
             approxMatch     [8] AttributeValueAssertion,            -- 近似匹配：
             extensibleMatch [9] MatchingRuleAssertion,
             ...  }
    
        SubstringFilter ::= SEQUENCE {                               -- -- 
             type           AttributeDescription,                    -- -- 如果识别不了属性描述，filter为Undefined
             substrings     SEQUENCE SIZE (1..MAX) OF substring CHOICE {
                  initial [0] AssertionValue,  -- can occur at most once-- -- initial位于substrings的开头
                  any     [1] AssertionValue,                           -- -- 1)AssertionValue的匹配规则：由属性类型或子类型的 SUBSTR匹配规则定义 2)AssertionValue的assertion syntax(断言语法)：符合属性类型的 EQUALITY匹配规则的assertion syntax，而不是 SUBSTR匹配规则的assertion syntax
                  final   [2] AssertionValue } -- can occur at most once-- -- final位于substrings的结尾
             }
    
        MatchingRuleAssertion ::= SEQUENCE {
             matchingRule    [1] MatchingRuleId OPTIONAL,
             type            [2] AttributeDescription OPTIONAL,
             matchValue      [3] AssertionValue,
             dnAttributes    [4] BOOLEAN DEFAULT FALSE }
      
      -- Note: tags in a CHOICE are always explicit 
      -- 注意： CHOICE中的tags总是显式的
```

Note that an X.500 "list"-like operation can be emulated by the client requesting a singleLevel Search operation with a filter checking for the presence of the 'objectClass' attribute, and that an X.500 "read"-like operation can be emulated by a baseObject Search operation with the same filter.  A server that provides a gateway to X.500 is not required to use the Read or List operations, although it may choose to do so, and if it does, it must provide the same semantics as the X.500 Search operation.
请注意，client可以模拟 X.500"list"-like 操作，
   通过 过滤器检查“objectClass”属性是否存在 来请求singleLevel搜索操作，
并且 X.500 "read"-like 操作 可以由
   具有相同过滤器的 baseObject 搜索操作 模拟。 
为X.500提供网关的server 
   不需要使用Read或List操作，尽管它可以选择这样做，
   如果这样做，它必须提供与 X.500 搜索操作相同的语义。

##### 4.5.1.1.  SearchRequest.baseObject(baseDN)

The name of the base object entry (or possibly the root) relative to  which the Search is to be performed.
相对于要执行搜索的基础对象条目（或可能是根）的名称。
总结： 
	SearchRequest.baseObject即为： 搜索或者复制同步时使用的baseDN

##### 4.5.1.2.  SearchRequest.scope(scope)

Specifies the scope of the Search to be performed.  The semantics (as described in [X.511]) of the defined values of this field are:
指定(要执行的)搜索范围。 定义 该字段的值 的语义(如 [X.511] 中所述)是/如下：

baseObject: The scope is constrained to the entry named by baseObject.
范围被限制为由 baseObject 命名的条目(baseDN自身)。

singleLevel: The scope is constrained to the immediate subordinates of the entry named by baseObject.
范围被限制为由 baseObject 命名的条目的直接下级(baseDN的第一代儿子)。

wholeSubtree: The scope is constrained to the entry named by baseObject and to all its subordinates.
范围被限制为由 baseObject 命名的条目及其所有下级(baseDN自身及其所有子树)。

总结： 
   SearchRequest.scope指定了搜索的范围
      baseObject 	   -- DN自身
      singleLevel		-- DN的第一代儿子
      wholeSubtree	-- DN自身以及DN的所有子树



##### 4.5.1.3.  SearchRequest.derefAliases(是否对别名解引用)

An indicator as to whether or not alias entries (as defined in [RFC4512]) are to be dereferenced during stages of the Search operation.
该指示符用于指示：条目的别名(如[RFC4512]中定义的)是否在 搜索操作阶段 被解引用。
总结： 
   SearchRequest.derefAliases指示是否解引用条目的别名

The act of dereferencing an alias includes recursively dereferencing aliases that refer to aliases.
解引用的行为包括递归解引用别名的别名。
总结： 
   解引用 是会递归的

Servers MUST detect looping while dereferencing aliases in order to prevent denial-of-service attacks of this nature.
服务器 "必须" 在解引用别名时 检测循环，以防止这种性质的拒绝服务攻击。
总结： 
   解引用时，必须检查循环，防止被攻击

The semantics of the defined values of this field are:
定义 该字段值 的语义 是/如下：

- neverDerefAliases: Do not dereference aliases in searching or in  locating the base object of the Search.
    - neverDerefAliases: 在搜索或定位 搜索的基础对象/baseObject/baseDN 时 不解引用别名。
        	和 derefAlways 相反
- derefInSearching: While searching subordinates of the base object, dereference any alias within the search scope.  Dereferenced objects become the vertices of further search scopes where the Search operation is also applied.  If the search scope is wholeSubtree, the Search continues in the subtree(s) of any dereferenced object.  If the search scope is singleLevel, the search is applied to any dereferenced objects and is not applied to their subordinates.  Servers SHOULD eliminate duplicate entries that arise due to alias dereferencing while searching.
    - derefInSearching: 在搜索baseObject的下级/sub时，解引用搜索范围内的任何别名。 解引用的对象成为进一步搜索范围的顶点，其中也应用了搜索操作。 
        如果scope是wholeSubtree ，则搜索将在任何解引用的对象的子树中继续。 
        如果scope为singleLevel，则搜索将应用于任何解引用的对象，而不应用于其下属。 
        对由于搜索时 解引用别名而出现的重复条目，服务器 "应该" 去重。
- derefFindingBaseObj: Dereference aliases in locating the base object of the Search, but not when searching subordinates of the base object.
    - derefFindingBaseObj：在定位搜索的基础对象/baseObject时 解引用别名，但在搜索基础对象/baseObject的下级时不会。
- derefAlways: Dereference aliases both in searching and in locating the base object of the Search.
    - derefAlways：在 搜索和定位 搜索的基础对象/baseObject 时，解引用别名。

总结： 
	derefAliases字段的值
		是neverDerefAliases时：搜索或定位baseDN时，不解引用别名；
		是derefInSearching时： 在搜索baseDN的下级时，scope范围内的全部解引用；
			1)scope是wholeSubtree时，那么会继续搜索 解引用对象的子树 
			2)scope是singleLevel时，那么会搜索 解引用对象本身 但不搜索解引用对象的子树
		是derefFindingBaseObj时：定位baseDN时，解引用别名；搜索baseDN的下级时，不解引用；
		是derefAlways时：搜索和定位baseDN时，解引用别名；		



##### 4.5.1.4.  SearchRequest.sizeLimit(返回条目的上限)

A size limit that restricts the maximum number of entries to be returned as a result of the Search.  A value of zero in this field indicates that no client-requested size limit restrictions are in effect for the Search.  Servers may also enforce a maximum number of entries to return.
限制 作为搜索结果 返回的最大条目数 的大小限制。 此字段中的值为0 表示客户端的请求 并没有大小限制 影响到此搜索。 服务器还可以强制执行返回最大数量的条目。
总结： 
   限制 搜索结果 返回的最大条目数
   若是值为0，表示 不限制搜索返回的 条目个数
   服务器可以强制 返回 条目的最大个数

##### 4.5.1.5.  SearchRequest.timeLimit(搜索操作的最大时间)

A time limit that restricts the maximum time (in seconds) allowed for a Search.  A value of zero in this field indicates that no client-requested time limit restrictions are in effect for the Search. Servers may also enforce a maximum time limit for the Search.
限制 搜索所允许的最长时间（以秒为单位）的时间限制。 此字段中的值为0 表示 客户端的请求 并没有时间限制限制 影响到此搜索。 
服务器还可以强制执行搜索的最大时间限制。
总结：   
   搜索操作 所允许的最大时长
   若是值为0，那么不限制搜索时间
   服务器 可以强制执行 最大时间限制

##### 4.5.1.6.  SearchRequest.typesOnly

An indicator as to whether Search results are to contain both attribute descriptions and values, or just attribute descriptions. Setting this field to TRUE causes only attribute descriptions (and not values) to be returned.  Setting this field to FALSE causes both attribute descriptions and values to be returned.
typesOnly：是个指示符，指示 搜索结果 是包含属性描述和值 还是仅包含属性描述。 
      将此字段设置为 TRUE 会导致仅返回属性描述（而不是值）。 
      将此字段设置为 FALSE 会导致返回属性描述和值。
总结: 
   SearchRequest.typesOnly 
         为TRUE，只返回属性的描述
         为FALSE，返回属性的描述和值

##### 4.5.1.7.  SearchRequest.filter(过滤器)

A filter that defines the conditions that must be fulfilled in order for the Search to match a given entry.
过滤器 定义了  搜索匹配到给定条目 必须满足的条件。

# 阅读到此处！

The 'and', 'or', and 'not' choices can be used to form combinations of filters.  At least one filter element MUST be present in an 'and' or 'or' choice.  The others match against individual attribute values of entries in the scope of the Search.  (Implementor's note: the 'not' filter is an example of a tagged choice in an implicitly-tagged module.  In BER this is treated as if the tag were explicit.)
CHOICE中的'and'、'or' 和 'not' 选项可用于形成过滤器的组合。
       在'and'或'or'选项中必须至少出现一个过滤器元素。 
       其他 与搜索范围内 条目的各个属性值 匹配。 
         （实施者注意："not"过滤器是 隐式标记模块 中标记选择的一个示例。在 BER 中，这被视为标签是显式的。）
   总结： 
      使用 'and', 'or', 'not'组合filters

A server MUST evaluate filters according to the three-valued logic of [X.511] (1993), Clause 7.8.1.  In summary, a filter is evaluated to "TRUE", "FALSE", or "Undefined".  If the filter evaluates to TRUE for a particular entry, then the attributes of that entry are returned as part of the Search result (subject to any applicable access control restrictions).  If the filter evaluates to FALSE or Undefined, then the entry is ignored for the Search.
      服务器/server 必须根据 [X.511](1993)第7.8.1条款的 三值逻辑 评估过滤器。 
      总之，过滤器被评估为"TRUE", "FALSE", or "Undefined"。 
      如果过滤器对 特定条目 的评估结果为 TRUE，则该条目的属性将作为搜索结果的一部分返回（受任何适用的访问控制限制）。 
      如果过滤器的计算结果为 FALSE或Undefined，则搜索将忽略该条目。
   总结： 
      server根据 three-valued logic 去评估filters
      对特定条目 评估结果为
         TRUE : 该条目的属性 作为 搜索结果的一部分 返回 
         FALSE: 忽略该条目
         Undefined: 忽略该条目 

A filter of the "and" choice is TRUE if all the filters in the SET OF evaluate to TRUE, FALSE if at least one filter is FALSE, and Undefined otherwise.  A filter of the "or" choice is FALSE if all the filters in the SET OF evaluate to FALSE, TRUE if at least one filter is TRUE, and Undefined otherwise.  A filter of the 'not' choice is TRUE if the filter being negated is FALSE, FALSE if it is TRUE, and Undefined if it is Undefined.
      如果SET OF中的
         所有过滤器评估为 TRUE，则“and”选项的过滤器为 TRUE，
         如果至少一个过滤器为 FALSE，则为 FALSE，
         否则为 Undefined。 
      如果SET OF中的
         所有过滤器评估为 FALSE，则“or”选择的过滤器为 FALSE，
         如果至少一个过滤器为 TRUE，则为 TRUE，
         否则为 Undefined。 
      如果"not"过滤器
         为 FALSE，则“not”选择的过滤器为 TRUE，
         如果为 TRUE，则为 FALSE，
         如果为未定义则为 Undefined。
   总结： 
      "and""or""not" 和C语言中的 && || ～ 具有同样的含义
      当使用"and"组合filter时：        (与)
         全为TRUE，结果才为TRUE；
         只要由一个为FALSE，结果为FALSE
         其他为Undefined
      当使用"or" 组合filter时：        (或)
         全为FALSE，结果才为FALSE；
         只要由一个为TRUE，结果为TRUE
         其他为Undefined
      当使用"not"组合filter时：        (取反)
         为TRUE，结果为FALSE；
         为FALSE，结果为TRUE
         为Undefined，结果为Undefined

   A filter item evaluates to Undefined when the server would not be able to determine whether the assertion value matches an entry.
   Examples include:
      当服务器/server无法确定 断言值是否与条目匹配时，过滤器项评估为Undefined。 例子包括：
#---------------------------------------------------------------------------------------




Sermersheim                 Standards Track                    [Page 23]

RFC 4511                         LDAPv3                        June 2006


   - An attribute description in an equalityMatch, substrings, greaterOrEqual, lessOrEqual, approxMatch, or extensibleMatch filter is not recognized by the server.
   - 服务器/server无法识别 
         equalityMatch、substrings、greaterOrEqual、lessOrEqual、approxMatch 或extensibleMatch 
      过滤器 中的 属性描述。

   - The attribute type does not define the appropriate matching rule.
   - 属性类型 没有定义 合适的匹配规则。

   - A MatchingRuleId in the extensibleMatch is not recognized by the server or is not valid for the attribute type.
   - extensibleMatch 中的 MatchingRuleId 未被服务器识别 或 对属性类型无效。

   - The type of filtering requested is not implemented.
   - (server)未实现 请求的过滤类型。

   - The assertion value is invalid.
   - 断言值无效。

For example, if a server did not recognize the attribute type shoeSize, the filters (shoeSize=*), (shoeSize=12), (shoeSize>=12), and (shoeSize<=12) would each evaluate to Undefined.
      例如，
         如果服务器/server无法识别属性类型 shoesSize，
         则过滤器 (shoe Size=*)、(shoe Size=12)、(shoe Size>=12) 和 (shoeSize<=12) 
         都会评估为 Undefined .

Servers MUST NOT return errors if attribute descriptions or matching rule ids are not recognized, assertion values are invalid, or the assertion syntax is not supported.  More details of filter processing are given in Clause 7.8 of [X.511].
      如果无法识别 
         属性描述或匹配规则ID、断言值无效或不支持断言语法，
      服务器不得返回错误。 
      [X.511] 的第 7.8 节给出了过滤器处理的更多细节。

###### 4.5.1.7.1.  SearchRequest.filter.equalityMatch

   EQUALITY equality 相等

The matching rule for an equalityMatch filter is defined by the EQUALITY matching rule for the attribute type or subtype.  The filter is TRUE when the EQUALITY rule returns TRUE as applied to the attribute or subtype and the asserted value.
      equalMatch过滤器 的匹配规则 由
         属性类型或子类型的EQUALITY匹配规则 定义。 
      当 EQUALITY规则 应用于 属性或子类型和断言值 并返回TRUE时，过滤器为 TRUE。
   总结：   
      filter下的 equalityMatch的 匹配规则 
         由 属性类型和子类型的EQUALITY匹配规则 定义
      当 EQUALITY规则 应用于 属性或子类型和断言值 并返回TRUE时， --> filter为TRUE

###### 4.5.1.7.2.  SearchRequest.filter.substrings

  子字符串

   There SHALL be at most one 'initial' and at most one 'final' in the
   'substrings' of a SubstringFilter.  If 'initial' is present, it SHALL
   be the first element of 'substrings'.  If 'final' is present, it
   SHALL be the last element of 'substrings'.
      SubstringFilter 的'substrings'中
         最多有一个'initial/最初' 和 最多一个'final/最终'。 
      如果 'initial' 存在，它应该是 'substrings' 的第一个元素。 
      如果存在“final”，则它应该是“substrings”的最后一个元素。
   总结： 
      只能有一个 'initial' ,它位于 substrings的开头
      只能有一个 'final' ,  它位于 substrings的结尾

   The matching rule for an AssertionValue in a substrings filter item
   is defined by the SUBSTR matching rule for the attribute type or
   subtype.  The filter is TRUE when the SUBSTR rule returns TRUE as
   applied to the attribute or subtype and the asserted value.
      substrings过滤项中 
         AssertionValue的匹配规则 由属性类型或子类型的 SUBSTR 匹配规则定义。 
      当 SUBSTR规则 在应用于属性或子类型和断言值 并返回TRUE时，过滤器为 TRUE。
(!!!)总结： 
      filter下的 substrings中的 
         AssertionValue的 匹配规则，
            由 属性类型或子类型的 SUBSTR匹配规则定义
      当 SUBSTR规则 应用于 属性或子类型和断言值 并返回TRUE时，--> 那么filter为TRUE

   Note that the AssertionValue in a substrings filter item conforms to
   the assertion syntax of the EQUALITY matching rule for the attribute
   type rather than to the assertion syntax of the SUBSTR matching rule
   for the attribute type.  Conceptually, the entire SubstringFilter is
   converted into an assertion value of the substrings matching rule
   prior to applying the rule.
      请注意，
         substrings过滤项中 AssertionValue 
            符合属性类型的EQUALITY匹配规则 的断言语法，
            而不是属性类型的 SUBSTR匹配规则 的断言语法。 
      从概念上讲，在应用规则之前，将整个 SubstringFilter 转换为子substrings匹配规则的断言值。
(!!!)总结：
      filter下的 substrings中的
         AssertionValue的 assertion syntax(断言语法)：
            符合属性类型的 EQUALITY匹配规则的assertion syntax，
            而不是 SUBSTR匹配规则的assertion syntax
      应用(assertion syntax)规则之前
         先将整个SubstringFilter，转换为substrings匹配规则的 assertion value 
         （注意：substrings匹配规则 由 属性类型或子类型的 SUBSTR匹配规则定义）
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 24]

RFC 4511                         LDAPv3                        June 2006

###### 4.5.1.7.3.  SearchRequest.filter.greaterOrEqual

   The matching rule for a greaterOrEqual filter is defined by the
   ORDERING matching rule for the attribute type or subtype.  The filter
   is TRUE when the ORDERING rule returns FALSE as applied to the
   attribute or subtype and the asserted value.
   总结： 
      filter下的的greaterOrEqual的 匹配规则 
         由属性类型或子类型的 ORDERING 匹配规则定义
      当 ORDERING规则 应用于属性或子类型和断言值 并返回FALSE时 ，--> filter为TRUE

###### 4.5.1.7.4.  SearchRequest.filter.lessOrEqual

   The matching rules for a lessOrEqual filter are defined by the
   ORDERING and EQUALITY matching rules for the attribute type or
   subtype.  The filter is TRUE when either the ORDERING or EQUALITY
   rule returns TRUE as applied to the attribute or subtype and the
   asserted value.
   总结： 
      filter下的lessOrEqual的匹配规则 
         由属性类型或子类型的 ORDERING和EQUALITY匹配规则定义。 
      当ORDERING 或 EQUALITY规则
         在应用于属性或子类型和断言值时 并返回TRUE时，
         filter为 TRUE。

###### 4.5.1.7.5.  SearchRequest.filter.present

   A present filter is TRUE when there is an attribute or subtype of the
   specified attribute description present in an entry, FALSE when no
   attribute or subtype of the specified attribute description is
   present in an entry, and Undefined otherwise.
   总结： 
      filter下的present 
         当条目中存在 指定的属性描述的 属性或子类型时，filter为TRUE，
         当条目中不存在 指定的属性描述的 属性或子类型时 filter为FALSE，
         否则为 Undefined。
   简言之：指定的属性描述 若存在于属性或子类型中，那么filter为true

###### 4.5.1.7.6.  SearchRequest.filter.approxMatch

   An approxMatch filter is TRUE when there is a value of the attribute
   type or subtype for which some locally-defined approximate matching
   algorithm (e.g., spelling variations, phonetic match, etc.) returns
   TRUE.  If a value matches for equality, it also satisfies an
   approximate match.  If approximate matching is not supported for the
   attribute, this filter item should be treated as an equalityMatch.
   总结： 
      filter下的approxMatch 
      使用 近似匹配过滤器 approxMatch
         1) 当属性或子类型的值/value,被本地定义的近似匹配算法(例如 拼写变体 语音匹配等)返回TRUE时，则filter为TRUE
         2) 如果一个值/value匹配相等/equality，它也满足近似匹配。 
      如果属性不支持近似匹配，则应将此过滤器项视为 相等匹配/equalityMatch。

###### 4.5.1.7.7.  SearchRequest.filter.extensibleMatch

   The fields of the extensibleMatch filter item are evaluated as
   follows:
   filter的extensibleMatch字段评估如下：

   - If the matchingRule field is absent, the type field MUST be
     present, and an equality match is performed for that type.
   - 如果 matchingRule 字段不存在，则必须存在类型字段，并且对该类型执行相等匹配。

   - If the type field is absent and the matchingRule is present, the
     matchValue is compared against all attributes in an entry that
     support that matchingRule.

   - If the type field is present and the matchingRule is present, the
     matchValue is compared against the specified attribute type and its
     subtypes.
     #---------------------------------------------------------------------------------------




Sermersheim                 Standards Track                    [Page 25]

RFC 4511                         LDAPv3                        June 2006


   - If the dnAttributes field is set to TRUE, the match is additionally
     applied against all the AttributeValueAssertions in an entry's
     distinguished name, and it evaluates to TRUE if there is at least
     one attribute or subtype in the distinguished name for which the
     filter item evaluates to TRUE.  The dnAttributes field is present
     to alleviate the need for multiple versions of generic matching
     rules (such as word matching), where one applies to entries and
     another applies to entries and DN attributes as well.

   The matchingRule used for evaluation determines the syntax for the
   assertion value.  Once the matchingRule and attribute(s) have been
   determined, the filter item evaluates to TRUE if it matches at least
   one attribute type or subtype in the entry, FALSE if it does not
   match any attribute type or subtype in the entry, and Undefined if
   the matchingRule is not recognized, the matchingRule is unsuitable
   for use with the specified type, or the assertionValue is invalid.

###### 4.5.1.8.  SearchRequest.attributes

   A selection list of the attributes to be returned from each entry
   that matches the search filter.  Attributes that are subtypes of
   listed attributes are implicitly included.  LDAPString values of this
   field are constrained to the following Augmented Backus-Naur Form
   (ABNF) [RFC4234]:

      attributeSelector = attributedescription / selectorspecial
    
      selectorspecial = noattrs / alluserattrs
    
      noattrs = %x31.2E.31 ; "1.1"
    
      alluserattrs = %x2A ; asterisk ("*")
    
      The <attributedescription> production is defined in Section 2.5 of
      [RFC4512].
    
      There are three special cases that may appear in the attributes
      selection list:
    
      1. An empty list with no attributes requests the return of all
         user attributes.
    
      2. A list containing "*" (with zero or more attribute
         descriptions) requests the return of all user attributes in
         addition to other listed (operational) attributes.
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 26]

RFC 4511                         LDAPv3                        June 2006


      3. A list containing only the OID "1.1" indicates that no
         attributes are to be returned.  If "1.1" is provided with other
         attributeSelector values, the "1.1" attributeSelector is
         ignored.  This OID was chosen because it does not (and can not)
         correspond to any attribute in use.

   Client implementors should note that even if all user attributes are
   requested, some attributes and/or attribute values of the entry may
   not be included in Search results due to access controls or other
   restrictions.  Furthermore, servers will not return operational
   attributes, such as objectClasses or attributeTypes, unless they are
   listed by name.  Operational attributes are described in [RFC4512].

   Attributes are returned at most once in an entry.  If an attribute
   description is named more than once in the list, the subsequent names
   are ignored.  If an attribute description in the list is not
   recognized, it is ignored by the server.

#### 4.5.2.  Search Result

   The results of the Search operation are returned as zero or more
   SearchResultEntry and/or SearchResultReference messages, followed by
   a single SearchResultDone message.

        SearchResultEntry ::= [APPLICATION 4] SEQUENCE {
             objectName      LDAPDN,
             attributes      PartialAttributeList }
    
        PartialAttributeList ::= SEQUENCE OF
                             partialAttribute PartialAttribute
    
        SearchResultReference ::= [APPLICATION 19] SEQUENCE
                                  SIZE (1..MAX) OF uri URI
    
        SearchResultDone ::= [APPLICATION 5] LDAPResult

   Each SearchResultEntry represents an entry found during the Search.
   Each SearchResultReference represents an area not yet explored during
   the Search.  The SearchResultEntry and SearchResultReference messages
   may come in any order.  Following all the SearchResultReference and
   SearchResultEntry responses, the server returns a SearchResultDone
   response, which contains an indication of success or details any
   errors that have occurred.

   Each entry returned in a SearchResultEntry will contain all
   appropriate attributes as specified in the attributes field of the
   Search Request, subject to access control and other administrative
   policy.  Note that the PartialAttributeList may hold zero elements.
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 27]

RFC 4511                         LDAPv3                        June 2006


   This may happen when none of the attributes of an entry were
   requested or could be returned.  Note also that the partialAttribute
   vals set may hold zero elements.  This may happen when typesOnly is
   requested, access controls prevent the return of values, or other
   reasons.

   Some attributes may be constructed by the server and appear in a
   SearchResultEntry attribute list, although they are not stored
   attributes of an entry.  Clients SHOULD NOT assume that all
   attributes can be modified, even if this is permitted by access
   control.

   If the server's schema defines short names [RFC4512] for an attribute
   type, then the server SHOULD use one of those names in attribute
   descriptions for that attribute type (in preference to using the
   <numericoid> [RFC4512] format of the attribute type's object
   identifier).  The server SHOULD NOT use the short name if that name
   is known by the server to be ambiguous, or if it is otherwise likely
   to cause interoperability problems.

#### 4.5.3.  Continuation References in the Search Result

   If the server was able to locate the entry referred to by the
   baseObject but was unable or unwilling to search one or more non-
   local entries, the server may return one or more
   SearchResultReference messages, each containing a reference to
   another set of servers for continuing the operation.  A server MUST
   NOT return any SearchResultReference messages if it has not located
   the baseObject and thus has not searched any entries.  In this case,
   it would return a SearchResultDone containing either a referral or
   noSuchObject result code (depending on the server's knowledge of the
   entry named in the baseObject).

   If a server holds a copy or partial copy of the subordinate naming
   context (Section 5 of [RFC4512]), it may use the search filter to
   determine whether or not to return a SearchResultReference response.
   Otherwise, SearchResultReference responses are always returned when
   in scope.

   The SearchResultReference is of the same data type as the Referral.

   If the client wishes to progress the Search, it issues a new Search
   operation for each SearchResultReference that is returned.  If
   multiple URIs are present, the client assumes that any supported URI
   may be used to progress the operation.
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 28]

RFC 4511                         LDAPv3                        June 2006


   Clients that follow search continuation references MUST ensure that
   they do not loop between servers.  They MUST NOT repeatedly contact
   the same server for the same request with the same parameters.  Some
   clients use a counter that is incremented each time search result
   reference handling occurs for an operation, and these kinds of
   clients MUST be able to handle at least ten nested referrals while
   progressing the operation.

   Note that the Abandon operation described in Section 4.11 applies
   only to a particular operation sent at the LDAP message layer between
   a client and server.  The client must individually abandon subsequent
   Search operations it wishes to.

   A URI for a server implementing LDAP and accessible via TCP/IP (v4 or
   v6) [RFC793][RFC791] is written as an LDAP URL according to
   [RFC4516].

   SearchResultReference values that are LDAP URLs follow these rules:

   - The <dn> part of the LDAP URL MUST be present, with the new target
     object name.  The client uses this name when following the
     reference.

   - Some servers (e.g., participating in distributed indexing) may
     provide a different filter in the LDAP URL.

   - If the <filter> part of the LDAP URL is present, the client uses
     this filter in its next request to progress this Search, and if it
     is not present the client uses the same filter as it used for that
     Search.

   - If the originating search scope was singleLevel, the <scope> part
     of the LDAP URL will be "base".

   - It is RECOMMENDED that the <scope> part be present to avoid
     ambiguity.  In the absence of a <scope> part, the scope of the
     original Search request is assumed.

   - Other aspects of the new Search request may be the same as or
     different from the Search request that generated the
     SearchResultReference.

   - The name of an unexplored subtree in a SearchResultReference need
     not be subordinate to the base object.

   Other kinds of URIs may be returned.  The syntax and semantics of
   such URIs is left to future specifications.  Clients may ignore URIs
   that they do not support.
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 29]

RFC 4511                         LDAPv3                        June 2006


   UTF-8-encoded characters appearing in the string representation of a
   DN, search filter, or other fields of the referral value may not be
   legal for URIs (e.g., spaces) and MUST be escaped using the % method
   in [RFC3986].

##### 4.5.3.1.  Examples

   For example, suppose the contacted server (hosta) holds the entry
   <DC=Example,DC=NET> and the entry <CN=Manager,DC=Example,DC=NET>.  It
   knows that both LDAP servers (hostb) and (hostc) hold
   <OU=People,DC=Example,DC=NET> (one is the master and the other server
   a shadow), and that LDAP-capable server (hostd) holds the subtree
   <OU=Roles,DC=Example,DC=NET>.  If a wholeSubtree Search of
   <DC=Example,DC=NET> is requested to the contacted server, it may
   return the following:

     SearchResultEntry for DC=Example,DC=NET
     SearchResultEntry for CN=Manager,DC=Example,DC=NET
     SearchResultReference {
       ldap://hostb/OU=People,DC=Example,DC=NET??sub
       ldap://hostc/OU=People,DC=Example,DC=NET??sub }
     SearchResultReference {
       ldap://hostd/OU=Roles,DC=Example,DC=NET??sub }
     SearchResultDone (success)

   Client implementors should note that when following a
   SearchResultReference, additional SearchResultReference may be
   generated.  Continuing the example, if the client contacted the
   server (hostb) and issued the Search request for the subtree
   <OU=People,DC=Example,DC=NET>, the server might respond as follows:

```ASN.1
 SearchResultEntry for OU=People,DC=Example,DC=NET
 SearchResultReference {
   ldap://hoste/OU=Managers,OU=People,DC=Example,DC=NET??sub }
 SearchResultReference {
   ldap://hostf/OU=Consultants,OU=People,DC=Example,DC=NET??sub }
 SearchResultDone (success)
```

   Similarly, if a singleLevel Search of <DC=Example,DC=NET> is
   requested to the contacted server, it may return the following:

     SearchResultEntry for CN=Manager,DC=Example,DC=NET
     SearchResultReference {
       ldap://hostb/OU=People,DC=Example,DC=NET??base
       ldap://hostc/OU=People,DC=Example,DC=NET??base }
     SearchResultReference {
       ldap://hostd/OU=Roles,DC=Example,DC=NET??base }
     SearchResultDone (success)
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 30]

RFC 4511                         LDAPv3                        June 2006


   If the contacted server does not hold the base object for the Search,
   but has knowledge of its possible location, then it may return a
   referral to the client.  In this case, if the client requests a
   subtree Search of <DC=Example,DC=ORG> to hosta, the server returns a
   SearchResultDone containing a referral.

     SearchResultDone (referral) {
       ldap://hostg/DC=Example,DC=ORG??sub }

### 4.6.  Modify Operation

   The Modify operation allows a client to request that a modification
   of an entry be performed on its behalf by a server.  The Modify
   Request is defined as follows:
       修改操作 允许客户端 请求 由服务器代表其执行 条目的修改。 修改请求定义如下：

        ModifyRequest ::= [APPLICATION 6] SEQUENCE {
             object          LDAPDN,
             changes         SEQUENCE OF change SEQUENCE {
                  operation       ENUMERATED {
                       add     (0),
                       delete  (1),
                       replace (2),
                       ...  },
                  modification    PartialAttribute } }

   Fields of the Modify Request are:
        修改请求的字段是：

   - object: The value of this field contains the name of the entry to
     be modified.  The server SHALL NOT perform any alias dereferencing
     in determining the object to be modified.
        object：
            该字段的值 包含 要修改的条目的 名称/DN。 
            服务器不应 在确定要修改的对象时 执行任何别名解引用。

   - changes: A list of modifications to be performed on the entry.  The
     entire list of modifications MUST be performed in the order they
     are listed as a single atomic operation.  While individual
     modifications may violate certain aspects of the directory schema
     (such as the object class definition and Directory Information Tree
     (DIT) content rule), the resulting entry after the entire list of
     modifications is performed MUST conform to the requirements of the
     directory model and controlling schema [RFC4512].
        changes：
            要对条目执行的 修改列表。 
            作为一个单原子操作 整个修改列表 必须按照它们  列出的顺序执行。 
            虽然个别修改 可能违反目录模式/schema的某些方面(例如对象类定义和目录信息树(DIT)内容规则），
            但 执行整个修改列表后的 结果条目 必须符合 目录模型 和控制模式 的要求[RFC4512]。


     -  operation: Used to specify the type of modification being
        performed.  Each operation type acts on the following
        modification.  The values of this field have the following
        semantics, respectively:
        operation：
            用于指定 将要被执行的 修改类型。
            每个操作类型 都作用于 以下修改。 
            该字段的值分别具有以下语义：
    
           add: add values listed to the modification attribute,
           creating the attribute if necessary.
            add: 
                将 列出的值 添加到 (要修改的/)修改 属性中，
                必要时创建该属性。
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 31]

RFC 4511                         LDAPv3                        June 2006


           delete: delete values listed from the modification attribute.
           If no values are listed, or if all current values of the
           attribute are listed, the entire attribute is removed.
            delete: 
                从 修改属性 中 删除 列出的值。 
                如果 未列出任何值，或者 列出了该属性的所有当前值，则会删除整个属性。
    
           replace: replace all existing values of the modification
           attribute with the new values listed, creating the attribute
           if it did not already exist.  A replace with no value will
           delete the entire attribute if it exists, and it is ignored
           if the attribute does not exist.
            replace: 
                对修改属性 
                    用 列出的新值 替换 所有现有值，
                    如果该属性不存在 则创建该属性。 
                一个不含任何值/value的替换/replace
                    如果属性存在，那么将删除整个属性，
                    如果属性不存在，则忽略 这个替换。
    
     -  modification: A PartialAttribute (which may have an empty SET
        of vals) used to hold the attribute type or attribute type and
        values being modified.
         modification: 
            用于保存 PartialAttribute的 被修改的 “属性类型”或“属性类型和值”
            （PartialAttribute 的值 可能是一个空值）。

   Upon receipt of a Modify Request, the server attempts to perform the
   necessary modifications to the DIT and returns the result in a Modify
   Response, defined as follows:
        一旦收到 修改请求，
            服务器尝试对DIT执行必要的修改，并在修改响应中返回结果，定义如下：
        Upon receipt：一旦收到...

        ModifyResponse ::= [APPLICATION 7] LDAPResult

   The server will return to the client a single Modify Response
   indicating either the successful completion of the DIT modification,
   or the reason that the modification failed.  Due to the requirement
   for atomicity in applying the list of modifications in the Modify
   Request, the client may expect that no modifications of the DIT have
   been performed if the Modify Response received indicates any sort of
   error, and that all requested modifications have been performed if
   the Modify Response indicates successful completion of the Modify
   operation.  Whether or not the modification was applied cannot be
   determined by the client if the Modify Response was not received
   (e.g., the LDAP session was terminated or the Modify operation was
   abandoned).
      服务器将向客户端返回 单个修改响应，
         指示 DIT修改成功完成 或 修改失败的原因。 
      由于 在修改请求中 应用修改列表时 原子性的要求，
         如果 收到的 修改响应 指示任何类型的错误，客户端可能期望没有对DIT执行修改，
         如果 修改响应 表示 修改操作成功完成， 那么表示 所有 请求的修改 都已执行
      如果 没有收到 修改响应（例如，LDAP会话终止 或 修改操作被放弃），
         客户端无法确定是否修改。 

   Servers MUST ensure that entries conform to user and system schema
   rules or other data model constraints.  The Modify operation cannot
   be used to remove from an entry any of its distinguished values,
   i.e., those values which form the entry's relative distinguished
   name.  An attempt to do so will result in the server returning the
   notAllowedOnRDN result code.  The Modify DN operation described in
   Section 4.9 is used to rename an entry.
      服务器必须确保条目符合用户和系统模式规则或其他数据模型约束。 
      修改操作不能用于从条目中删除其任何可分辨值，即构成条目相对可分辨名称的那些值。 
      尝试这样做将导致服务器返回 notAllowedOnRDN 结果代码。 
      第 4.9 节中描述的修改 DN 操作用于重命名条目。

   For attribute types that specify no equality matching, the rules in
   Section 2.5.1 of [RFC4512] are followed.

   Note that due to the simplifications made in LDAP, there is not a
   direct mapping of the changes in an LDAP ModifyRequest onto the
   changes of a DAP ModifyEntry operation, and different implementations
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 32]

RFC 4511                         LDAPv3                        June 2006


   of LDAP-DAP gateways may use different means of representing the
   change.  If successful, the final effect of the operations on the
   entry MUST be identical.

### 4.7.  Add Operation

   The Add operation allows a client to request the addition of an entry
   into the Directory.  The Add Request is defined as follows:

        AddRequest ::= [APPLICATION 8] SEQUENCE {
             entry           LDAPDN,
             attributes      AttributeList }
    
        AttributeList ::= SEQUENCE OF attribute Attribute

   Fields of the Add Request are:

   - entry: the name of the entry to be added.  The server SHALL NOT
     dereference any aliases in locating the entry to be added.

   - attributes: the list of attributes that, along with those from the
     RDN, make up the content of the entry being added.  Clients MAY or
     MAY NOT include the RDN attribute(s) in this list.  Clients MUST
     NOT supply NO-USER-MODIFICATION attributes such as the
     createTimestamp or creatorsName attributes, since the server
     maintains these automatically.

   Servers MUST ensure that entries conform to user and system schema
   rules or other data model constraints.  For attribute types that
   specify no equality matching, the rules in Section 2.5.1 of [RFC4512]
   are followed (this applies to the naming attribute in addition to any
   multi-valued attributes being added).

   The entry named in the entry field of the AddRequest MUST NOT exist
   for the AddRequest to succeed.  The immediate superior (parent) of an
   object or alias entry to be added MUST exist.  For example, if the
   client attempted to add <CN=JS,DC=Example,DC=NET>, the
   <DC=Example,DC=NET> entry did not exist, and the <DC=NET> entry did
   exist, then the server would return the noSuchObject result code with
   the matchedDN field containing <DC=NET>.

   Upon receipt of an Add Request, a server will attempt to add the
   requested entry.  The result of the Add attempt will be returned to
   the client in the Add Response, defined as follows:

        AddResponse ::= [APPLICATION 9] LDAPResult
#---------------------------------------------------------------------------------------




Sermersheim                 Standards Track                    [Page 33]

RFC 4511                         LDAPv3                        June 2006


   A response of success indicates that the new entry has been added to
   the Directory.

### 4.8.  Delete Operation

   The Delete operation allows a client to request the removal of an
   entry from the Directory.  The Delete Request is defined as follows:

        DelRequest ::= [APPLICATION 10] LDAPDN

   The Delete Request consists of the name of the entry to be deleted.
   The server SHALL NOT dereference aliases while resolving the name of
   the target entry to be removed.

   Only leaf entries (those with no subordinate entries) can be deleted
   with this operation.

   Upon receipt of a Delete Request, a server will attempt to perform
   the entry removal requested and return the result in the Delete
   Response defined as follows:

        DelResponse ::= [APPLICATION 11] LDAPResult

4.9.  Modify DN Operation

   The Modify DN operation allows a client to change the Relative
   Distinguished Name (RDN) of an entry in the Directory and/or to move
   a subtree of entries to a new location in the Directory.  The Modify
   DN Request is defined as follows:

        ModifyDNRequest ::= [APPLICATION 12] SEQUENCE {
             entry           LDAPDN,
             newrdn          RelativeLDAPDN,
             deleteoldrdn    BOOLEAN,
             newSuperior     [0] LDAPDN OPTIONAL }

   Fields of the Modify DN Request are:

   - entry: the name of the entry to be changed.  This entry may or may
     not have subordinate entries.

   - newrdn: the new RDN of the entry.  The value of the old RDN is
     supplied when moving the entry to a new superior without changing
     its RDN.  Attribute values of the new RDN not matching any
     attribute value of the entry are added to the entry, and an
     appropriate error is returned if this fails.
     #---------------------------------------------------------------------------------------




Sermersheim                 Standards Track                    [Page 34]

RFC 4511                         LDAPv3                        June 2006


   - deleteoldrdn: a boolean field that controls whether the old RDN
     attribute values are to be retained as attributes of the entry or
     deleted from the entry.

   - newSuperior: if present, this is the name of an existing object
     entry that becomes the immediate superior (parent) of the
     existing entry.

   The server SHALL NOT dereference any aliases in locating the objects
   named in entry or newSuperior.

   Upon receipt of a ModifyDNRequest, a server will attempt to perform
   the name change and return the result in the Modify DN Response,
   defined as follows:

        ModifyDNResponse ::= [APPLICATION 13] LDAPResult

   For example, if the entry named in the entry field was <cn=John
   Smith,c=US>, the newrdn field was <cn=John Cougar Smith>, and the
   newSuperior field was absent, then this operation would attempt to
   rename the entry as <cn=John Cougar Smith,c=US>.  If there was
   already an entry with that name, the operation would fail with the
   entryAlreadyExists result code.

   Servers MUST ensure that entries conform to user and system schema
   rules or other data model constraints.  For attribute types that
   specify no equality matching, the rules in Section 2.5.1 of [RFC4512]
   are followed (this pertains to newrdn and deleteoldrdn).

   The object named in newSuperior MUST exist.  For example, if the
   client attempted to add <CN=JS,DC=Example,DC=NET>, the
   <DC=Example,DC=NET> entry did not exist, and the <DC=NET> entry did
   exist, then the server would return the noSuchObject result code with
   the matchedDN field containing <DC=NET>.

   If the deleteoldrdn field is TRUE, the attribute values forming the
   old RDN (but not the new RDN) are deleted from the entry.  If the
   deleteoldrdn field is FALSE, the attribute values forming the old RDN
   will be retained as non-distinguished attribute values of the entry.

   Note that X.500 restricts the ModifyDN operation to affect only
   entries that are contained within a single server.  If the LDAP
   server is mapped onto DAP, then this restriction will apply, and the
   affectsMultipleDSAs result code will be returned if this error
   occurred.  In general, clients MUST NOT expect to be able to perform
   arbitrary movements of entries and subtrees between servers or
   between naming contexts.
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 35]

RFC 4511                         LDAPv3                        June 2006

### 4.10.  Compare Operation

   The Compare operation allows a client to compare an assertion value
   with the values of a particular attribute in a particular entry in
   the Directory.  The Compare Request is defined as follows:

        CompareRequest ::= [APPLICATION 14] SEQUENCE {
             entry           LDAPDN,
             ava             AttributeValueAssertion }

   Fields of the Compare Request are:

   - entry: the name of the entry to be compared.  The server SHALL NOT
     dereference any aliases in locating the entry to be compared.

   - ava: holds the attribute value assertion to be compared.

   Upon receipt of a Compare Request, a server will attempt to perform
   the requested comparison and return the result in the Compare
   Response, defined as follows:

        CompareResponse ::= [APPLICATION 15] LDAPResult

   The resultCode is set to compareTrue, compareFalse, or an appropriate
   error.  compareTrue indicates that the assertion value in the ava
   field matches a value of the attribute or subtype according to the
   attribute's EQUALITY matching rule.  compareFalse indicates that the
   assertion value in the ava field and the values of the attribute or
   subtype did not match.  Other result codes indicate either that the
   result of the comparison was Undefined (Section 4.5.1.7), or that
   some error occurred.

   Note that some directory systems may establish access controls that
   permit the values of certain attributes (such as userPassword) to be
   compared but not interrogated by other means.

### 4.11.  Abandon Operation

   The function of the Abandon operation is to allow a client to request
   that the server abandon an uncompleted operation.  The Abandon
   Request is defined as follows:

        AbandonRequest ::= [APPLICATION 16] MessageID

   The MessageID is that of an operation that was requested earlier at
   this LDAP message layer.  The Abandon request itself has its own
   MessageID.  This is distinct from the MessageID of the earlier
   operation being abandoned.
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 36]

RFC 4511                         LDAPv3                        June 2006


   There is no response defined in the Abandon operation.  Upon receipt
   of an AbandonRequest, the server MAY abandon the operation identified
   by the MessageID.  Since the client cannot tell the difference
   between a successfully abandoned operation and an uncompleted
   operation, the application of the Abandon operation is limited to
   uses where the client does not require an indication of its outcome.

   Abandon, Bind, Unbind, and StartTLS operations cannot be abandoned.

   In the event that a server receives an Abandon Request on a Search
   operation in the midst of transmitting responses to the Search, that
   server MUST cease transmitting entry responses to the abandoned
   request immediately, and it MUST NOT send the SearchResultDone.  Of
   course, the server MUST ensure that only properly encoded LDAPMessage
   PDUs are transmitted.

   The ability to abandon other (particularly update) operations is at
   the discretion of the server.

   Clients should not send Abandon requests for the same operation
   multiple times, and they MUST also be prepared to receive results
   from operations they have abandoned (since these might have been in
   transit when the Abandon was requested or might not be able to be
   abandoned).

   Servers MUST discard Abandon requests for messageIDs they do not
   recognize, for operations that cannot be abandoned, and for
   operations that have already been abandoned.

### 4.12.  Extended Operation

   The Extended operation allows additional operations to be defined for
   services not already available in the protocol; for example, to Add
   operations to install transport layer security (see Section 4.14).

   The Extended operation allows clients to make requests and receive
   responses with predefined syntaxes and semantics.  These may be
   defined in RFCs or be private to particular implementations.

   Each Extended operation consists of an Extended request and an
   Extended response.

```ASN.1
    ExtendedRequest ::= [APPLICATION 23] SEQUENCE {
         requestName      [0] LDAPOID,
         requestValue     [1] OCTET STRING OPTIONAL }
```

#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 37]

RFC 4511                         LDAPv3                        June 2006


   The requestName is a dotted-decimal representation of the unique
   OBJECT IDENTIFIER corresponding to the request.  The requestValue is
   information in a form defined by that request, encapsulated inside an
   OCTET STRING.

   The server will respond to this with an LDAPMessage containing an
   ExtendedResponse.

```ASN.1
    ExtendedResponse ::= [APPLICATION 24] SEQUENCE {
         COMPONENTS OF LDAPResult,
         responseName     [10] LDAPOID OPTIONAL,
         responseValue    [11] OCTET STRING OPTIONAL }
```

   The responseName field, when present, contains an LDAPOID that is
   unique for this extended operation or response.  This field is
   optional (even when the extension specification defines an LDAPOID
   for use in this field).  The field will be absent whenever the server
   is unable or unwilling to determine the appropriate LDAPOID to
   return, for instance, when the requestName cannot be parsed or its
   value is not recognized.

   Where the requestName is not recognized, the server returns
   protocolError.  (The server may return protocolError in other cases.)

   The requestValue and responseValue fields contain information
   associated with the operation.  The format of these fields is defined
   by the specification of the Extended operation.  Implementations MUST
   be prepared to handle arbitrary contents of these fields, including
   zero bytes.  Values that are defined in terms of ASN.1 and BER-
   encoded according to Section 5.1 also follow the extensibility rules
   in Section 4.

   Servers list the requestName of Extended Requests they recognize in
   the 'supportedExtension' attribute in the root DSE (Section 5.1 of
   [RFC4512]).

   Extended operations may be specified in other documents.  The
   specification of an Extended operation consists of:

   - the OBJECT IDENTIFIER assigned to the requestName,

   - the OBJECT IDENTIFIER (if any) assigned to the responseName (note
     that the same OBJECT IDENTIFIER may be used for both the
     requestName and responseName),
     #---------------------------------------------------------------------------------------






Sermersheim                 Standards Track                    [Page 38]

RFC 4511                         LDAPv3                        June 2006


   - the format of the contents of the requestValue and responseValue
     (if any), and

   - the semantics of the operation.

### 4.13.  IntermediateResponse Message

   While the Search operation provides a mechanism to return multiple
   response messages for a single Search request, other operations, by
   nature, do not provide for multiple response messages.

   The IntermediateResponse message provides a general mechanism for
   defining single-request/multiple-response operations in LDAP.  This
   message is intended to be used in conjunction with the Extended
   operation to define new single-request/multiple-response operations
   or in conjunction with a control when extending existing LDAP
   operations in a way that requires them to return Intermediate
   response information.

   It is intended that the definitions and descriptions of Extended
   operations and controls that make use of the IntermediateResponse
   message will define the circumstances when an IntermediateResponse
   message can be sent by a server and the associated meaning of an
   IntermediateResponse message sent in a particular circumstance.

        IntermediateResponse ::= [APPLICATION 25] SEQUENCE {
                responseName     [0] LDAPOID OPTIONAL,
                responseValue    [1] OCTET STRING OPTIONAL }

   IntermediateResponse messages SHALL NOT be returned to the client
   unless the client issues a request that specifically solicits their
   return.  This document defines two forms of solicitation: Extended
   operation and request control.  IntermediateResponse messages are
   specified in documents describing the manner in which they are
   solicited (i.e., in the Extended operation or request control
   specification that uses them).  These specifications include:

   - the OBJECT IDENTIFIER (if any) assigned to the responseName,

   - the format of the contents of the responseValue (if any), and

   - the semantics associated with the IntermediateResponse message.

   Extensions that allow the return of multiple types of
   IntermediateResponse messages SHALL identify those types using unique
   responseName values (note that one of these may specify no value).
#---------------------------------------------------------------------------------------




Sermersheim                 Standards Track                    [Page 39]

RFC 4511                         LDAPv3                        June 2006


   Sections 4.13.1 and 4.13.2 describe additional requirements on the
   inclusion of responseName and responseValue in IntermediateResponse
   messages.

#### 4.13.1.  Usage with LDAP ExtendedRequest and ExtendedResponse

   A single-request/multiple-response operation may be defined using a
   single ExtendedRequest message to solicit zero or more
   IntermediateResponse messages of one or more kinds, followed by an
   ExtendedResponse message.

#### 4.13.2.  Usage with LDAP Request Controls

   A control's semantics may include the return of zero or more
   IntermediateResponse messages prior to returning the final result
   code for the operation.  One or more kinds of IntermediateResponse
   messages may be sent in response to a request control.

   All IntermediateResponse messages associated with request controls
   SHALL include a responseName.  This requirement ensures that the
   client can correctly identify the source of IntermediateResponse
   messages when:

   - two or more controls using IntermediateResponse messages are
     included in a request for any LDAP operation or

   - one or more controls using IntermediateResponse messages are
     included in a request with an LDAP Extended operation that uses
     IntermediateResponse messages.

### 4.14.  StartTLS Operation

   The Start Transport Layer Security (StartTLS) operation's purpose is
   to initiate installation of a TLS layer.  The StartTLS operation is
   defined using the Extended operation mechanism described in Section
   4.12.

#### 4.14.1.  StartTLS Request

   A client requests TLS establishment by transmitting a StartTLS
   request message to the server.  The StartTLS request is defined in
   terms of an ExtendedRequest.  The requestName is
   "1.3.6.1.4.1.1466.20037", and the requestValue field is always
   absent.
#---------------------------------------------------------------------------------------






Sermersheim                 Standards Track                    [Page 40]

RFC 4511                         LDAPv3                        June 2006


   The client MUST NOT send any LDAP PDUs at this LDAP message layer
   following this request until it receives a StartTLS Extended response
   and, in the case of a successful response, completes TLS
   negotiations.

   Detected sequencing problems (particularly those detailed in Section
   3.1.1 of [RFC4513]) result in the resultCode being set to
   operationsError.

   If the server does not support TLS (whether by design or by current
   configuration), it returns with the resultCode set to protocolError
   as described in Section 4.12.

#### 4.14.2.  StartTLS Response

   When a StartTLS request is received, servers supporting the operation
   MUST return a StartTLS response message to the requestor.  The
   responseName is "1.3.6.1.4.1.1466.20037" when provided (see Section
   4.12).  The responseValue is always absent.

   If the server is willing and able to negotiate TLS, it returns the
   StartTLS response with the resultCode set to success.  Upon client
   receipt of a successful StartTLS response, protocol peers may
   commence with TLS negotiation as discussed in Section 3 of [RFC4513].

   If the server is otherwise unwilling or unable to perform this
   operation, the server is to return an appropriate result code
   indicating the nature of the problem.  For example, if the TLS
   subsystem is not presently available, the server may indicate this by
   returning with the resultCode set to unavailable.  In cases where a
   non-success result code is returned, the LDAP session is left without
   a TLS layer.

#### 4.14.3.  Removal of the TLS Layer

   Either the client or server MAY remove the TLS layer and leave the
   LDAP message layer intact by sending and receiving a TLS closure
   alert.

   The initiating protocol peer sends the TLS closure alert and MUST
   wait until it receives a TLS closure alert from the other peer before
   sending further LDAP PDUs.

   When a protocol peer receives the initial TLS closure alert, it may
   choose to allow the LDAP message layer to remain intact.  In this
   case, it MUST immediately transmit a TLS closure alert.  Following
   this, it MAY send and receive LDAP PDUs.
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 41]

RFC 4511                         LDAPv3                        June 2006


   Protocol peers MAY terminate the LDAP session after sending or
   receiving a TLS closure alert.

## 5. Protocol Encoding, Connection, and Transfer

This protocol is designed to run over connection-oriented, reliable
transports, where the data stream is divided into octets (8-bit
units), with each octet and each bit being significant.

One underlying service, LDAP over TCP, is defined in Section 5.2.
This service is generally applicable to applications providing or
consuming X.500-based directory services on the Internet.  This
specification was generally written with the TCP mapping in mind.
Specifications detailing other mappings may encounter various
obstacles.

Implementations of LDAP over TCP MUST implement the mapping as
described in Section 5.2.

This table illustrates the relationship among the different layers
involved in an exchange between two protocol peers:

```
        +----------------------+
        |  LDAP message layer  |
        +----------------------+ > LDAP PDUs
        +----------------------+ < data
        |      SASL layer      |
        +----------------------+ > SASL-protected data
        +----------------------+ < data
        |       TLS layer      |
```
Application +----------------------+ > TLS-protected data
------------+----------------------+ < data
  Transport | transport connection |
            +----------------------+

### 5.1.  Protocol Encoding

   The protocol elements of LDAP SHALL be encoded for exchange using the
   Basic Encoding Rules [BER] of [ASN.1] with the following
   restrictions:

   - Only the definite form of length encoding is used.

   - OCTET STRING values are encoded in the primitive form only.

   - If the value of a BOOLEAN type is true, the encoding of the value
     octet is set to hex "FF".
     #---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 42]

RFC 4511                         LDAPv3                        June 2006


   - If a value of a type is its default value, it is absent.  Only some
     BOOLEAN and INTEGER types have default values in this protocol
     definition.

   These restrictions are meant to ease the overhead of encoding and
   decoding certain elements in BER.

   These restrictions do not apply to ASN.1 types encapsulated inside of
   OCTET STRING values, such as attribute values, unless otherwise
   stated.

### 5.2.  Transmission Control Protocol (TCP)

   The encoded LDAPMessage PDUs are mapped directly onto the TCP
   [RFC793] bytestream using the BER-based encoding described in Section
   5.1.  It is recommended that server implementations running over the
   TCP provide a protocol listener on the Internet Assigned Numbers
   Authority (IANA)-assigned LDAP port, 389 [PortReg].  Servers may
   instead provide a listener on a different port number.  Clients MUST
   support contacting servers on any valid TCP port.

### 5.3.  Termination of the LDAP session

   Termination of the LDAP session is typically initiated by the client
   sending an UnbindRequest (Section 4.3), or by the server sending a
   Notice of Disconnection (Section 4.4.1).  In these cases, each
   protocol peer gracefully terminates the LDAP session by ceasing
   exchanges at the LDAP message layer, tearing down any SASL layer,
   tearing down any TLS layer, and closing the transport connection.

   A protocol peer may determine that the continuation of any
   communication would be pernicious, and in this case, it may abruptly
   terminate the session by ceasing communication and closing the
   transport connection.

   In either case, when the LDAP session is terminated, uncompleted
   operations are handled as specified in Section 3.1.

## 6. Security Considerations

This version of the protocol provides facilities for simple
authentication using a cleartext password, as well as any SASL
[RFC4422] mechanism.  Installing SASL and/or TLS layers can provide
integrity and other data security services.

It is also permitted that the server can return its credentials to
the client, if it chooses to do so.
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 43]

RFC 4511                         LDAPv3                        June 2006

   Use of cleartext password is strongly discouraged where the
   underlying transport service cannot guarantee confidentiality and may
   result in disclosure of the password to unauthorized parties.

   Servers are encouraged to prevent directory modifications by clients
   that have authenticated anonymously [RFC4513].

   Security considerations for authentication methods, SASL mechanisms,
   and TLS are described in [RFC4513].

   Note that SASL authentication exchanges do not provide data
   confidentiality or integrity protection for the version or name
   fields of the BindRequest or the resultCode, diagnosticMessage, or
   referral fields of the BindResponse, nor for any information
   contained in controls attached to Bind requests or responses.  Thus,
   information contained in these fields SHOULD NOT be relied on unless
   it is otherwise protected (such as by establishing protections at the
   transport layer).

   Implementors should note that various security factors (including
   authentication and authorization information and data security
   services) may change during the course of the LDAP session or even
   during the performance of a particular operation.  For instance,
   credentials could expire, authorization identities or access controls
   could change, or the underlying security layer(s) could be replaced
   or terminated.  Implementations should be robust in the handling of
   changing security factors.

   In some cases, it may be appropriate to continue the operation even
   in light of security factor changes.  For instance, it may be
   appropriate to continue an Abandon operation regardless of the
   change, or to continue an operation when the change upgraded (or
   maintained) the security factor.  In other cases, it may be
   appropriate to fail or alter the processing of the operation.  For
   instance, if confidential protections were removed, it would be
   appropriate either to fail a request to return sensitive data or,
   minimally, to exclude the return of sensitive data.

   Implementations that cache attributes and entries obtained via LDAP
   MUST ensure that access controls are maintained if that information
   is to be provided to multiple clients, since servers may have access
   control policies that prevent the return of entries or attributes in
   Search results except to particular authenticated clients.  For
   example, caches could serve result information only to the client
   whose request caused it to be in the cache.
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 44]

RFC 4511                         LDAPv3                        June 2006


   Servers may return referrals or Search result references that
   redirect clients to peer servers.  It is possible for a rogue
   application to inject such referrals into the data stream in an
   attempt to redirect a client to a rogue server.  Clients are advised
   to be aware of this and possibly reject referrals when
   confidentiality measures are not in place.  Clients are advised to
   reject referrals from the StartTLS operation.

   The matchedDN and diagnosticMessage fields, as well as some
   resultCode values (e.g., attributeOrValueExists and
   entryAlreadyExists), could disclose the presence or absence of
   specific data in the directory that is subject to access and other
   administrative controls.  Server implementations should restrict
   access to protected information equally under both normal and error
   conditions.

   Protocol peers MUST be prepared to handle invalid and arbitrary-
   length protocol encodings.  Invalid protocol encodings include: BER
   encoding exceptions, format string and UTF-8 encoding exceptions,
   overflow exceptions, integer value exceptions, and binary mode on/off
   flag exceptions.  The LDAPv3 PROTOS [PROTOS-LDAP] test suite provides
   excellent examples of these exceptions and test cases used to
   discover flaws.

   In the event that a protocol peer senses an attack that in its nature
   could cause damage due to further communication at any layer in the
   LDAP session, the protocol peer should abruptly terminate the LDAP
   session as described in Section 5.3.

## 7. Acknowledgements

This document is based on RFC 2251 by Mark Wahl, Tim Howes, and Steve
Kille.  RFC 2251 was a product of the IETF ASID Working Group.

It is also based on RFC 2830 by Jeff Hodges, RL "Bob" Morgan, and
Mark Wahl.  RFC 2830 was a product of the IETF LDAPEXT Working Group.

It is also based on RFC 3771 by Roger Harrison and Kurt Zeilenga.
RFC 3771 was an individual submission to the IETF.

This document is a product of the IETF LDAPBIS Working Group.
Significant contributors of technical review and content include Kurt
Zeilenga, Steven Legg, and Hallvard Furuseth.
#---------------------------------------------------------------------------------------







Sermersheim                 Standards Track                    [Page 45]

RFC 4511                         LDAPv3                        June 2006

## 8. Normative References

[ASN.1]       ITU-T Recommendation X.680 (07/2002) | ISO/IEC 8824-
              1:2002 "Information Technology - Abstract Syntax
              Notation One (ASN.1): Specification of basic notation".

[BER]         ITU-T Rec. X.690 (07/2002) | ISO/IEC 8825-1:2002,
              "Information technology - ASN.1 encoding rules:
              Specification of Basic Encoding Rules (BER), Canonical
              Encoding Rules (CER) and Distinguished Encoding Rules
              (DER)", 2002.

[ISO10646]    Universal Multiple-Octet Coded Character Set (UCS) -
              Architecture and Basic Multilingual Plane, ISO/IEC
              10646-1 : 1993.

[RFC791]      Postel, J., "Internet Protocol", STD 5, RFC 791,
              September 1981.

[RFC793]      Postel, J., "Transmission Control Protocol", STD 7, RFC
              793, September 1981.

[RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119, March 1997.

[RFC3454]     Hoffman P. and M. Blanchet, "Preparation of
              Internationalized Strings ('stringprep')", RFC 3454,
              December 2002.

[RFC3629]     Yergeau, F., "UTF-8, a transformation format of ISO
              10646", STD 63, RFC 3629, November 2003.

[RFC3986]     Berners-Lee, T., Fielding, R., and L. Masinter,
              "Uniform Resource Identifier (URI): Generic Syntax",
              STD 66, RFC 3986, January 2005.

[RFC4013]     Zeilenga, K., "SASLprep: Stringprep Profile for User
              Names and Passwords", RFC 4013, February 2005.

[RFC4234]     Crocker, D. and P. Overell, "Augmented BNF for Syntax
              Specifications: ABNF", RFC 4234, October 2005.

[RFC4346]     Dierks, T. and E. Rescorla, "The TLS Protocol Version
              1.1", RFC 4346, March 2006.

[RFC4422]     Melnikov, A., Ed. and K. Zeilenga, Ed., "Simple
              Authentication and Security Layer (SASL)", RFC 4422,
              June 2006.
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 46]

RFC 4511                         LDAPv3                        June 2006


   [RFC4510]     Zeilenga, K., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Technical Specification Road Map", RFC
                 4510, June 2006.

   [RFC4512]     Zeilenga, K., Lightweight Directory Access Protocol
                 (LDAP): Directory Information Models", RFC 4512, June
                 2006.

   [RFC4513]     Harrison, R., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Authentication Methods and Security
                 Mechanisms", RFC 4513, June 2006.

   [RFC4514]     Zeilenga, K., Ed., "Lightweight Directory Access
                 Protocol (LDAP): String Representation of Distinguished
                 Names", RFC 4514, June 2006.

   [RFC4516]     Smith, M., Ed. and T. Howes, "Lightweight Directory
                 Access Protocol (LDAP): Uniform Resource Locator", RFC
                 4516, June 2006.

   [RFC4517]     Legg, S., Ed., "Lightweight Directory Access Protocol
                 (LDAP): Syntaxes and Matching Rules", RFC 4517, June
                 2006.

   [RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority
                 (IANA) Considerations for the Lightweight Directory
                 Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

   [Unicode]     The Unicode Consortium, "The Unicode Standard, Version
                 3.2.0" is defined by "The Unicode Standard, Version
                 3.0" (Reading, MA, Addison-Wesley, 2000. ISBN 0-201-
                 61633-5), as amended by the "Unicode Standard Annex
                 #27: Unicode 3.1"
                 (http://www.unicode.org/reports/tr27/) and by the
                 "Unicode Standard Annex #28: Unicode 3.2"
                 (http://www.unicode.org/reports/tr28/).

   [X.500]       ITU-T Rec. X.500, "The Directory: Overview of Concepts,
                 Models and Service", 1993.

   [X.511]       ITU-T Rec. X.511, "The Directory: Abstract Service
                 Definition", 1993.
#---------------------------------------------------------------------------------------








Sermersheim                 Standards Track                    [Page 47]

RFC 4511                         LDAPv3                        June 2006

## 9. Informative References

[CharModel]   Whistler, K. and M. Davis, "Unicode Technical Report
              #17, Character Encoding Model", UTR17,
              <http://www.unicode.org/unicode/reports/tr17/>, August
              2000.

[Glossary]    The Unicode Consortium, "Unicode Glossary",
              <http://www.unicode.org/glossary/>.

[PortReg]     IANA, "Port Numbers",
              <http://www.iana.org/assignments/port-numbers>.

[PROTOS-LDAP] University of Oulu, "PROTOS Test-Suite: c06-ldapv3"
              <http://www.ee.oulu.fi/research/ouspg/protos/testing/
              c06/ldapv3/>.

## 10. IANA Considerations

   The Internet Assigned Numbers Authority (IANA) has updated the LDAP
   result code registry to indicate that this document provides the
   definitive technical specification for result codes 0-36, 48-54, 64-
   70, 80-90.  It is also noted that one resultCode value
   (strongAuthRequired) has been renamed (to strongerAuthRequired).

   The IANA has also updated the LDAP Protocol Mechanism registry to
   indicate that this document and [RFC4513] provides the definitive
   technical specification for the StartTLS (1.3.6.1.4.1.1466.20037)
   Extended operation.

   IANA has assigned LDAP Object Identifier 18 [RFC4520] to identify the
   ASN.1 module defined in this document.

        Subject: Request for LDAP Object Identifier Registration
        Person & email address to contact for further information:
             Jim Sermersheim <jimse@novell.com>
        Specification: RFC 4511
        Author/Change Controller: IESG
        Comments:
             Identifies the LDAP ASN.1 module
#---------------------------------------------------------------------------------------










Sermersheim                 Standards Track                    [Page 48]

RFC 4511                         LDAPv3                        June 2006

## Appendix A.  LDAP Result Codes

   This normative appendix details additional considerations regarding
   LDAP result codes and provides a brief, general description of each
   LDAP result code enumerated in Section 4.1.9.

   Additional result codes MAY be defined for use with extensions
   [RFC4520].  Client implementations SHALL treat any result code that
   they do not recognize as an unknown error condition.

   The descriptions provided here do not fully account for result code
   substitutions used to prevent unauthorized disclosures (such as
   substitution of noSuchObject for insufficientAccessRights, or
   invalidCredentials for insufficientAccessRights).

A.1.  Non-Error Result Codes

   These result codes (called "non-error" result codes) do not indicate
   an error condition:

        success (0),
        compareFalse (5),
        compareTrue (6),
        referral (10), and
        saslBindInProgress (14).

   The success, compareTrue, and compareFalse result codes indicate
   successful completion (and, hence, are referred to as "successful"
   result codes).

   The referral and saslBindInProgress result codes indicate the client
   needs to take additional action to complete the operation.

A.2.  Result Codes

   Existing LDAP result codes are described as follows:

      success (0)
         Indicates the successful completion of an operation.  Note:
         this code is not used with the Compare operation.  See
         compareFalse (5) and compareTrue (6).
#---------------------------------------------------------------------------------------









Sermersheim                 Standards Track                    [Page 49]

RFC 4511                         LDAPv3                        June 2006


      operationsError (1)
         Indicates that the operation is not properly sequenced with
         relation to other operations (of same or different type).
    
         For example, this code is returned if the client attempts to
         StartTLS [RFC4346] while there are other uncompleted operations
         or if a TLS layer was already installed.
    
      protocolError (2)
         Indicates the server received data that is not well-formed.
    
         For Bind operation only, this code is also used to indicate
         that the server does not support the requested protocol
         version.
    
         For Extended operations only, this code is also used to
         indicate that the server does not support (by design or
         configuration) the Extended operation associated with the
         requestName.
    
         For request operations specifying multiple controls, this may
         be used to indicate that the server cannot ignore the order
         of the controls as specified, or that the combination of the
         specified controls is invalid or unspecified.
    
      timeLimitExceeded (3)
         Indicates that the time limit specified by the client was
         exceeded before the operation could be completed.
    
      sizeLimitExceeded (4)
         Indicates that the size limit specified by the client was
         exceeded before the operation could be completed.
    
      compareFalse (5)
         Indicates that the Compare operation has successfully
         completed and the assertion has evaluated to FALSE or
         Undefined.
    
      compareTrue (6)
         Indicates that the Compare operation has successfully
         completed and the assertion has evaluated to TRUE.
    
      authMethodNotSupported (7)
         Indicates that the authentication method or mechanism is not
         supported.
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 50]

RFC 4511                         LDAPv3                        June 2006


      strongerAuthRequired (8)
         Indicates the server requires strong(er) authentication in
         order to complete the operation.
    
         When used with the Notice of Disconnection operation, this
         code indicates that the server has detected that an
         established security association between the client and
         server has unexpectedly failed or been compromised.
    
      referral (10)
         Indicates that a referral needs to be chased to complete the
         operation (see Section 4.1.10).
    
      adminLimitExceeded (11)
         Indicates that an administrative limit has been exceeded.
    
      unavailableCriticalExtension (12)
         Indicates a critical control is unrecognized (see Section
         4.1.11).
    
      confidentialityRequired (13)
         Indicates that data confidentiality protections are required.
    
      saslBindInProgress (14)
         Indicates the server requires the client to send a new bind
         request, with the same SASL mechanism, to continue the
         authentication process (see Section 4.2).
    
      noSuchAttribute (16)
         Indicates that the named entry does not contain the specified
         attribute or attribute value.
    
      undefinedAttributeType (17)
         Indicates that a request field contains an unrecognized
         attribute description.
    
      inappropriateMatching (18)
         Indicates that an attempt was made (e.g., in an assertion) to
         use a matching rule not defined for the attribute type
         concerned.
    
      constraintViolation (19)
         Indicates that the client supplied an attribute value that
         does not conform to the constraints placed upon it by the
         data model.
    
         For example, this code is returned when multiple values are
         supplied to an attribute that has a SINGLE-VALUE constraint.
#---------------------------------------------------------------------------------------

Sermersheim                 Standards Track                    [Page 51]

RFC 4511                         LDAPv3                        June 2006


      attributeOrValueExists (20)
         Indicates that the client supplied an attribute or value to
         be added to an entry, but the attribute or value already
         exists.
    
      invalidAttributeSyntax (21)
         Indicates that a purported attribute value does not conform
         to the syntax of the attribute.
    
      noSuchObject (32)
         Indicates that the object does not exist in the DIT.
    
      aliasProblem (33)
         Indicates that an alias problem has occurred.  For example,
         the code may used to indicate an alias has been dereferenced
         that names no object.
    
      invalidDNSyntax (34)
         Indicates that an LDAPDN or RelativeLDAPDN field (e.g., search
         base, target entry, ModifyDN newrdn, etc.) of a request does
         not conform to the required syntax or contains attribute
         values that do not conform to the syntax of the attribute's
         type.
    
      aliasDereferencingProblem (36)
         Indicates that a problem occurred while dereferencing an
         alias.  Typically, an alias was encountered in a situation
         where it was not allowed or where access was denied.
    
      inappropriateAuthentication (48)
         Indicates the server requires the client that had attempted
         to bind anonymously or without supplying credentials to
         provide some form of credentials.
    
      invalidCredentials (49)
         Indicates that the provided credentials (e.g., the user's name
         and password) are invalid.
    
      insufficientAccessRights (50)
         Indicates that the client does not have sufficient access
         rights to perform the operation.
    
      busy (51)
         Indicates that the server is too busy to service the
         operation.
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 52]

RFC 4511                         LDAPv3                        June 2006


      unavailable (52)
         Indicates that the server is shutting down or a subsystem
         necessary to complete the operation is offline.
    
      unwillingToPerform (53)
         Indicates that the server is unwilling to perform the
         operation.
    
      loopDetect (54)
         Indicates that the server has detected an internal loop (e.g.,
         while dereferencing aliases or chaining an operation).
    
      namingViolation (64)
         Indicates that the entry's name violates naming restrictions.
    
      objectClassViolation (65)
         Indicates that the entry violates object class restrictions.
    
      notAllowedOnNonLeaf (66)
         Indicates that the operation is inappropriately acting upon a
         non-leaf entry.
    
      notAllowedOnRDN (67)
         Indicates that the operation is inappropriately attempting to
         remove a value that forms the entry's relative distinguished
         name.
    
      entryAlreadyExists (68)
         Indicates that the request cannot be fulfilled (added, moved,
         or renamed) as the target entry already exists.
    
      objectClassModsProhibited (69)
         Indicates that an attempt to modify the object class(es) of
         an entry's 'objectClass' attribute is prohibited.
    
         For example, this code is returned when a client attempts to
         modify the structural object class of an entry.
    
      affectsMultipleDSAs (71)
         Indicates that the operation cannot be performed as it would
         affect multiple servers (DSAs).
    
      other (80)
         Indicates the server has encountered an internal error.
#---------------------------------------------------------------------------------------






Sermersheim                 Standards Track                    [Page 53]

RFC 4511                         LDAPv3                        June 2006

## Appendix B.  Complete ASN.1 Definition

   This appendix is normative.

        Lightweight-Directory-Access-Protocol-V3 {1 3 6 1 1 18}
        -- Copyright (C) The Internet Society (2006).  This version of
        -- this ASN.1 module is part of RFC 4511; see the RFC itself
        -- for full legal notices.
        DEFINITIONS
        IMPLICIT TAGS
        EXTENSIBILITY IMPLIED ::=
    
        BEGIN
    
        LDAPMessage ::= SEQUENCE {
             messageID       MessageID,
             protocolOp      CHOICE {
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
             controls       [0] Controls OPTIONAL }
    
        MessageID ::= INTEGER (0 ..  maxInt)
    
        maxInt INTEGER ::= 2147483647 -- (2^^31 - 1) --
    
        LDAPString ::= OCTET STRING -- UTF-8 encoded,
                                    -- [ISO10646] characters
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 54]

RFC 4511                         LDAPv3                        June 2006


        LDAPOID ::= OCTET STRING -- Constrained to <numericoid>
                                 -- [RFC4512]
    
        LDAPDN ::= LDAPString -- Constrained to <distinguishedName>
                              -- [RFC4514]
    
        RelativeLDAPDN ::= LDAPString -- Constrained to <name-component>
                                      -- [RFC4514]
    
        AttributeDescription ::= LDAPString
                                -- Constrained to <attributedescription>
                                -- [RFC4512]
    
        AttributeValue ::= OCTET STRING
    
        AttributeValueAssertion ::= SEQUENCE {
             attributeDesc   AttributeDescription,
             assertionValue  AssertionValue }
    
        AssertionValue ::= OCTET STRING
    
        PartialAttribute ::= SEQUENCE {
             type       AttributeDescription,
             vals       SET OF value AttributeValue }
    
        Attribute ::= PartialAttribute(WITH COMPONENTS {
             ...,
             vals (SIZE(1..MAX))})
    
        MatchingRuleId ::= LDAPString
    
        LDAPResult ::= SEQUENCE {
             resultCode         ENUMERATED {
                  success                      (0),
                  operationsError              (1),
                  protocolError                (2),
                  timeLimitExceeded            (3),
                  sizeLimitExceeded            (4),
                  compareFalse                 (5),
                  compareTrue                  (6),
                  authMethodNotSupported       (7),
                  strongerAuthRequired         (8),
                       -- 9 reserved --
                  referral                     (10),
                  adminLimitExceeded           (11),
                  unavailableCriticalExtension (12),
                  confidentialityRequired      (13),
                  saslBindInProgress           (14),
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 55]

RFC 4511                         LDAPv3                        June 2006


                  noSuchAttribute              (16),
                  undefinedAttributeType       (17),
                  inappropriateMatching        (18),
                  constraintViolation          (19),
                  attributeOrValueExists       (20),
                  invalidAttributeSyntax       (21),
                       -- 22-31 unused --
                  noSuchObject                 (32),
                  aliasProblem                 (33),
                  invalidDNSyntax              (34),
                       -- 35 reserved for undefined isLeaf --
                  aliasDereferencingProblem    (36),
                       -- 37-47 unused --
                  inappropriateAuthentication  (48),
                  invalidCredentials           (49),
                  insufficientAccessRights     (50),
                  busy                         (51),
                  unavailable                  (52),
                  unwillingToPerform           (53),
                  loopDetect                   (54),
                       -- 55-63 unused --
                  namingViolation              (64),
                  objectClassViolation         (65),
                  notAllowedOnNonLeaf          (66),
                  notAllowedOnRDN              (67),
                  entryAlreadyExists           (68),
                  objectClassModsProhibited    (69),
                       -- 70 reserved for CLDAP --
                  affectsMultipleDSAs          (71),
                       -- 72-79 unused --
                  other                        (80),
                  ...  },
             matchedDN          LDAPDN,
             diagnosticMessage  LDAPString,
             referral           [3] Referral OPTIONAL }
    
        Referral ::= SEQUENCE SIZE (1..MAX) OF uri URI
    
        URI ::= LDAPString     -- limited to characters permitted in
                               -- URIs
    
        Controls ::= SEQUENCE OF control Control
    
        Control ::= SEQUENCE {
             controlType             LDAPOID,
             criticality             BOOLEAN DEFAULT FALSE,
             controlValue            OCTET STRING OPTIONAL }
#---------------------------------------------------------------------------------------



Sermersheim                 Standards Track                    [Page 56]

RFC 4511                         LDAPv3                        June 2006


        BindRequest ::= [APPLICATION 0] SEQUENCE {
             version                 INTEGER (1 ..  127),
             name                    LDAPDN,
             authentication          AuthenticationChoice }
    
        AuthenticationChoice ::= CHOICE {
             simple                  [0] OCTET STRING,
                                     -- 1 and 2 reserved
             sasl                    [3] SaslCredentials,
             ...  }
    
        SaslCredentials ::= SEQUENCE {
             mechanism               LDAPString,
             credentials             OCTET STRING OPTIONAL }
    
        BindResponse ::= [APPLICATION 1] SEQUENCE {
             COMPONENTS OF LDAPResult,
             serverSaslCreds    [7] OCTET STRING OPTIONAL }
    
        UnbindRequest ::= [APPLICATION 2] NULL
    
        SearchRequest ::= [APPLICATION 3] SEQUENCE {
             baseObject      LDAPDN,
             scope           ENUMERATED {
                  baseObject              (0),
                  singleLevel             (1),
                  wholeSubtree            (2),
                  ...  },
             derefAliases    ENUMERATED {
                  neverDerefAliases       (0),
                  derefInSearching        (1),
                  derefFindingBaseObj     (2),
                  derefAlways             (3) },
             sizeLimit       INTEGER (0 ..  maxInt),
             timeLimit       INTEGER (0 ..  maxInt),
             typesOnly       BOOLEAN,
             filter          Filter,
             attributes      AttributeSelection }
    
        AttributeSelection ::= SEQUENCE OF selector LDAPString
                       -- The LDAPString is constrained to
                       -- <attributeSelector> in Section 4.5.1.8
    
        Filter ::= CHOICE {
             and             [0] SET SIZE (1..MAX) OF filter Filter,
             or              [1] SET SIZE (1..MAX) OF filter Filter,
             not             [2] Filter,
             equalityMatch   [3] AttributeValueAssertion,
#---------------------------------------------------------------------------------------

Sermersheim                 Standards Track                    [Page 57]

RFC 4511                         LDAPv3                        June 2006


             substrings      [4] SubstringFilter,
             greaterOrEqual  [5] AttributeValueAssertion,
             lessOrEqual     [6] AttributeValueAssertion,
             present         [7] AttributeDescription,
             approxMatch     [8] AttributeValueAssertion,
             extensibleMatch [9] MatchingRuleAssertion,
             ...  }
    
        SubstringFilter ::= SEQUENCE {
             type           AttributeDescription,
             substrings     SEQUENCE SIZE (1..MAX) OF substring CHOICE {
                  initial [0] AssertionValue,  -- can occur at most once
                  any     [1] AssertionValue,
                  final   [2] AssertionValue } -- can occur at most once
             }
    
        MatchingRuleAssertion ::= SEQUENCE {
             matchingRule    [1] MatchingRuleId OPTIONAL,
             type            [2] AttributeDescription OPTIONAL,
             matchValue      [3] AssertionValue,
             dnAttributes    [4] BOOLEAN DEFAULT FALSE }
    
        SearchResultEntry ::= [APPLICATION 4] SEQUENCE {
             objectName      LDAPDN,
             attributes      PartialAttributeList }
    
        PartialAttributeList ::= SEQUENCE OF
                             partialAttribute PartialAttribute
    
        SearchResultReference ::= [APPLICATION 19] SEQUENCE
                                  SIZE (1..MAX) OF uri URI
    
        SearchResultDone ::= [APPLICATION 5] LDAPResult
    
        ModifyRequest ::= [APPLICATION 6] SEQUENCE {
             object          LDAPDN,
             changes         SEQUENCE OF change SEQUENCE {
                  operation       ENUMERATED {
                       add     (0),
                       delete  (1),
                       replace (2),
                       ...  },
                  modification    PartialAttribute } }
    
        ModifyResponse ::= [APPLICATION 7] LDAPResult
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 58]

RFC 4511                         LDAPv3                        June 2006


        AddRequest ::= [APPLICATION 8] SEQUENCE {
             entry           LDAPDN,
             attributes      AttributeList }
    
        AttributeList ::= SEQUENCE OF attribute Attribute
    
        AddResponse ::= [APPLICATION 9] LDAPResult
    
        DelRequest ::= [APPLICATION 10] LDAPDN
    
        DelResponse ::= [APPLICATION 11] LDAPResult
    
        ModifyDNRequest ::= [APPLICATION 12] SEQUENCE {
             entry           LDAPDN,
             newrdn          RelativeLDAPDN,
             deleteoldrdn    BOOLEAN,
             newSuperior     [0] LDAPDN OPTIONAL }
    
        ModifyDNResponse ::= [APPLICATION 13] LDAPResult
    
        CompareRequest ::= [APPLICATION 14] SEQUENCE {
             entry           LDAPDN,
             ava             AttributeValueAssertion }
    
        CompareResponse ::= [APPLICATION 15] LDAPResult
    
        AbandonRequest ::= [APPLICATION 16] MessageID
    
        ExtendedRequest ::= [APPLICATION 23] SEQUENCE {
             requestName      [0] LDAPOID,
             requestValue     [1] OCTET STRING OPTIONAL }
    
        ExtendedResponse ::= [APPLICATION 24] SEQUENCE {
             COMPONENTS OF LDAPResult,
             responseName     [10] LDAPOID OPTIONAL,
             responseValue    [11] OCTET STRING OPTIONAL }
    
        IntermediateResponse ::= [APPLICATION 25] SEQUENCE {
             responseName     [0] LDAPOID OPTIONAL,
             responseValue    [1] OCTET STRING OPTIONAL }
    
        END
#---------------------------------------------------------------------------------------








Sermersheim                 Standards Track                    [Page 59]

RFC 4511                         LDAPv3                        June 2006

## Appendix C.  Changes

   This appendix is non-normative.

   This appendix summarizes substantive changes made to RFC 2251, RFC
   2830, and RFC 3771.

C.1.  Changes Made to RFC 2251

   This section summarizes the substantive changes made to Sections 1,
   2, 3.1, and 4, and the remainder of RFC 2251.  Readers should
   consult [RFC4512] and [RFC4513] for summaries of changes to other
   sections.

C.1.1.  Section 1 (Status of this Memo)

   - Removed IESG note.  Post publication of RFC 2251, mandatory LDAP
     authentication mechanisms have been standardized which are
     sufficient to remove this note.  See [RFC4513] for authentication
     mechanisms.

C.1.2.  Section 3.1 (Protocol Model) and others

   - Removed notes giving history between LDAP v1, v2, and v3.  Instead,
     added sufficient language so that this document can stand on its
     own.

C.1.3.  Section 4 (Elements of Protocol)

   - Clarified where the extensibility features of ASN.1 apply to the
     protocol.  This change affected various ASN.1 types by the
     inclusion of ellipses (...) to certain elements.
   - Removed the requirement that servers that implement version 3 or
     later MUST provide the 'supportedLDAPVersion' attribute.  This
     statement provided no interoperability advantages.

C.1.4.  Section 4.1.1 (Message Envelope)

   - There was a mandatory requirement for the server to return a
     Notice of Disconnection and drop the transport connection when a
     PDU is malformed in a certain way.  This has been updated such that
     the server SHOULD return the Notice of Disconnection, and it MUST
     terminate the LDAP Session.

C.1.5.  Section 4.1.1.1 (Message ID)

   - Required that the messageID of requests MUST be non-zero as the
     zero is reserved for Notice of Disconnection.
     #---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 60]

RFC 4511                         LDAPv3                        June 2006


   - Specified when it is and isn't appropriate to return an already
     used messageID.  RFC 2251 accidentally imposed synchronous server
     behavior in its wording of this.

C.1.6.  Section 4.1.2 (String Types)

   - Stated that LDAPOID is constrained to <numericoid> from [RFC4512].

C.1.7.  Section 4.1.5.1 (Binary Option) and others

   - Removed the Binary Option from the specification.  There are
     numerous interoperability problems associated with this method of
     alternate attribute type encoding.  Work to specify a suitable
     replacement is ongoing.

C.1.8.  Section 4.1.8 (Attribute)

   - Combined the definitions of PartialAttribute and Attribute here,
     and defined Attribute in terms of PartialAttribute.

C.1.9.  Section 4.1.10 (Result Message)

   - Renamed "errorMessage" to "diagnosticMessage" as it is allowed to
     be sent for non-error results.
   - Moved some language into Appendix A, and referred the reader there.
   - Allowed matchedDN to be present for other result codes than those
     listed in RFC 2251.
   - Renamed the code "strongAuthRequired" to "strongerAuthRequired" to
     clarify that this code may often be returned to indicate that a
     stronger authentication is needed to perform a given operation.

C.1.10.  Section 4.1.11 (Referral)

   - Defined referrals in terms of URIs rather than URLs.
   - Removed the requirement that all referral URIs MUST be equally
     capable of progressing the operation.  The statement was ambiguous
     and provided no instructions on how to carry it out.
   - Added the requirement that clients MUST NOT loop between servers.
   - Clarified the instructions for using LDAPURLs in referrals, and in
     doing so added a recommendation that the scope part be present.
   - Removed imperatives which required clients to use URLs in specific
     ways to progress an operation.  These did nothing for
     interoperability.
     #---------------------------------------------------------------------------------------







Sermersheim                 Standards Track                    [Page 61]

RFC 4511                         LDAPv3                        June 2006


C.1.11.  Section 4.1.12 (Controls)

   - Specified how control values defined in terms of ASN.1 are to be
     encoded.
   - Noted that the criticality field is only applied to request
     messages (except UnbindRequest), and must be ignored when present
     on response messages and UnbindRequest.
   - Specified that non-critical controls may be ignored at the
     server's discretion.  There was confusion in the original wording
     which led some to believe that recognized controls may not be
     ignored as long as they were associated with a proper request.
   - Added language regarding combinations of controls and the ordering
     of controls on a message.
   - Specified that when the semantics of the combination of controls
     is undefined or unknown, it results in a protocolError.
   - Changed "The server MUST be prepared" to "Implementations MUST be
     prepared" in paragraph 8 to reflect that both client and server
     implementations must be able to handle this (as both parse
     controls).

C.1.12.  Section 4.2 (Bind Operation)

   - Mandated that servers return protocolError when the version is not
     supported.
   - Disambiguated behavior when the simple authentication is used, the
     name is empty, and the password is non-empty.
   - Required servers to not dereference aliases for Bind.  This was
     added for consistency with other operations and to help ensure
     data consistency.
   - Required that textual passwords be transferred as UTF-8 encoded
     Unicode, and added recommendations on string preparation.  This was
     to help ensure interoperability of passwords being sent from
     different clients.

C.1.13.  Section 4.2.1 (Sequencing of the Bind Request)

   - This section was largely reorganized for readability, and language
     was added to clarify the authentication state of failed and
     abandoned Bind operations.
   - Removed: "If a SASL transfer encryption or integrity mechanism has
     been negotiated, that mechanism does not support the changing of
     credentials from one identity to another, then the client MUST
     instead establish a new connection."
     If there are dependencies between multiple negotiations of a
     particular SASL mechanism, the technical specification for that
     SASL mechanism details how applications are to deal with them.
     LDAP should not require any special handling.
   - Dropped MUST imperative in paragraph 3 to align with [RFC2119].
#---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 62]

RFC 4511                         LDAPv3                        June 2006


   - Mandated that clients not send non-Bind operations while a Bind is
     in progress, and suggested that servers not process them if they
     are received.  This is needed to ensure proper sequencing of the
     Bind in relationship to other operations.

C.1.14.  Section 4.2.3 (Bind Response)

   - Moved most error-related text to Appendix A, and added text
     regarding certain errors used in conjunction with the Bind
     operation.
   - Prohibited the server from specifying serverSaslCreds when not
     appropriate.

C.1.15.  Section 4.3 (Unbind Operation)

   - Specified that both peers are to cease transmission and terminate
     the LDAP session for the Unbind operation.

C.1.16.  Section 4.4 (Unsolicited Notification)

   - Added instructions for future specifications of Unsolicited
     Notifications.

C.1.17.  Section 4.5.1 (Search Request)

   - SearchRequest attributes is now defined as an AttributeSelection
     type rather than AttributeDescriptionList, and an ABNF is
     provided.
   - SearchRequest attributes may contain duplicate attribute
     descriptions.  This was previously prohibited.  Now servers are
     instructed to ignore subsequent names when they are duplicated.
     This was relaxed in order to allow different short names and also
     OIDs to be requested for an attribute.
   - The present search filter now evaluates to Undefined when the
     specified attribute is not known to the server.  It used to
     evaluate to FALSE, which caused behavior inconsistent with what
     most would expect, especially when the 'not' operator was used.
   - The Filter choice SubstringFilter substrings type is now defined
     with a lower bound of 1.
   - The SubstringFilter substrings 'initial, 'any', and 'final' types
     are now AssertionValue rather than LDAPString.  Also, added
     imperatives stating that 'initial' (if present) must be listed
     first, and 'final' (if present) must be listed last.
   - Disambiguated the semantics of the derefAliases choices.  There was
     question as to whether derefInSearching applied to the base object
     in a wholeSubtree Search.
   - Added instructions for equalityMatch, substrings, greaterOrEqual,
     lessOrEqual, and approxMatch.
     #---------------------------------------------------------------------------------------


Sermersheim                 Standards Track                    [Page 63]

RFC 4511                         LDAPv3                        June 2006



C.1.18.  Section 4.5.2 (Search Result)

   - Recommended that servers not use attribute short names when it
     knows they are ambiguous or may cause interoperability problems.
   - Removed all mention of ExtendedResponse due to lack of
     implementation.

C.1.19.  Section 4.5.3 (Continuation References in the Search Result)

   - Made changes similar to those made to Section 4.1.11.

C.1.20.  Section 4.5.3.1 (Example)

   - Fixed examples to adhere to changes made to Section 4.5.3.

C.1.21.  Section 4.6 (Modify Operation)

   - Replaced AttributeTypeAndValues with Attribute as they are
     equivalent.
   - Specified the types of modification changes that might
     temporarily violate schema.  Some readers were under the impression
     that any temporary schema violation was allowed.

C.1.22.  Section 4.7 (Add Operation)

   - Aligned Add operation with X.511 in that the attributes of the RDN
     are used in conjunction with the listed attributes to create the
     entry.  Previously, Add required that the distinguished values be
     present in the listed attributes.
   - Removed requirement that the objectClass attribute MUST be
     specified as some DSE types do not require this attribute.
     Instead, generic wording was added, requiring the added entry to
     adhere to the data model.
   - Removed recommendation regarding placement of objects.  This is
     covered in the data model document.

C.1.23.  Section 4.9 (Modify DN Operation)

   - Required servers to not dereference aliases for Modify DN.  This
     was added for consistency with other operations and to help ensure
     data consistency.
   - Allow Modify DN to fail when moving between naming contexts.
   - Specified what happens when the attributes of the newrdn are not
     present on the entry.
     #---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 64]

RFC 4511                         LDAPv3                        June 2006


C.1.24.  Section 4.10 (Compare Operation)

   - Specified that compareFalse means that the Compare took place and
     the result is false.  There was confusion that led people to
     believe that an Undefined match resulted in compareFalse.
   - Required servers to not dereference aliases for Compare.  This was
     added for consistency with other operations and to help ensure
     data consistency.

C.1.25.  Section 4.11 (Abandon Operation)

   - Explained that since Abandon returns no response, clients should
     not use it if they need to know the outcome.
   - Specified that Abandon and Unbind cannot be abandoned.

C.1.26.  Section 4.12 (Extended Operation)

   - Specified how values of Extended operations defined in terms of
     ASN.1 are to be encoded.
   - Added instructions on what Extended operation specifications
     consist of.
   - Added a recommendation that servers advertise supported Extended
     operations.

C.1.27.  Section 5.2 (Transfer Protocols)

   - Moved referral-specific instructions into referral-related
     sections.

C.1.28.  Section 7 (Security Considerations)

   - Reworded notes regarding SASL not protecting certain aspects of
     the LDAP Bind messages.
   - Noted that Servers are encouraged to prevent directory
     modifications by clients that have authenticated anonymously
     [RFC4513].
   - Added a note regarding the possibility of changes to security
     factors (authentication, authorization, and data confidentiality).
   - Warned against following referrals that may have been injected in
     the data stream.
   - Noted that servers should protect information equally, whether in
     an error condition or not, and mentioned matchedDN,
     diagnosticMessage, and resultCodes specifically.
   - Added a note regarding malformed and long encodings.
#---------------------------------------------------------------------------------------






Sermersheim                 Standards Track                    [Page 65]

RFC 4511                         LDAPv3                        June 2006


C.1.29.  Appendix A (Complete ASN.1 Definition)

   - Added "EXTENSIBILITY IMPLIED" to ASN.1 definition.
   - Removed AttributeType.  It is not used.

C.2.  Changes Made to RFC 2830

   This section summarizes the substantive changes made to Sections of
   RFC 2830.  Readers should consult [RFC4513] for summaries of changes
   to other sections.

C.2.1.  Section 2.3 (Response other than "success")

   - Removed wording indicating that referrals can be returned from
     StartTLS.
   - Removed requirement that only a narrow set of result codes can be
     returned.  Some result codes are required in certain scenarios, but
     any other may be returned if appropriate.
   - Removed requirement that the ExtendedResponse.responseName MUST be
     present.  There are circumstances where this is impossible, and
     requiring this is at odds with language in Section 4.12.

C.2.1.  Section 4 (Closing a TLS Connection)

   - Reworded most of this section to align with definitions of the
     LDAP protocol layers.
   - Removed instructions on abrupt closure as this is covered in other
     areas of the document (specifically, Section 5.3)

C.3.  Changes Made to RFC 3771

   - Rewrote to fit into this document.  In general, semantics were
     preserved.  Supporting and background language seen as redundant
     due to its presence in this document was omitted.

   - Specified that Intermediate responses to a request may be of
     different types, and one of the response types may be specified to
     have no response value.
     #---------------------------------------------------------------------------------------












Sermersheim                 Standards Track                    [Page 66]

RFC 4511                         LDAPv3                        June 2006


Editor's Address

   Jim Sermersheim
   Novell, Inc.
   1800 South Novell Place
   Provo, Utah 84606, USA

   Phone: +1 801 861-3088
   EMail: jimse@novell.com
#---------------------------------------------------------------------------------------









































Sermersheim                 Standards Track                    [Page 67]

RFC 4511                         LDAPv3                        June 2006


Full Copyright Statement

   Copyright (C) The Internet Society (2006).

   This document is subject to the rights, licenses and restrictions
   contained in BCP 78, and except as set forth therein, the authors
   retain all their rights.

   This document and the information contained herein are provided on an
   "AS IS" basis and THE CONTRIBUTOR, THE ORGANIZATION HE/SHE REPRESENTS
   OR IS SPONSORED BY (IF ANY), THE INTERNET SOCIETY AND THE INTERNET
   ENGINEERING TASK FORCE DISCLAIM ALL WARRANTIES, EXPRESS OR IMPLIED,
   INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE
   INFORMATION HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED
   WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

Intellectual Property

   The IETF takes no position regarding the validity or scope of any
   Intellectual Property Rights or other rights that might be claimed to
   pertain to the implementation or use of the technology described in
   this document or the extent to which any license under such rights
   might or might not be available; nor does it represent that it has
   made any independent effort to identify any such rights.  Information
   on the procedures with respect to rights in RFC documents can be
   found in BCP 78 and BCP 79.

   Copies of IPR disclosures made to the IETF Secretariat and any
   assurances of licenses to be made available, or the result of an
   attempt made to obtain a general license or permission for the use of
   such proprietary rights by implementers or users of this
   specification can be obtained from the IETF on-line IPR repository at
   http://www.ietf.org/ipr.

   The IETF invites any interested party to bring to its attention any
   copyrights, patents or patent applications, or other proprietary
   rights that may cover technology that may be required to implement
   this standard.  Please address the information to the IETF at
   ietf-ipr@ietf.org.

Acknowledgement

   Funding for the RFC Editor function is provided by the IETF
   Administrative Support Activity (IASA).
#---------------------------------------------------------------------------------------





Sermersheim                 Standards Track                    [Page 68]

#---------------------------------------------------------------------------------------