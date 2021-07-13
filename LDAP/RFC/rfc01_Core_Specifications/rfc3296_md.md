





Network Working Group                                        K. Zeilenga
Request for Comments: 3296                           OpenLDAP Foundation
Category: Standards Track                                      July 2002

# Named Subordinate References in Lightweight Directory Access Protocol (LDAP) Directories(LDAP目录中- Named Subordinate References的schema和protocol-elements)

## Status of this Memo(略)

This document specifies an Internet standards track protocol for the Internet community, and requests discussion and suggestions for improvements.  Please refer to the current edition of the "Internet Official Protocol Standards" (STD 1) for the standardization state and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice(略)

Copyright (C) The Internet Society (2002).  All Rights Reserved.

## Abstract(概述)

This document details schema and protocol elements for representing and managing **named subordinate references** in Lightweight Directory Access Protocol (LDAP) Directories.
<font color=red>本文档详细介绍了：用于表示和管理LDAP目录中的-命名从属引用的   schema和protocol-elements。</font>

## Conventions(约定)

Schema definitions are provided using LDAPv3 description formats [RFC2252].  Definitions provided here are formatted (line wrapped) for readability.
<font color=red>使用 LDAPv3描述格式[RFC2252] 提供 schema定义。</font>
此处提供的定义已格式化（换行）以提高可读性。

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" used in this document are to be interpreted as described in BCP 14 [RFC2119].

本文档中使用的关键词 "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" , 将按照 BCP 14 [RFC2119] 中的描述进行解释。

# 1. Background and Intended Usage(背景和预期用途)

The broadening of interest in LDAP (Lightweight Directory Access Protocol) [RFC2251] directories beyond their use as front ends to X.500 [X.500] directories has created a need to represent knowledge information in a more general way.  Knowledge information is information about one or more servers maintained in another server, used to link servers and services together.
对 LDAP(轻量级目录访问协议)[RFC2251] 目录的兴趣  扩大到 X.500 [X.500] 目录的前端，已经产生了以更一般的方式表示  知识信息/knowledge-information  的需求。
<font color=red>knowledge-information是 在另一台服务器中维护的1个或多个服务器的信息，用于将服务器和服务链接在一起。</font>

This document details schema and protocol elements for representing and manipulating named subordinate references in LDAP directories.  A referral object is used to hold subordinate reference information in
<font color=red>本文档详细介绍了  用于表示和操作    LDAP 目录中   named-subordinate-references  的schema和protocol elements</font>
<font color=red>referral object用于保存subordinate reference信息</font>

the directory.  These referral objects hold one or more URIs [RFC2396] contained in values of the ref attribute type and are used to generate protocol referrals and continuations.
目录。<font color=red>这些referral objects保存了   1个或多个包含在attribute-type: ref 的value中的 URI [RFC2396]，用于生成协议引用和延续。</font>

A control, ManageDsaIT, is defined to allow manipulation of referral and other special objects as normal objects.  As the name of control implies, it is intended to be analogous to the ManageDsaIT service option described in X.511(97) [X.511].
<font color=red>控件 ManageDsaIT 被定义为允许将referral和其他特殊object作为普通object进行操作。</font>正如控制的名称所暗示的那样，它旨在类似于 X.511(97) [X.511] 中描述的 ManageDsaIT 服务选项。

Other forms of knowledge information are not detailed by this document.  These forms may be described in subsequent documents.
其他form的知识信息本文档未详述。这些form可能会在后续文档中进行描述。

This document details subordinate referral processing requirements for servers.  This document does not describe protocol syntax and semantics.  This is detailed in RFC 2251 [RFC2251].
<font color=red>本文档详细说明了服务器的subordinate referral处理  要求/需求。本文档不描述协议语法和语义。这在 RFC 2251 [RFC2251] 中有详细说明。</font>

This document does not detail use of subordinate knowledge references to support replicated environments nor distributed operations (e.g., chaining of operations from one server to other servers).
<font color=blue>本文档没有详细使用从属知识参考来支持复制环境或分布式操作（例如，从一台服务器到其他服务器的操作链）。</font>



# 2. Schema

## 2.1.  The referral Object Class(ObjectClass: referral)

A referral object is a directory entry whose structural object class is (or is derived from) the referral object class.
<font color=red>referral-object   是一个entry</font>，其结构对象类是（或派生自）引用对象类。

```ABNF
  ( 2.16.840.1.113730.3.2.6
      NAME 'referral'
      DESC 'named subordinate reference object'
      STRUCTURAL
      MUST ref )
```

