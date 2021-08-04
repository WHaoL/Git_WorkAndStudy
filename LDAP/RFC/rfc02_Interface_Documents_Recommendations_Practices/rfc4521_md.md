





Network Working Group                                        K. Zeilenga
Request for Comments: 4521                           OpenLDAP Foundation
BCP: 118                                                       June 2006
Category: Best Current Practice


# Considerations for Lightweight Directory Access Protocol (LDAP) Extensions

## Status of This Memo(略)

   This document specifies an Internet Best Current Practices for the
   Internet Community, and requests discussion and suggestions for
   improvements.  Distribution of this memo is unlimited.

## Copyright Notice(略)

   Copyright (C) The Internet Society (2006).

# Abstract(摘要)

The Lightweight Directory Access Protocol (LDAP) is extensible.  It provides mechanisms for adding new operations, extending existing operations, and expanding user and system schemas.  This document discusses considerations for designers of LDAP extensions.
<font color=red>LDAP是可扩展的。</font>
<font color=red>它提供了: 添加新操作、扩展现有操作 以及 扩展用户/user和系统/system schema/模式的机制。</font>
<font color=red>本文档讨论了LDAP扩展设计人员应注意的事项。</font>


```bash
Table of Contents

   1. Introduction ....................................................3
      1.1. Terminology ................................................3
   2. General Considerations ..........................................4
      2.1. Scope of Extension .........................................4
      2.2. Interaction between extensions .............................4
      2.3. Discovery Mechanism ........................................4
      2.4. Internationalization Considerations ........................5
      2.5. Use of the Basic Encoding Rules ............................5
      2.6. Use of Formal Languages ....................................5
      2.7. Examples ...................................................5
      2.8. Registration of Protocol Values ............................5
   3. LDAP Operation Extensions .......................................6
      3.1. Controls ...................................................6
           3.1.1. Extending Bind Operation with Controls ..............6
           3.1.2. Extending the Start TLS Operation with Controls .....7
           3.1.3. Extending the Search Operation with Controls ........7
           3.1.4. Extending the Update Operations with Controls .......8
           3.1.5. Extending the Responseless Operations with Controls..8
      3.2. Extended Operations ........................................8
      3.3. Intermediate Responses .....................................8
      3.4. Unsolicited Notifications ..................................9
   4. Extending the LDAP ASN.1 Definition .............................9
      4.1. Result Codes ...............................................9
      4.2. LDAP Message Types .........................................9
      4.3. Authentication Methods ....................................10
      4.4. General ASN.1 Extensibility ...............................10
   5. Schema Extensions ..............................................10
      5.1. LDAP Syntaxes .............................................11
      5.2. Matching Rules ............................................11
      5.3. Attribute Types ...........................................12
      5.4. Object Classes ............................................12
   6. Other Extension Mechanisms .....................................12
      6.1. Attribute Description Options .............................12
      6.2. Authorization Identities ..................................12
      6.3. LDAP URL Extensions .......................................12
   7. Security Considerations ........................................12
   8. Acknowledgements ...............................................13
   9. References .....................................................13
      9.1. Normative References ......................................13
      9.2. Informative References ....................................15
```


# 1.  Introduction

The Lightweight Directory Access Protocol (LDAP) [RFC4510] is an extensible protocol.
<font color=red>LDAP是一个可扩展的协议。</font>

LDAP allows for new operations to be added and for existing operations to be enhanced [RFC4511].
<font color=red>operation</font>
<font color=green>LDAP允许，添加新操作/operation  和 对现有操作进行增强[RFC4511]。</font>

LDAP allows additional schema to be defined [RFC4512][RFC4517].  This can include additional object classes, attribute types, matching rules, additional syntaxes, and other elements of schema.  LDAP provides an ability to extend attribute types with options [RFC4512].
<font color=red>schema</font>
<font color=green>LDAP允许定义额外的schema[RFC4512] [RFC4517]。</font>
<font color=green>这可以包含额外的object classes, attribute types, matching rules, 额外的syntaxes, 和 scheam的其他的elements。</font>
<font color=green>LDAP提供了一个能力(去 扩展option/选项的attribute-type)。</font>

LDAP supports a Simple Authentication and Security Layer (SASL) authentication method [RFC4511][RFC4513].  SASL [RFC4422] is extensible.  LDAP may be extended to support additional authentication methods [RFC4511].
<font color=red>SASL</font>
<font color=green>LDAP支持SASL(简单验证和安全层)认证方式 [RFC4511] [RFC4513]。</font>
<font color=green>SASL[RFC4422]是可扩展的。</font>
<font color=green>LDAP可以被扩展，以支持额外的身份验证方法[RFC4511]。</font>

LDAP supports establishment of Transport Layer Security (TLS) [RFC4511][RFC4513].  TLS [RFC4346] is extensible.
<font color=red>TLS</font>
<font color=green>LDAP支持建立TLS(传输层安全)[RFC4511] [RFC4513]。</font>
<font color=green>TLS[RFC4346]是可扩展的。</font>

LDAP has an extensible Uniform Resource Locator (URL) format [RFC4516].
<font color=red>URL</font>
<font color=green>LDAP具有可扩展的URL(统一资源定位符)格式[RFC4516]。</font>

Lastly, LDAP allows for certain extensions to the protocol's Abstract Syntax Notation - One (ASN.1) [X.680] definition to be made.  This facilitates a wide range of protocol enhancements, for example, new result codes needed to support extensions to be added through extension of the protocol's ASN.1 definition.
<font color=red>ASN.1</font>
<font color=green>最后，LDAP允许对协议的ASN.1(抽象语法表示)定义进行某些扩展。</font>
<font color=green>这促进了广泛的协议增强，例如，需要新的resultCode来支持  通过 协议的ASN.1定义的扩展 来添加支持的扩展。</font>

This document describes practices that engineers should consider when designing extensions to LDAP.
<font color=red>本文档描述了 工程师在设计LDAP扩展时 应该考虑的实践。</font>

## 1.1.  Terminology(术语)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].  In this document, "the specification", as used by BCP 14, RFC 2119, refers to the engineering of LDAP extensions.
本文档中的关键字"MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"应按照BCP 14 [RFC2119]中的描述进行解释。
在本文档中，BCP 14、[RFC2119]所使用的“规范”指的是LDAP扩展的工程。

The term "Request Control" refers to a control attached to a client-generated message sent to a server.  The term "Response Control" refers to a control attached to a server-generated message sent to a client.
<font color=green>术语"Request Control"指的是，一个附加到  client产生的发送给server的message  的控件/control。</font>
<font color=green>术语"Response Control"指的是，一个附加到 server产生的发送给client的message  的控件/control。</font>

DIT stands for Directory Information Tree.
DSA stands for Directory System Agent, a server.
DSE stands for DSA-Specific Entry.
DUA stands for Directory User Agent, a client.
DN stands for Distinguished Name.
<font color=green>DIT 表示 目录信息树。</font>
<font color=green>DSA 表示 目录系统代理，一个server(即目录服务器)。</font>
<font color=green>DSE 表示 特定于DSA(目录服务器)的条目。</font>
<font color=green>DUA 表示 目录用户代理，一个client，</font>
<font color=green>DN  表示 专有名称。</font>



# 2.  General Considerations(一般考虑)

## 2.1.  Scope of Extension(扩展的范围)

Mutually agreeing peers may, within the confines of an extension, agree to significant changes in protocol semantics.  However, designers MUST consider the impact of an extension upon protocol peers that have not agreed to implement or otherwise recognize and support the extension.  Extensions MUST be "truly optional" [RFC2119].
<font color=green>在扩展的范围内，相互同意的对等方 可能同意协议语义的重大变化。</font>
<font color=green>然而，设计人员必须考虑扩展对(尚未同意实现 或 以其他方式识别和支持该扩展的)协议对等方的影响。</font>
<font color=green>扩展必须是“真正可选的/optional”[RFC2119]。</font>

## 2.2.  Interaction between extensions(扩展之间的交互)

Designers SHOULD consider how extensions they engineer interact with other extensions.
<font color=green>设计人员应该考虑,他们设计的扩展如何与其他扩展交互。</font>

Designers SHOULD consider the extensibility of extensions they specify.  Extensions to LDAP SHOULD themselves be extensible.
<font color=green>设计人员应该考虑，他们指定的扩展的可扩展性。</font>
<font color=red>LDAP的扩展本身应该是可扩展的。</font>

Except where it is stated otherwise, extensibility is implied.
<font color=red>除非另有说明，否则都隐含着可扩展性。</font>

## 2.3.  Discovery Mechanism(发现机制)

Extensions SHOULD provide adequate discovery mechanisms.
<font color=green>扩展应该提供足够的发现机制。</font>

As LDAP design is based upon the client-request/server-response paradigm, the general discovery approach is for the client to discover the capabilities of the server before utilizing a particular extension.  Commonly, this discovery involves querying the root DSE and/or other DSEs for operational information associated with the extension.  LDAP provides no mechanism for a server to discover the capabilities of a client.
<font color=red>由于LDAP设计基于 client-request/server-response 范式，所以一般的发现方法是让client在使用特定的扩展之前发现server的功能。</font>
<font color=red>通常，该发现涉及查询根DSE和/或其他DSE，以获取与扩展相关的操作信息。</font>
<font color=green>LDAP没有为server提供发现client功能的机制。</font>

The 'supportedControl' attribute [RFC4512] is used to advertise supported controls. 
The 'supportedExtension' attribute [RFC4512] is used to advertise supported extended operations. 
The 'supportedFeatures' attribute [RFC4512] is used to advertise features. 
Other root DSE attributes MAY be defined to advertise other capabilities.
<font color=green>'supportedControl' attribute [RFC4512]   用于通知 支持的  控件/control。</font>
<font color=green>'supportedExtension' attribute [RFC4512] 用于通知 支持的  扩展操作/extend-operation。</font>
<font color=green>'supportedFeatures' attribute [RFC4512]  用于通知 特性/功能/feature。</font>
<font color=green>可以定义其他根DSE属性来通知其他功能。</font>