The referral object class is a structural object class used to represent a subordinate reference in the directory.  The referral object class SHOULD be used in conjunction with the extensibleObject object class to support the naming attributes used in the entry's Distinguished Name (DN) [RFC2253].
<font color=red>referral object class是structural object class，用于表示目录中的   下级引用/subordinate reference。</font> 
<font color=red>referral object class应该与 extensibleObject object class结合使用，以支持条目的DN[RFC2253] 中使用的命名属性。</font>

Referral objects are normally instantiated at DSEs immediately subordinate to object entries within a naming context held by the DSA.  Referral objects are analogous to X.500 subordinate knowledge (subr) DSEs [X.501].
<font color=red>referral object 通常在 DSE 处实例化，该 DSE 直接从属于 DSA 持有的命名上下文中的对象条目。 </font>
referral object类似于 X.500 下级知识 (subr) DSE [X.501]。

In the presence of a ManageDsaIT control, referral objects are treated as normal entries as described in section 3.  Note that the ref attribute is operational and will only be returned in a search entry response when requested.
<font color=red>在存在 ManageDsaIT 控件的情况下，referral object被视为正常条目，如第 3 节所述。请注意，ref 属性是可操作的，并且仅在被请求时在搜索条目响应中返回。</font>

In the absence of a ManageDsaIT control, the content of referral objects are used to construct referrals and search references as described in Section 4 and, as such, the referral entries are not themselves visible to clients.
<font color=red>在没有 ManageDsaIT 控件的情况下，referral object的内容用于构造referrals and search references，如第 4 节所述，因此，referral-entry本身对客户端不可见。</font>



## 2.2  The ref Attribute Type(AttributeType: ref)

```ABNF
  ( 2.16.840.1.113730.3.1.34
      NAME 'ref'
      DESC 'named reference - a labeledURI'
      EQUALITY caseExactMatch
      SYNTAX 1.3.6.1.4.1.1466.115.121.1.15
      USAGE distributedOperation )
```

The ref attribute type has directoryString syntax and is case sensitive.  The ref attribute is multi-valued.  Values placed in the attribute MUST conform to the specification given for the labeledURI attribute [RFC2079].  The labeledURI specification defines a format that is a URI, optionally followed by whitespace and a label.  This document does not make use of the label portion of the syntax. Future documents MAY enable new functionality by imposing additional structure on the label portion of the syntax as it appears in the ref attribute.
<font color=red>AttributeType: ref ，具有 directoryString 语法并且区分大小写。 </font>
<font color=red>Attribute: ref，是多值的。 </font>
<font color=red>属性中的值，必须符合给labeledURI 属性[RFC2079] 的规范。 </font>
<font color=red>labeledURI 规范定义了一种格式，即 URI，后跟可选的空格和一个label。 </font>
本文档不使用语法的label部分。 
未来的文档可以通过在语法的label部分，施加额外的结构来启用新功能，因为它出现在 ref 属性中。

If the URI contained in a ref attribute value refers to a LDAP [RFC2251] server, it MUST be in the form of a LDAP URL [RFC2255]. The LDAP URL SHOULD NOT contain an explicit scope specifier, filter, attribute description list, or any extensions.  The LDAP URL SHOULD contain a non-empty DN.  The handling of LDAP URLs with absent or empty DN parts or with explicit scope specifier is not defined by this specification.
<font color=red>如果 ref 属性值中包含的 URI 指向 LDAP [RFC2251] 服务器，则它必须采用 LDAP URL [RFC2255] 的形式。 </font>
<font color=red>LDAP URL 不应包含明确的scope说明符、filter、attribute描述list或任何extension。 </font>
<font color=red>LDAP URL 应该包含一个非空的 DN。</font>
本规范未定义对   DN部分不存在或为空或具有显式scope说明符的    LDAP-URL的处理。

Other URI schemes MAY be used so long as all operations returning referrals based upon the value could be performed.  This document does not detail use of non-LDAP URIs.  This is left to future specifications.
<font color=blue>可以使用其他 URI-schema/方案，只要所有 基于该值返回referrals 的操作 都可以执行。</font>
本文档没有详细说明非 LDAP URI 的使用。这留待未来的规范。

The referential integrity of the URI SHOULD NOT be validated by the server holding or returning the URI (whether as a value of the attribute or as part of a referral result or search reference response).
URI 的参照完整性不应由持有或返回 URI 的服务器验证
（无论是作为attribute-value  还是作为referral-result或search-reference-response的一部分）。