## 2.4.  Internationalization Considerations(国际化注意事项)

LDAP is designed to support the full Unicode [Unicode] repertory of characters.  Extensions SHOULD avoid unnecessarily restricting applications to subsets of Unicode (e.g., Basic Multilingual Plane, ISO 8859-1, ASCII, Printable String).
<font color=red>LDAP被设计为支持完整的Unicode[Unicode]字符库。</font>
<font color=green>扩展应避免不必要地将应用程序限制为Unicode的子集(例如，Basic Multilingual Plane, ISO 8859-1, ASCII, Printable String)。</font>

LDAP Language Tag options [RFC3866] provide a mechanism for tagging text (and other) values with language information.  Extensions that define attribute types SHOULD allow use of language tags with these attributes.
<font color=green>LDAP语言标签选项/Language Tag options[RFC3866], 提供了一种用语言信息 标记文本(和其他)值的机制。</font>
<font color=green>定义attribute-type的扩展"应该"允许使用带有这些属性/attribute的语言标记/language-tag。</font>

## 2.5.  Use of the Basic Encoding Rules(BER的使用)

Numerous elements of LDAP are described using ASN.1 [X.680] and are encoded using a particular subset [Protocol, Section 5.2] of the Basic Encoding Rules (BER) [X.690].  To allow reuse of parsers/generators used in implementing the LDAP "core" technical specification [RFC4510], it is RECOMMENDED that extension elements (e.g., extension specific contents of controlValue, requestValue, responseValue fields) described by ASN.1 and encoded using BER be subjected to the restrictions of [Protocol, Section 5.2].
<font color=red>LDAP的许多元素都是用ASN.1描述的，并使用基本编码规则(BER) [X.690]的特定子集[Protocol, Section 5.2]进行编码。</font>
<font color=green>为了允许重用  用于实现LDAP“核心”技术规范[RFC4510] 的解析器/生成器，</font>
      <font color=green>建议 使用ASN.1描述并使用BER编码的扩展元素(如controlValue、requestValue、responseValue 字段的 扩展特定内容)，</font>
      <font color=green>使用BER进行编码，受[Protocol, Section 5.2]的限制。</font>

## 2.6.  Use of Formal Languages(正式语言的使用)

Formal languages SHOULD be used in specifications in accordance with IESG guidelines [FORMAL].
根据IESG指南[FORMAL],在规格中"应该"使用正式语言。

## 2.7.  Examples

Example DN strings SHOULD conform to the syntax defined in [RFC4518]. 
Example LDAP filter strings SHOULD conform to the syntax defined in [RFC4515].  
Example LDAP URLs SHOULD conform to the syntax defined in [RFC4516].  
Entries SHOULD be represented using LDIF [RFC2849].
<font color=green>DN strings，"应该"符合[RFC4518]中定义的语法。</font>
<font color=green>LDAP filter strings，"应该"符合[RFC4515]中定义的语法。</font>
<font color=green>LDAP URLs，"应该"符合[RFC4516]中定义的语法。</font>
<font color=green>Entries，"应该"使用LDIF [RFC2849]表示。</font>

## 2.8.  Registration of Protocol Values(注册协议值)

Designers SHALL register protocol values of their LDAP extensions in accordance with BCP 64, RFC 4520 [RFC4520].  Specifications that create new extensible protocol elements SHALL extend existing registries or establish new registries for values of these elements in accordance with BCP 64, RFC 4520 [RFC4520] and BCP 26, RFC 2434 [RFC2434].
<font color=green>设计者应该按照BCP 64, RFC4520 [RFC4520]注册他们的LDAP扩展的协议值。</font>
创建新的可扩展协议元素的规范应根据BCP 64, RFC4520 [RFC4520]和BCP 26, RFC2434 [RFC2434]，扩展现有注册表或为这些元素的值建立新的注册表。




# 3.  LDAP Operation Extensions(扩展 LDAP操作)

Extensions SHOULD use controls in defining extensions that complement existing operations.  Where the extension to be defined does not complement an existing operation, designers SHOULD consider defining an extended operation instead.
<font color=red>扩展应该在 定义扩展时 使用控件/control 来补充现有操作/operation。</font>
<font color=red>如果要定义的扩展/extension不能补充一个现有操作/operation，设计人员应该考虑定义一个扩展操作/extended-operation。</font>

For example, a subtree delete operation could be designed as either an extension of the delete operation or as a new operation.  As the feature complements the existing delete operation, use of the control mechanism to extend the delete operation is likely more appropriate.
<font color=green>例如，一个子树删除操作 可以被设计为 一个删除操作的扩展或一个新操作。</font>
<font color=red>由于该功能是对现有删除操作的补充，因此使用控件机制/control-mechanism来扩展删除操作可能更合适。</font>