When returning a referral result or search continuation, the server MUST NOT return the separator or label portions of the attribute values as part of the reference.  When the attribute contains multiple values, the URI part of each value is used to construct the referral result or search continuation.
<font color=green>当返回referral result或search continuation时，服务器不得将属性值的分隔符/separator 或标签/label 部分作为reference的一部分返回。</font>
<font color=red>当属性包含多个值时，每个值的 URI 部分 用于构造referral result 或 search continuation。</font>

The ref attribute values SHOULD NOT be used as a relative name-component of an entry's DN [RFC2253].
<font color=red> ref attribute value不应用作entry's DN[RFC2253] 的RDN。</font>

This document uses the ref attribute in conjunction with the referral  object class to represent subordinate references.  The ref attribute may be used for other purposes as defined by other documents.
<font color=red>本文档结合 referral  object class使用 ref attribute  来表示subordinate reference。 </font>
ref attribute可以用于 其他文档定义的其他目的。



# 3. The ManageDsaIT Control(control: ManageDsalT)

The client may provide the ManageDsaIT control with an operation to indicate that the operation is intended to manage objects within the DSA (server) Information Tree.  The control causes Directory-specific entries (DSEs), regardless of type, to be treated as normal entries allowing clients to interrogate and update these entries using LDAP operations.
<font color=red>client在option中提供一个ManageDsaIT control/控件，以指示该option旨在管理 DSA(server)信息树中的object。</font>
<font color=red>该control导致目录特定条目 (DSE)，无论类型如何，都被视为正常条目，允许客户端使用 LDAP 操作询问和更新这些条目。</font>

A client MAY specify the following control when issuing an add, compare, delete, modify, modifyDN, search request or an extended operation for which the control is defined.
<font color=red>当发出add, compare, delete, modify, modifyDN, search request  或定义了该control的extended-operation 时 ，client可以指定以下control。</font>

The control type is 2.16.840.1.113730.3.4.2.  The control criticality may be TRUE or, if FALSE, absent.  The control value is absent.
<font color=green>control.type为 2.16.840.1.113730.3.4.2。</font>
<font color=green>control.criticality TRUE，如果为 FALSE，则不存在。</font>
<font color=green>control.value不存在。</font>

When the control is present in the request, the server SHALL NOT generate a referral or continuation reference based upon information held in referral objects and instead SHALL treat the referral object as a normal entry.  The server, however, is still free to return referrals for other reasons.  When not present, referral objects SHALL be handled as described above.
<font color=blue>当request/请求中存在该控件时，服务器不应根据referral object中保存的信息生成referral或continuation reference，而是应将referral object视为normal-object。</font>
<font color=blue>但是，服务器仍然可以出于其他原因  自由地返回referrals。</font>
当不存在时，referral object应按上述方式处理。

The control MAY cause other objects to be treated as normal entries as defined by subsequent documents.
该控件可能会导致   其他对象被视为   后续文档定义的正常条目。



# 4.Named Subordinate References

A named subordinate reference is constructed by instantiating a referral object in the referencing server with ref attribute values which point to the corresponding subtree maintained in the referenced server.  In general, the name of the referral object is the same as the referenced object and this referenced object is a context prefix [X.501].
<font color=blue>named subordinate reference是通过  在  引用服务器   中实例化  引用对象/referral object  来构造的，ref attribute value指向被引用服务器中维护的相应子树/subtree。 </font>
<font color=blue>通常，referral object的名称与referenced object的名称相同，并且该referenced object是上下文前缀 [X.501]。</font>

That is, if server A holds "DC=example,DC=net" and server B holds "DC=sub,DC=example,DC=net", server A may contain a referral object named "DC=sub,DC=example,DC=net" which contains a ref attribute with value of "ldap://B/DC=sub,DC=example,DC=net".
<font color=blue>**也就是说，如果服务器 A 持有"DC=example,DC=net"而服务器 B 持有"DC=sub,DC=example,DC=net"，则服务器 A 可能包含名为"DC=sub,DC=example,DC=net"的引用对象/referral object  ，其中包含一个值为"ldap://B/DC=sub,DC=example,DC=net"的 ref 属性。**</font>

```ABNF
  dn: DC=sub,DC=example,DC=net
  dc: sub
  ref: ldap://B/DC=sub,DC=example,DC=net
  objectClass: referral
  objectClass: extensibleObject
```

Typically the DN of the referral object and the DN of the object in the referenced server are the same.
<font color=blue>通常，referral object的 DN 和referenced server中object的 DN 相同。</font>

If the ref attribute has multiple values, all the DNs contained within the LDAP URLs SHOULD be equivalent.  Administrators SHOULD avoid configuring naming loops using referrals.
<font color=blue>如果 ref 属性有多个值，则 LDAP URL 中包含的所有 DN 应该是等效的。 </font>
管理员应该避免使用引用配置命名循环。

Named references MUST be treated as normal entries if the request includes the ManageDsaIT control as described in section 3.
<font color=blue>如果request包含第 3 节中描述的 ManageDsaIT 控件，则Named references必须被视为normal-entry。</font>



# 5. Scenarios(不同的场景下)

The following sections contain specifications of how referral objects should be used in different scenarios followed by examples that illustrate that usage.  The scenarios described here consist of referral object handling when finding target of a non-search operation, when finding the base of a search operation, and when generating search references.  Lastly, other operation processing considerations are presented.
以下部分包含  <font color=green>在不同场景中  应如何使用referral object的规范，然后是说明该用法的示例。</font>
此处描述的场景包括 <font color=green>在查找non-search-operation的target、查找search-operation的base  以及   生成 search-reference时    的referral object-handle/处理。</font>
最后，介绍了其他操作处理注意事项。

It is to be noted that, in this document, a search operation is conceptually divided into two distinct, sequential phases: (1) finding the base object where the search is to begin, and (2) performing the search itself.  The first phase is similar to, but not the same as, finding the target of a non-search operation.
需要注意的是，<font color=green>在本文档中，搜索操作在概念上分为两个不同的连续阶段：(1) 找到要开始搜索的base-object，以及 (2) 执行搜索本身。</font>
<font color=green>第一阶段与  查找non-search-operation的target   类似但不相同。</font>

It should also be noted that the ref attribute may have multiple values and, where these sections refer to a single ref attribute value, multiple ref attribute values may be substituted and SHOULD be processed and returned (in any order) as a group in a referral or search reference in the same way as described for a single ref attribute value.
还应该注意的是，ref 属性可能有多个值，并且当这些部分引用单个 ref 属性值时，多个 ref 属性值可能会被替换，并且应该作为一个组中的一个组进行处理和返回（以任何顺序）或以与针对单个 ref 属性值描述的相同方式搜索引用。

Search references returned for a given request may be returned in any order.
<font color=green>可以按任何顺序返回   为给定请求返回的搜索引用/Search reference。</font>

## 5.1.  Example Configuration

For example, suppose the contacted server (hosta) holds the entry "O=MNN,C=WW" and the entry "CN=Manager,O=MNN,C=WW" and the following  referral objects:
例如，假设联系的服务器 (hosta) 拥有entry"O=MNN,C=WW"和entry"CN=Manager,O=MNN,C=WW" 以及以下referral object：

```ABNF
      dn: OU=People,O=MNN,C=WW
      ou: People
      ref: ldap://hostb/OU=People,O=MNN,C=US
      ref: ldap://hostc/OU=People,O=MNN,C=US
      objectClass: referral
      objectClass: extensibleObject
    
      dn: OU=Roles,O=MNN,C=WW
      ou: Roles
      ref: ldap://hostd/OU=Roles,O=MNN,C=WW
      objectClass: referral
      objectClass: extensibleObject
```
The first referral object provides the server with the knowledge that subtree "OU=People,O=MNN,C=WW" is held by hostb and hostc (e.g., one is the master and the other a shadow).  The second referral object provides the server with the knowledge that the subtree "OU=Roles,O=MNN,C=WW" is held by hostd.
<font color=blue>第一个referral object向服务器提供了这样的知识：subtree "OU=People,O=MNN,C=WW"由 hostb 和 hostc 持有（例如，一个是master，另一个是shadow）。 </font>
<font color=blue>第二个referral object向服务器提供了subtree "OU=Roles,O=MNN,C=WW"由hostd 持有的知识。</font>

Also, in the context of this document, the "nearest naming context" means the deepest context which the object is within.  That is, if the object is within multiple naming contexts, the nearest naming context is the one which is subordinate to all other naming contexts the object is within.
<font color=blue>此外，在本文档的上下文中，“最近命名上下文”/"nearest naming context"    是指object所在的最深上下文。 </font>
**也就是说，如果对象在多个命名上下文中，则最近的命名上下文是：从属于对象所在的所有其他命名上下文的命名上下文。**



## 5.2.  Target Object Considerations(target-object的注意事项)

This section details referral handling for add, compare, delete, modify, and modify DN operations.  If the client requests any of these operations, there are four cases that the server must handle with respect to the target object.
<font color=blue>本节详细介绍了add, compare, delete, modify,和modify DN  操作/operation的  引用处理/referral-handle。</font>
<font color=blue>如果client请求这些operation中的任何一个，则server必须针对target-object处理四种情况。</font>