As a counter (and contrived) example, a locate services operation (an operation that would return for a DN a set of LDAP URLs to services that may hold the entry named by this DN) could be designed as either a search operation or a new operation.  As the feature doesn't complement the search operation (e.g., the operation is not contrived to search for entries held in the Directory Information Tree), it is likely more appropriate to define a new operation using the extended operation mechanism.
作为一个计数器(和人为设计的)<font color=green>示例，定位服务操作（该操作 将为DN返回一组LDAP-URL到可能包含此DN命名的条目的服务）可以设计为搜索操作或新操作。 </font>
<font color=red>由于该功能/特性不能补充搜索操作（例如，该操作不是为了搜索目录信息树中保存的条目而设计的），因此使用扩展操作机制/extended-operation-mechanism定义一个新操作可能更合适。</font>

- **总结，**
  - **扩展/extension，**
    - **是对现有操作/operation的补充**
      - **那么使用控件机制/control-mechanism来扩展现有操作**
    - **不能补充现有操作(是个全新的特性/功能)**
      - **使用扩展操作机制/extended-operation-mechanism定义一个新操作**



## 3.1.  Controls(控件)

Controls [Protocol, Section 4.1.11] are the RECOMMENDED mechanism for extending existing operations.  The existing operation can be a base operation defined in [RFC4511] (e.g., search, modify) , an extended operation (e.g., Start TLS [RFC4511], Password Modify [RFC3062]), or an operation defined as an extension to a base or extended operation.
<font color=red>当用于扩展现有操作时，"推荐"使用控件机制/control-mechanism。</font>
<font color=red>现有操作可以是</font>
      <font color=green>[RFC4511] 中定义的基本操作/base-operation(如，搜索/search、修改/modify)、</font>
      <font color=green>扩展操作/extended-operation(如，Start TLS [RFC4511]、Password Modify [RFC3062]) </font>
      <font color=green>或  定义为对base-operation的扩展的 操作/operation </font>
      <font color=green>或  扩展操作/extended-operation。</font>

Extensions SHOULD NOT return Response controls unless the server has specific knowledge that the client can make use of the control. Generally, the client requests the return of a particular response control by providing a related request control.
<font color=red>扩展/extension" 不应"返回响应控件/response-control，除非服务器有该客户端可以使用控件的特定信息。</font>
<font color=red>通常，客户端通过提供相关的请求控件/request-control   来请求返回特定的响应控件/response-control。</font>

An existing operation MAY be extended to return IntermediateResponse messages [Protocol, Section 4.13].
<font color=red>现有操作"可能"被扩展为，返回中间响应消息/ IntermediateResponse message</font> [协议，第 4.13 节]。

Specifications of controls SHALL NOT attach additional semantics to the criticality of controls beyond those defined in [Protocol, Section 4.1.11].  A specification MAY mandate the criticality take on a particular value (e.g., TRUE or FALSE), where appropriate.
<font color=red>除[Protocol, Section 4.1.11]中定义的外，控件规范"不应"对control的criticality  附加/额外的语义。</font>
<font color=green>在适当的情况下，规范"可能"要求criticality采用特定值(例如，TRUE 或 FALSE)。</font>



### 3.1.1.  Extending Bind Operation with Controls(使用control扩展Bind-Operation)

Controls attached to the request and response messages of a Bind Operation [RFC4511] are not protected by any security layers established by that Bind operation.
<font color=red>附加到   绑定操作[RFC4511]的请求消息和响应消息上的  控件，不受该绑定操作建立的任何安全层的保护。</font>

Specifications detailing controls extending the Bind operation SHALL detail that the Bind negotiated security layers do not protect the information contained in these controls and SHALL detail how the information in these controls is protected or why the information does not need protection.
<font color=green>详细说明 扩展Bind-Operation的control的规范 ,</font>
     <font color=green> "应"详细说明  绑定协商的安全层 不保护这些control中包含的信息，</font>
      <font color=green>并"应"详细说明如何保护这些control中的信息或为什么信息不需要保护。</font>

It is RECOMMENDED that designers consider alternative mechanisms for providing the function.  For example, an extended operation issued subsequent to the Bind operation (hence, protected by the security layers negotiated by the Bind operation) might be used to provide the desired function.
<font color=red>"建议"设计者考虑提供该功能的替代机制。</font>
<font color=red>例如，在Bind-Operation之后发布的extended-operation(因此，受到bind-operation 协商的安全层 保护)可能用于提供所需的功能。</font>

Additionally, designers of Bind control extensions MUST also consider how the controls' semantics interact with individual steps of a multi-step Bind operation.  Note that some steps are optional and thus may require special attention in the design.
此外，绑定控件扩展的设计者<font color=red>还必须考虑control的语义如何与多步骤bind-operation的各个步骤交互。</font>
<font color=green>请注意，有些步骤是可选的，因此在设计中可能需要特别注意。</font>