The DN part MUST be modified such that it refers to the appropriate target in the referenced server (as detailed below).  Even where the DN to be returned is the same as the target DN, the DN part SHOULD NOT be trimmed.
<font color=blue>DN 部分必须被修改，以便它引用  引用服务器中的  appropriate-target（如下详述）。</font>
<font color=blue>即使要返回的DN 与terget-DN 相同，也不应该修剪 DN 部分。</font>

In cases where the URI to be returned is a LDAP URL, the server SHOULD trim any present scope, filter, or attribute list from the URI before returning it.  Critical extensions MUST NOT be trimmed or modified.
<font color=blue>在要返回的 URI 是 LDAP-URL 的情况下，server应该在返回之前从 URI 中修剪任何现有的scope、filter或attribute list。不得修剪或修改  关键扩展/Critical-extension。</font>



Case 1: The target object is not held by the server and is not within or subordinate to any naming context nor subordinate to any referral object held by the server.
<font color=green>情况 1：target object不由server持有，也不在任何命名上下文内或从属于任何命名上下文，也不从属于server持有的任何referral object。</font>

The server SHOULD process the request normally as appropriate for a non-existent base which is not within any naming context of the server (generally return noSuchObject or a referral based upon superior knowledge reference information).  This document does not detail management or processing of superior knowledge reference information.
<font color=green>对于不存在于server任何命名上下文中的base，server应该正常处理request(通常返回 noSuchObject 或基于高级引用信息的referral)。</font>
本文档不详述   高级引用信息/superior-knowledge-reference-information   的管理或处理。



Case 2: The target object is held by the server and is a referral object.
<font color=blue>情况二：target object由server持有，是一个referral object。</font>

The server SHOULD return the URI value contained in the ref attribute of the referral object appropriately modified as described above.
server应该返回包含在referral object的 ref 属性中的 URI 值，并按上述方式进行适当修改。

Example: If the client issues a modify request for the target object of "OU=People,O=MNN,c=WW", the server will return:
示例：如果客户端对 target object"OU=People,O=MNN,c=WW" 发出修改请求，服务器将返回：

```
         ModifyResponse (referral) {
             ldap://hostb/OU=People,O=MNN,C=WW
             ldap://hostc/OU=People,O=MNN,C=WW
         }
```

   

Case 3: The target object is not held by the server, but the **nearest naming context** contains no referral object which the target object is subordinate to.
<font color=green>情况 3：target-object不由server持有，但**最近的命名上下文**不包含target object从属的referral object。</font>

If the nearest naming context contains no referral object which the target is subordinate to, the server SHOULD process the request as appropriate for a nonexistent target (generally return noSuchObject).
<font color=green>如果  最近的命名上下文   不包含target从属的referral-object，则服务器应该把request处理为： 不存在的target(通常返回noSuchObject)。</font>



Case 4: The target object is not held by the server, but the nearest naming context contains a referral object which the target object is subordinate to.
<font color=blue>情况 4：target-object不由服务器持有，但  "nearest-naming-context"   包含target object 从属的referral object。</font>

If a client requests an operation for which the target object is not held by the server and the nearest naming context contains a referral object which the target object is subordinate to, the server SHOULD return a referral response constructed from the URI portion of the ref value of the referral object.
<font color=blue>如果client请求的操作的target-object不由server持有，并且  最近的命名上下文  包含target-object从属的referral object，则server应该返回一个referral-response( 从referral-object的ref属性值的URI部分构造的)。</font>

Example: If the client issues an add request where the target object has a DN of "CN=Manager,OU=Roles,O=MNN,C=WW", the server will return:
示例：如果client发出添加请求，其中target-object的DN为"CN=Manager,OU=Roles,O=MNN,C=WW"，则server将返回：

```
         AddResponse (referral) {
             ldap://hostd/CN=Manager,OU=Roles,O=MNN,C=WW"
         }
```
Note that the DN part of the LDAP URL is modified such that it refers to the appropriate entry in the referenced server.
<font color=red>注意，LDAP-URL的DN部分已修改，以便它  引用 被引用服务器中的 适当条目。</font>



## 5.3.  Base Object Considerations(base-object的注意事项)

This section details referral handling for base object processing within search operations.  Like target object considerations for non-search operations, there are the four cases.
<font color=blue>本节详细介绍了search-operation中   基础对象处理/base-object-process 的 引用处理referral-handle。</font>
与non-search operation的target-object注意事项一样，有四种情况。

In cases where the URI to be returned is a LDAP URL, the server MUST provide an explicit scope specifier from the LDAP URL prior to returning it.  In addition, the DN part MUST be modified such that it refers to the appropriate target in the referenced server (as detailed below).
在要返回的 URI 是 LDAP-URL 的情况下，服务器必须在返回之前从 LDAP-URL 提供显式scope说明符。
此外，必须修改 DN 部分，以便它引用  被引用服务器中的适当target（如下详述）。

If aliasing dereferencing was necessary in finding the referral object, the DN part of the URI MUST be replaced with the base DN as modified by the alias dereferencing such that the return URL refers to the new target object per [RFC2251, 4.1.11].
如果在查找referral object时 需要使用  别名解引用，则必须将URI的DN部分替换为  通过别名解引用修改的base DN，以便返回 URL引用每个new-target-object。

Critical extensions MUST NOT be trimmed nor modified.
不得修剪或修改  关键扩展。



Case 1: The base object is not held by the server and is not within nor subordinate to any naming context held by the server.
<font color=green>情况 1：base object不由server持有，也不在server持有的任何命名上下文中，也不从属于任何命名上下文。</font>

The server SHOULD process the request normally as appropriate for a non-existent base which not within any naming context of the server (generally return a superior referral or noSuchObject). This document does not detail management or processing of superior knowledge references.
对于不存在的base(它不存在于服务器的任何命名上下文中)，服务器应该正常处理该请求/request（通常返回superior referral或 noSuchObject）。
本文档不详细说明   高级知识参考文献的 管理或处理。。



Case 2: The base object is held by the server and is a referral object.
<font color=blue>情况2：base object由server持有，是一个referral object。</font>

The server SHOULD return the URI value contained in the ref attribute of the referral object appropriately modified as described above.
<font color=blue>server应该返回包含在referral object的 ref 属性中的 URI 值，并按上述方式进行适当修改。</font>

Example: If the client issues a subtree search in which the base object is "OU=Roles,O=MNN,C=WW", the server will return
示例：如果client发出base-object为"OU=Roles,O=MNN,C=WW"的子树搜索/subtree-search，server将返回

```ABNF
         SearchResultDone (referral) {
             ldap://hostd/OU=Roles,O=MNN,C=WW??sub
         }
```
If the client were to issue a base or oneLevel search instead of subtree, the returned LDAP URL would explicitly specify "base" or "one", respectively, instead of "sub".
如果client要发出 base或oneLevel搜索而不是subtree，则返回的LDAP-URL 将分别明确/显示指定"base"或"one"，而不是"sub"。



Case 3: The base object is not held by the server, but the nearest naming context contains no referral object which the base object is subordinate to.
<font color=green>情况 3：base object不由server持有，但  最近的命名上下文  不包含base-object从属的referral-object。</font>

If the nearest naming context contains no referral object which the base is subordinate to, the request SHOULD be processed normally as appropriate for a nonexistent base (generally return noSuchObject).
<font color=green>如果  最近的命名上下文  不包含该base从属的referral-object，则该请求应该被正常地处理为：不存在的base(通常返回noSuchObject)。</font>



Case 4: The base object is not held by the server, but the nearest naming context contains a referral object which the base object is subordinate to.
<font color=blue>情况 4：base object不由server持有，但  最近的命名上下文  包含base object从属的referral object。</font>

If a client requests an operation for which the target object is not held by the server and the nearest naming context contains a referral object which the target object is subordinate to, the server SHOULD return a referral response which is constructed from the URI portion of the ref value of the referral object.
<font color=blue>如果client请求的操作的target object不是由server持有，并且  最近的命名上下文   包含target object从属的referral object，则server应该返回一个referral response，该response是从referral object的ref属性值的URI部分构造的。</font>

Example: If the client issues a base search request for "CN=Manager,OU=Roles,O=MNN,C=WW", the server will return
示例：如果客户端发出"CN=Manager,OU=Roles,O=MNN,C=WW"的base-search request，服务器将返回

```ABNF
         SearchResultDone (referral) {
             ldap://hostd/CN=Manager,OU=Roles,O=MNN,C=WW??base"
         }
```
If the client were to issue a subtree or oneLevel search instead of base, the returned LDAP URL would explicitly specify "sub" or "one", respectively, instead of "base".
如果客户端要发出subtree或 oneLevel 搜索而不是base，则返回的 LDAP-URL 将分别明确指定“sub”或“one”，而不是“base”。