### 3.1.2.  Extending the Start TLS Operation with Controls(使用control扩展Start TLS-Operation)

Controls attached to the request and response messages of a Start TLS Operation [RFC4511] are not protected by the security layers established by the Start TLS operation.
<font color=red>附加到start TLS operation[RFC4511] 的request-message和response-message上的control，不受start TLS operation建立的安全层的保护。</font>

Specifications detailing controls extending the Start TLS operation SHALL detail that the Start TLS negotiated security layers do not protect the information contained in these controls and SHALL detail how the information in these controls is protected or why the information does not need protection.
<font color=green>详细说明扩展start TLS operation的control的规范,</font>
   <font color=green>应详细说明 Start TLS协商的安全层 不保护这些control中包含的信息，</font>
   <font color=green>并应详细说明如何保护这些control中的信息或为什么信息不需要保护。</font>

It is RECOMMENDED that designers consider alternative mechanisms for providing the function.  For example, an extended operation issued subsequent to the Start TLS operation (hence, protected by the security layers negotiated by the Start TLS operation) might be used to provided the desired function.
<font color=red>"建议"设计者考虑提供该功能的替代机制。</font>
<font color=red>例如，在start TLS operation之后发布的extended-operation（因此，受start TLS operation 协商的安全层 保护）可能用于提供所需的功能。</font>



### 3.1.3.  Extending the Search Operation with Controls(使用control扩展Search-Operation)

The Search operation processing has two distinct phases:
<font color=red>search-operation的处理，有两个不同的阶段：</font>

   -  finding the base object; and
      <font color=red>1) 寻找base-object；和</font>
   -  searching for objects at or under that base object.
      <font color=red>2) 在该base-object之上/下 搜索object。</font>

Specifications of controls extending the Search Operation should clearly state in which phase(s) the control's semantics apply. Semantics of controls that are not specific to the Search Operation SHOULD apply in the finding phase.
<font color=green>扩展search-operation的,control的规范, 应该清楚地说明control的语义适用于哪个阶段。</font>
<font color=green>不特定于search-operation的control的语义应该应用于查找阶段/find-phase。</font>



### 3.1.4.  Extending the Update Operations with Controls(使用control扩展Update-Operation)

Update operations have properties of atomicity, consistency, isolation, and durability ([ACID]).
<font color=red>Update-Operation具有原子性、一致性、隔离性和持久性（[ACID]）的特性。</font>

   -  atomicity: All or none of the DIT changes requested are made.
      <font color=red>原子性：请求的DIT更改，要么全部执行要么不执行。</font>
   -  consistency: The resulting DIT state must be conform to schema and other constraints.
      <font color=red>一致性：产生的DIT状态，必须符合模式/schema和其他约束。</font>
   -  isolation: Intermediate states are not exposed.
      <font color=red>隔离：不暴露中间状态。</font>
   -  durability: The resulting DIT state is preserved until subsequently updated.
      <font color=red>持久性：生成的DIT状态 将保留，直到 随后/下一次 更新。</font>

When defining a control that requests additional (or other) DIT changes be made to the DIT, these additional changes SHOULD NOT be treated as part of a separate transaction.  The specification MUST be clear as to whether the additional DIT changes are part of the same or a separate transaction as the DIT changes expressed in the request of the base operation.
当定义一个要求对DIT进行额外(或其他)DIT 更改的control时，这些额外的更改"不应"被视为单独事务的一部分。
规范必须明确说明 附加 DIT 更改是与基本操作请求中表达的 DIT 更改相同还是单独事务的一部分。

When defining a control that requests additional (or other) DIT changes be made to the DIT, the specification MUST be clear as to the order in which these and the base changes are to be applied to the DIT.
当定义一个要求对DIT进行额外(或其他)DIT 更改的control时，规范必须明确说明这些更改和基本更改应用于 DIT 的顺序。



### 3.1.5.  Extending the Responseless Operations with Controls(使用control扩展Responseless-Operation)

The Abandon and Unbind operations do not include a response message. For this reason, specifications for controls designed to be attached to Abandon and Unbind requests SHOULD mandate that the control's criticality be FALSE.
放弃和解除绑定操作不包括响应消息。
出于这个原因，设计为附加到放弃和解除绑定请求的控件的规范应该强制要求控件的关键性为 FALSE。



## 3.2.  Extended Operations(扩展操作)

Extended Operations [Protocol, Section 4.12] are the RECOMMENDED mechanism for defining new operations.  An extended operation consists of an ExtendedRequest message, zero or more IntermediateResponse messages, and an ExtendedResponse message.
扩展操作 [协议，第 4.12 节] 是定义新操作的推荐机制。
扩展操作由一个 ExtendedRequest 消息、零个或多个 IntermediateResponse 消息和一个 ExtendedResponse 消息组成。



## 3.3.  Intermediate Responses(中间响应)

Extensions SHALL use IntermediateResponse messages instead of ExtendedResponse messages to return intermediate results.
扩展应使用 IntermediateResponse 消息而不是 ExtendedResponse 消息来返回中间结果。





Zeilenga                 Best Current Practice                  [Page 8]

RFC 4521                    LDAP Extensions                    June 2006




## 3.4.  Unsolicited Notifications(主动通知)

Unsolicited notifications [Protocol, Section 4.4] offer a capability for the server to notify the client of events not associated with the operation currently being processed.
主动通知 [协议，第 4.4 节] 为服务器提供了一种能力，可以将与当前正在处理的操作无关的事件通知给客户端。

Extensions SHOULD be designed such that unsolicited notifications are not returned unless the server has specific knowledge that the client can make use of the notification.  Generally, the client requests the return of a particular unsolicited notification by performing a related extended operation.
扩展应该被设计成不返回未经请求的通知，除非服务器具有客户端可以使用通知的特定知识。
通常，客户端通过执行相关的扩展操作来请求返回特定的主动通知。

For example, a time hack extension could be designed to return unsolicited notifications at regular intervals that were enabled by an extended operation (which possibly specified the desired interval).
例如，时间黑客扩展可以设计为定期返回由扩展操作启用的未经请求的通知（可能指定了所需的时间间隔）。



# 4.  Extending the LDAP ASN.1 Definition

LDAP allows limited extension [Protocol, Section 4] of the LDAP ASN.1 definition [Protocol, Appendix B] to be made.

## 4.1.  Result Codes

Extensions that specify new operations or enhance existing operations often need to define new result codes.  The extension SHOULD be designed such that a client has a reasonably clear indication of the nature of the successful or non-successful result.

Extensions SHOULD use existing result codes to indicate conditions that are consistent with the intended meaning [RFC4511][X.511] of these codes.  Extensions MAY introduce new result codes [RFC4520] where no existing result code provides an adequate indication of the nature of the result.

Extensions SHALL NOT disallow or otherwise restrict the return of general service result codes, especially those reporting a protocol, service, or security problem, or indicating that the server is unable or unwilling to complete the operation.

## 4.2.  LDAP Message Types

While extensions can specify new types of LDAP messages by extending the protocolOp CHOICE of the LDAPMessage SEQUENCE, this is generally unnecessary and inappropriate.  Existing operation extension mechanisms (e.g., extended operations, unsolicited notifications, and intermediate responses) SHOULD be used instead.  However, there may be cases where an extension does not fit well into these mechanisms.

In such cases, a new extension mechanism SHOULD be defined that can be used by multiple extensions that have similar needs.

## 4.3.  Authentication Methods

The Bind operation currently supports two authentication methods, simple and SASL.  SASL [RFC4422] is an extensible authentication framework used by multiple application-level protocols (e.g., BEEP, IMAP, SMTP).  It is RECOMMENDED that new authentication processes be defined as SASL mechanisms.  New LDAP authentication methods MAY be added to support new authentication frameworks.

The Bind operation's primary function is to establish the LDAP association [RFC4513].  No other operation SHALL be defined (or extended) to establish the LDAP association.  However, other operations MAY be defined to establish other security associations (e.g., IPsec).

## 4.4.  General ASN.1 Extensibility

Section 4 of [RFC4511] states the following:
```
In order to support future extensions to this protocol, extensibility is implied where it is allowed per ASN.1 (i.e., sequence, set, choice, and enumerated types are extensible).  In addition, ellipses (...)  have been supplied in ASN.1 types that are explicitly extensible as discussed in [RFC4520].  Because of the implied extensibility, clients and servers MUST (unless otherwise specified) ignore trailing SEQUENCE components whose tags they do not recognize.
```
Designers SHOULD avoid introducing extensions that rely on unsuspecting implementations to ignore trailing components of SEQUENCE whose tags they do not recognize.



# 5.  Schema Extensions

   Extensions defining LDAP schema elements SHALL provide schema
   definitions conforming with syntaxes defined in [Models, Section
   4.1].  While provided definitions MAY be reformatted (line wrapped)
   for readability, this SHALL be noted in the specification.

   For definitions that allow a NAME field, new schema elements SHOULD
   provide one and only one name.  The name SHOULD be short.

   Each schema definition allows a DESC field.  The DESC field, if
   provided, SHOULD contain a short descriptive phrase.  The DESC field
   MUST be regarded as informational.  That is, the specification MUST



Zeilenga                 Best Current Practice                 [Page 10]

RFC 4521                    LDAP Extensions                    June 2006


   be written such that its interpretation is the same with and without
   the provided DESC fields.

   The extension SHALL NOT mandate that implementations provide the same
   DESC field in the schema they publish.  Implementors MAY replace or
   remove the DESC field.

   Published schema elements SHALL NOT be redefined.  Replacement schema
   elements (new OIDs, new NAMEs) SHOULD be defined as needed.

   Schema designers SHOULD reuse existing schema elements, where
   appropriate.  However, any reuse MUST not alter the semantics of the
   element.