Note that the DN part of the LDAP URL is modified such that it refers to the appropriate entry in the referenced server.
<font color=red>请注意，LDAP-URL 的 DN 部分已修改，以便它引用  引用服务器 中的 相应条目。</font>



## 5.4.  Search Continuation Considerations(Search Continuation注意事项)

For search operations, once the base object has been found and  determined not to be a referral object, the search may progress.  Any entry matching the filter and scope of the search which is not a  referral object is returned to the client normally as described in  [RFC2251].
<font color=green>对于搜索操作，一旦找到base-object并确定其不是referral-object，搜索可能会继续进行。</font>
<font color=green>如[RFC2251]中所述，任何  与filter和search-scope匹配  但不是referral-object的entry， 通常都会返回给客户端。</font>

For each referral object within the requested scope, regardless of the search filter, the server SHOULD return a SearchResultReference which is constructed from the URI component of values of the ref attribute.  If the URI component is not a LDAP URL, it should be returned as is.  If the LDAP URL's DN part is absent or empty, the DN part must be modified to contain the DN of the referral object.  If the URI component is a LDAP URL, the URI SHOULD be modified to add an explicit scope specifier.
<font color=green>对于requested-scope内的每个referral-object ，无论search-filter如何，服务器都应该返回一个 SearchResultReference，它是根据 ref 属性值的 URI 组件构造的。</font>
<font color=green>如果 URI 组件不是 LDAP-URL，则应按原样返回。</font>
<font color=green>如果 LDAP-URL 的 DN 部分不存在或为空，则必须修改 DN 部分以包含referral-object的 DN。</font>
<font color=green>如果 URI 组件是 LDAP URL，则应该修改 URI 以添加显式scope说明符。</font>

<font color=green>Subtree Example:</font>
子树示例：

If a client requests a subtree search of "O=MNN,C=WW", then in addition to any entries within scope which match the filter, hosta will also return two search references as the two referral objects are within scope.  One possible response might be:
如果client请求“O=MNN,C=WW”的subtree-search，那么除了scope内与filter匹配的 任何entry之外，hosta 还将返回两个search-reference，因为两个referral-object都在scope内。一种可能的response可能是：

```    
          SearchEntry for O=MNN,C=WW
          SearchResultReference {
              ldap://hostb/OU=People,O=MNN,C=WW??sub
              ldap://hostc/OU=People,O=MNN,C=WW??sub
          }
          SearchEntry for CN=Manager,O=MNN,C=WW
          SearchResultReference {
              ldap://hostd/OU=Roles,O=MNN,C=WW??sub
          }
          SearchResultDone (success)
```
<font color=green>One-Level Example:</font>
一级示例：

If a client requests a one level search of "O=MNN,C=WW" then, in addition to any entries one level below the "O=MNN,C=WW" entry matching the filter, the server will also return two search references as the two referral objects are within scope.  One possible sequence is shown:
如果client请求“O=MNN,C=WW”的one-level-search，那么除了匹配filter的 entry-"O=MNN,C=WW"的任何下一级entry之外，服务器还将返回两个search-reference，因为两个referral-object都在scope内。
显示了一种可能的序列：

```ABNF
          SearchResultReference {
              ldap://hostb/OU=People,O=MNN,C=WW??base
              ldap://hostc/OU=People,O=MNN,C=WW??base
          }
          SearchEntry for CN=Manager,O=MNN,C=WW
          SearchResultReference {
              ldap://hostd/OU=Roles,O=MNN,C=WW??base
          }
          SearchResultDone (success)
```
Note: Unlike the examples in Section 4.5.3.1 of RFC 2251, the LDAP URLs returned with the SearchResultReference messages contain, as required by this specification, an explicit scope specifier.
注意：与 RFC 2251 的第 4.5.3.1 节中的示例不同，随 SearchResultReference 消息返回的 LDAP-URL，根据本规范的要求，包含显式scope说明符。



## 5.6.  Other Considerations

This section details processing considerations for other operations.
本节详细介绍了其他操作的处理注意事项。

## 5.6.1 Bind

Servers SHOULD NOT return referral result code if the bind name (or authentication identity or authorization identity) is (or is subordinate to) a referral object but MAY use the knowledge information to process the bind request (such as in support a future distributed operation specification).  Where the server makes no use of the knowledge information, the server processes the request normally as appropriate for a non-existent authentication or authorization identity (e.g., return invalidCredentials).
如果  bind-name(或认证身份或授权身份)是(或从属于)一个referral-object，则server不应返回resultCode: referral，但可以使用knowledge-information来处理绑定请求（例如支持未来的分布式操作规范） ）。 
在服务器不使用knowledge-information的情况下，服务器通常根据不存在的身份验证或授权身份-处理请求 (例如，返回 invalidCredentials)。