## 5.1.  LDAP Syntaxes

   Each LDAP syntax [RFC4517] is defined in terms of ASN.1 [X.680].
   Each extension detailing an LDAP syntax MUST specify the ASN.1 data
   definition associated with the syntax.  A distinct LDAP syntax SHOULD
   be created for each distinct ASN.1 data definition (including
   constraints).

   Each LDAP syntax SHOULD have a string encoding defined for it.  It is
   RECOMMENDED that this string encoding be restricted to UTF-8
   [RFC3629] encoded Unicode [Unicode] characters.  Use of Generic
   String Encoding Rules (GSER) [RFC3641][RFC3642] or other generic
   string encoding rules to provide string encodings for complex ASN.1
   data definitions is RECOMMENDED.  Otherwise, it is RECOMMENDED that
   the string encoding be described using a formal language (e.g., ABNF
   [RFC4234]).  Formal languages SHOULD be used in specifications in
   accordance with IESG guidelines [FORMAL].

   If no string encoding is defined, the extension SHALL specify how the
   transfer encoding is to be indicated.  Generally, the extension
   SHOULD mandate use of binary or other transfer encoding option.

## 5.2.  Matching Rules

   Three basic kinds of matching rules (e.g., EQUALITY, ORDERING, and
   SUBSTRING) may be associated with an attribute type.  In addition,
   LDAP provides an extensible matching rule mechanism.

   The matching rule specification SHOULD detail which kind of matching
   rule it is and SHOULD describe which kinds of values it can be used
   with.

   In addition to requirements stated in the LDAP technical
   specification, equality matching rules SHOULD be commutative.



Zeilenga                 Best Current Practice                 [Page 11]

RFC 4521                    LDAP Extensions                    June 2006


## 5.3.  Attribute Types

   Designers SHOULD carefully consider how the structure of values is to
   be restricted.  Designers SHOULD consider that servers will only
   enforce constraints of the attribute's syntax.  That is, an attribute
   intended to hold URIs, but that has directoryString syntax, is not
   restricted to values that are URIs.

   Designers SHOULD carefully consider which matching rules, if any, are
   appropriate for the attribute type.  Matching rules specified for an
   attribute type MUST be compatible with the attribute type's syntax.

   Extensions specifying operational attributes MUST detail how servers
   are to maintain and/or utilize values of each operational attribute.

## 5.4.  Object Classes

   Designers SHOULD carefully consider whether each attribute of an
   object class is required ("MUST") or allowed ("MAY").

   Extensions specifying object classes that allow (or require)
   operational attributes MUST specify how servers are to maintain
   and/or utilize entries belonging to these object classes.

# 6.  Other Extension Mechanisms

## 6.1.  Attribute Description Options

   Each option is identified by a string of letters, numbers, and
   hyphens.  This string SHOULD be short.

## 6.2.  Authorization Identities

   Extensions interacting with authorization identities SHALL support
   the LDAP authzId format [RFC4513].  The authzId format is extensible.

## 6.3.  LDAP URL Extensions

   LDAP URL extensions are identified by a short string, a descriptor.
   Like other descriptors, the string SHOULD be short.

# 7.  Security Considerations

   LDAP does not place undue restrictions on the kinds of extensions
   that can be implemented.  While this document attempts to outline
   some specific issues that designers need to consider, it is not (and





Zeilenga                 Best Current Practice                 [Page 12]

RFC 4521                    LDAP Extensions                    June 2006


   cannot be) all encompassing.  Designers MUST do their own evaluations
   of the security considerations applicable to their extensions.

   Designers MUST NOT assume that the LDAP "core" technical
   specification [RFC4510] adequately addresses the specific concerns
   surrounding their extensions or assume that their extensions have no
   specific concerns.

   Extension specifications, however, SHOULD note whether security
   considerations specific to the feature they are extending, as well as
   general LDAP security considerations, apply to the extension.

# 8.  Acknowledgements(略)

   The author thanks the IETF LDAP community for their thoughtful
   comments.

   This work builds upon "LDAP Extension Style Guide" [GUIDE] by Bruce
   Greenblatt.

# 9.  References(略)

## 9.1.  Normative References

   [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC2434]  Narten, T. and H. Alvestrand, "Guidelines for Writing an
              IANA Considerations Section in RFCs", BCP 26, RFC 2434,
              October 1998.

   [RFC2849]  Good, G., "The LDAP Data Interchange Format (LDIF) -
              Technical Specification", RFC 2849, June 2000.

   [RFC3629]  Yergeau, F., "UTF-8, a transformation format of ISO
              10646", STD 63, RFC 3629, November 2003.

   [RFC3641]  Legg, S., "Generic String Encoding Rules (GSER) for ASN.1
              Types", RFC 3641, October 2003.

   [RFC3642]  Legg, S., "Common Elements of Generic String Encoding
              Rules (GSER) Encodings", RFC 3642, October 2003.

   [RFC4512]  Zeilenga, K., "Lightweight Directory Access Protocol
              (LDAP): Directory Information Models", RFC 4512, June
              2006.





Zeilenga                 Best Current Practice                 [Page 13]

RFC 4521                    LDAP Extensions                    June 2006


   [RFC3866]  Zeilenga, K., Ed., "Language Tags and Ranges in the
              Lightweight Directory Access Protocol (LDAP)", RFC 3866,
              July 2004.

   [RFC4234]  Crocker, D. and P. Overell, "Augmented BNF for Syntax
              Specifications: ABNF", RFC 4234, October 2005.

   [RFC4510]  Zeilenga, K., Ed., "Lightweight Directory Access Protocol
              (LDAP): Technical Specification Road Map", RFC 4510, June
              2006.

   [RFC4511]  Sermersheim, J., Ed., "Lightweight Directory Access
              Protocol (LDAP): The Protocol", RFC 4511, June 2006.

   [RFC4512]  Zeilenga, K., "Lightweight Directory Access Protocol
              (LDAP): Directory Information Models", RFC 4512, June
              2006.

   [RFC4513]  Harrison, R., Ed., "Lightweight Directory Access Protocol
              (LDAP): Authentication Methods and Security Mechanisms",
              RFC 4513, June 2006.

   [RFC4515]  Smith, M., Ed. and T. Howes, "Lightweight Directory Access
              Protocol (LDAP): String Representation of Search Filters",
              RFC 4515, June 2006.

   [RFC4516]  Smith, M., Ed. and T. Howes, "Lightweight Directory Access
              Protocol (LDAP): Uniform Resource Locator", RFC 4516, June
              2006.

   [RFC4517]  Legg, S., Ed., "Lightweight Directory Access Protocol
              (LDAP): Syntaxes and Matching Rules", RFC 4517, June 2006.

   [RFC4518]  Zeilenga, K., "Lightweight Directory Access Protocol
              (LDAP): String Representation of Distinguished Names", RFC
              4518, June 2006.

   [RFC4520]  Zeilenga, K., "Internet Assigned Numbers Authority (IANA)
              Considerations for the Lightweight Directory Access
              Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

   [RFC4422]  Melnikov, A., Ed. and K. Zeilenga, Ed., "Simple
              Authentication and Security Layer (SASL)", RFC 4422, June
              2006.







Zeilenga                 Best Current Practice                 [Page 14]

RFC 4521                    LDAP Extensions                    June 2006


   [Unicode]  The Unicode Consortium, "The Unicode Standard, Version
              3.2.0" is defined by "The Unicode Standard, Version 3.0"
              (Reading, MA, Addison-Wesley, 2000. ISBN 0-201-61633-5),
              as amended by the "Unicode Standard Annex #27: Unicode
              3.1" (http://www.unicode.org/reports/tr27/) and by the
              "Unicode Standard Annex #28: Unicode 3.2"
              (http://www.unicode.org/reports/tr28/).

   [FORMAL]   IESG, "Guidelines for the use of formal languages in IETF
              specifications",
              <http://www.ietf.org/IESG/STATEMENTS/pseudo-code-in-
              specs.txt>, 2001.

   [X.511]    International Telecommunication Union - Telecommunication
              Standardization Sector, "The Directory: Abstract Service
              Definition", X.511(1993) (also ISO/IEC 9594-3:1993).

   [X.680]    International Telecommunication Union - Telecommunication
              Standardization Sector, "Abstract Syntax Notation One
              (ASN.1) - Specification of Basic Notation", X.680(2002)
              (also ISO/IEC 8824-1:2002).

   [X.690]    International Telecommunication Union - Telecommunication
              Standardization Sector, "Specification of ASN.1 encoding
              rules: Basic Encoding Rules (BER), Canonical Encoding
              Rules (CER), and Distinguished Encoding Rules (DER)",
              X.690(2002) (also ISO/IEC 8825-1:2002).

## 9.2.  Informative References

   [ACID]     Section 4 of ISO/IEC 10026-1:1992.

   [GUIDE]    Greenblatt, B., "LDAP Extension Style Guide", Work in
              Progress.

   [RFC3062]  Zeilenga, K., "LDAP Password Modify Extended Operation",
              RFC 3062, February 2001.

   [RFC4346]  Dierks, T. and E. Rescorla, "The Transport Layer Security
              (TLS) Protocol Version 1.1", RFC 4346, April 2006.

Author's Address

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org




Zeilenga                 Best Current Practice                 [Page 15]

RFC 4521                    LDAP Extensions                    June 2006


# Full Copyright Statement

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

# Intellectual Property

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

# Acknowledgement

   Funding for the RFC Editor function is provided by the IETF
   Administrative Support Activity (IASA).







Zeilenga                 Best Current Practice                 [Page 16]