## 5.6.2 Modify DN

If the newSuperior is a referral object or is subordinate to a referral object, the server SHOULD return affectsMultipleDSAs.  If the newRDN already exists but is a referral object, the server SHOULD return affectsMultipleDSAs instead of entryAlreadyExists.
如果 newSuperior 是一个referral-object或从属于一个referral-object，服务器应该返回 ImpactMultipleDSA。 
如果 newRDN 已经存在但是是一个referral-object，服务器应该返回 ImpactMultipleDSA 而不是 entryAlreadyExists。

# 6.Security Considerations

This document defines mechanisms that can be used to tie LDAP (and other) servers together.  The information used to tie services together should be protected from unauthorized modification.  If the server topology information is not public information, it should be protected from unauthorized disclosure as well.
本文档定义了可用于将    LDAP(和其他)服务器   联系在一起的机制。 
用于将服务联系在一起的信息应受到保护，以免遭到未经授权的修改。
 如果服务器拓扑信息不是公开信息，也应该防止未经授权的泄露。



# 7. Acknowledgments(略)

This document borrows heavily from previous work by IETF LDAPext
Working Group.  In particular, this document is based upon "Named
Referral in LDAP Directories" (an expired Internet Draft) by
Christopher Lukas, Tim Howes, Michael Roszkowski, Mark C. Smith, and
Mark Wahl.

# 8. Normative References(略)

[RFC2079] Smith, M., "Definition of an X.500 Attribute Type and an
          Object Class to Hold Uniform Resource Identifiers (URIs)",
          RFC 2079, January 1997.

[RFC2119] Bradner, S., "Key Words for use in RFCs to Indicate
          Requirement Levels", BCP 14, RFC 2119, March 1997.

[RFC2251] Wahl, M., Howes, T. and S. Kille, "Lightweight Directory
          Access Protocol (v3)", RFC 2251, December 1997.

[RFC2252] Wahl, M., Coulbeck, A., Howes, T. and S. Kille,
          "Lightweight Directory Access Protocol (v3): Attribute
          Syntax Definitions", RFC 2252, December 1997.

[RFC2253] Wahl, M., Kille, S. and T. Howes, "Lightweight Directory
          Access Protocol (v3): UTF-8 String Representation of
          Distinguished Names", RFC 2253, December 1997.

[RFC2255] Howes, T. and M. Smith, "The LDAP URL Format", RFC 2255,
          December, 1997.

[RFC2396] Berners-Lee, T., Fielding, R. and L. Masinter, "Uniform
          Resource Identifiers (URI): Generic Syntax", RFC 2396,
          August 1998.

[X.501]   ITU-T, "The Directory: Models", X.501, 1993.





# 9. Informative References(略)

[X.500]   ITU-T, "The Directory: Overview of Concepts, Models, and
          Services", X.500, 1993.

[X.511]   ITU-T, "The Directory: Abstract Service Definition", X.500,
          1997.







Zeilenga                    Standards Track                    [Page 12]

RFC 3296    Named Subordinate References in LDAP Directories   July 2002

# 10. Author's Address(略)

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org













































Zeilenga                    Standards Track                    [Page 13]

RFC 3296    Named Subordinate References in LDAP Directories   July 2002

# 11. Full Copyright Statement(略)

   Copyright (C) The Internet Society (2002).  All Rights Reserved.

   This document and translations of it may be copied and furnished to
   others, and derivative works that comment on or otherwise explain it
   or assist in its implementation may be prepared, copied, published
   and distributed, in whole or in part, without restriction of any
   kind, provided that the above copyright notice and this paragraph are
   included on all such copies and derivative works.  However, this
   document itself may not be modified in any way, such as by removing
   the copyright notice or references to the Internet Society or other
   Internet organizations, except as needed for the purpose of
   developing Internet standards in which case the procedures for
   copyrights defined in the Internet Standards process must be
   followed, or as required to translate it into languages other than
   English.

   The limited permissions granted above are perpetual and will not be
   revoked by the Internet Society or its successors or assigns.

   This document and the information contained herein is provided on an
   "AS IS" basis and THE INTERNET SOCIETY AND THE INTERNET ENGINEERING
   TASK FORCE DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
   BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION
   HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED WARRANTIES OF
   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

# Acknowledgement(略)

   Funding for the RFC Editor function is currently provided by the
   Internet Society.



















Zeilenga                    Standards Track                    [Page 14]

