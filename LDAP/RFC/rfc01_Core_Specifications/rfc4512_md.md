





Network Working Group                                        K. Zeilenga
Request for Comments: 4512                           OpenLDAP Foundation
Obsoletes: 2251, 2252, 2256, 3674                              June 2006
Category: Standards Track

RFC 4512                      LDAP Models                      June 2006



# Lightweight Directory Access Protocol (LDAP): Directory Information Models(目录信息模型)



## Status of This Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice

   Copyright (C) The Internet Society (2006).

## Abstract

The Lightweight Directory Access Protocol (LDAP) is an Internet protocol for accessing distributed directory services that act in accordance with X.500 data and service models.  This document describes the X.500 Directory Information Models, as used in LDAP.
轻型目录访问协议 (LDAP) 是一种 Internet 协议，用于访问按照 X.500 数据和服务模型 运行的分布式目录服务。 本文档描述了 LDAP 中使用的 X.500 目录信息模型。



# Table of Contents
```
   1. Introduction ....................................................3
      1.1. Relationship to Other LDAP Specifications ..................3
      1.2. Relationship to X.501 ......................................4
      1.3. Conventions ................................................4
      1.4. Common ABNF Productions ....................................4
   2. Model of Directory User Information .............................6
      2.1. The Directory Information Tree .............................7
      2.2. Structure of an Entry ......................................7
      2.3. Naming of Entries ..........................................8
      2.4. Object Classes .............................................9
      2.5. Attribute Descriptions ....................................12
      2.6. Alias Entries .............................................16
   3. Directory Administrative and Operational Information ...........17
      3.1. Subtrees ..................................................17
      3.2. Subentries ................................................18
      3.3. The 'objectClass' attribute ...............................18
      3.4. Operational Attributes ....................................19
   4. Directory Schema ...............................................22
      4.1. Schema Definitions ........................................23
      4.2. Subschema Subentries ......................................32
      4.3. 'extensibleObject' object class ...........................35
      4.4. Subschema Discovery .......................................35
   5. DSA (Server) Informational Model ...............................36
      5.1. Server-Specific Data Requirements .........................36
   6. Other Considerations ...........................................40
      6.1. Preservation of User Information ..........................40
      6.2. Short Names ...............................................41
      6.3. Cache and Shadowing .......................................41
   7. Implementation Guidelines ......................................42
      7.1. Server Guidelines .........................................42
      7.2. Client Guidelines .........................................42
   8. Security Considerations ........................................43
   9. IANA Considerations ............................................43
   10. Acknowledgements ..............................................44
   11. Normative References ..........................................45
   Appendix A. Changes ...............................................47
      A.1. Changes to RFC 2251 .......................................47
      A.2. Changes to RFC 2252 .......................................49
      A.3. Changes to RFC 2256 .......................................50
      A.4. Changes to RFC 3674 .......................................51

```



# 1. Introduction(介绍)

This document discusses the X.500 Directory Information Models [X.501], as used by the Lightweight Directory Access Protocol (LDAP) [RFC4510].
本文档讨论了 轻量级目录访问协议(LDAP)[RFC4510]所使用的 X.500目录信息模型[X.501]。

The Directory is "a collection of open systems cooperating to provide directory services" [X.500].  The information held in the Directory is collectively known as the Directory Information Base (DIB).  A Directory user, which may be a human or other entity, accesses the Directory through a client (or Directory User Agent (DUA)).  The client, on behalf of the directory user, interacts with one or more servers (or Directory System Agents (DSA)).  A server holds a fragment of the DIB.
目录是“合作提供目录服务的开放系统的集合”[X.500]。<font color=red>目录中保存的信息 统称为目录信息库 (DIB)。</font>目录用户，可以是人或其他实体，通过客户端（或目录用户代理 (DUA)）访问目录。客户端代表目录用户与一台或多台服务器（或目录系统代理 (DSA)）交互。服务器持有 DIB 的一个片段。

The DIB contains two classes of information:
DIB 包含两类信息：

1) user information (e.g., information provided and administrated by users).  Section 2 describes the Model of User Information.
用户信息（例如，由用户提供和管理的信息）。第 2 节描述了用户信息模型。

2) administrative and operational information (e.g., information used to administer and/or operate the directory).  Section 3 describes the model of Directory Administrative and Operational   Information.
管理和操作信息（例如，用于管理和/或操作目录的信息）。第 3 节描述了目录管理和操作信息模型。

These two models, referred to as the generic Directory Information Models, describe how information is represented in the Directory. These generic models provide a framework for other information models.  Section 4 discusses the subschema information model and subschema discovery.  Section 5 discusses the DSA (Server) Informational Model.
这两个模型，称为通用目录信息模型，描述了如何在目录中表示信息。这些通用模型为其他信息模型提供了一个框架。第 4 节讨论子模式信息模型和子模式发现。第 5 节讨论 DSA（服务器）信息模型。

Other X.500 information models (such as access control distribution knowledge and replication knowledge information models) may be adapted for use in LDAP.  Specification of how these models apply to LDAP is left to future documents.
其他 X.500 信息模型（例如访问控制分发知识和复制知识信息模型）可能适用于 LDAP。这些模型如何应用于 LDAP 的规范留给以后的文档。



<font color=red>总结：</font>
​	目录中保存的信息称为 目录信息库/DIB，DIB包含两类信息：
​		1)	用户信息(由用户提供和管理的信息)；
​		2)	管理和操作信息(用于管理和操作目录的信息)；
​	这两个模型，称为通用目录信息模型，描述了如何在目录中表示信息。





## 1.1. Relationship to Other LDAP Specifications(和其他LDAP规范的关系)

This document is a integral part of the LDAP technical specification [RFC4510], which obsoletes the previously defined LDAP technical specification, RFC 3377, in its entirety.
本文档是 LDAP 技术规范 [RFC4510] 的组成部分，它完全废弃了先前定义的 LDAP 技术规范 RFC 3377。

This document obsoletes RFC 2251, Sections 3.2 and 3.4, as well as portions of Sections 4 and 6.  Appendix A.1 summarizes changes to these sections.  The remainder of RFC 2251 is obsoleted by the [RFC4511], [RFC4513], and [RFC4510] documents.
本文档废弃了 RFC 2251 的第 3.2 和 3.4 节以及第 4 和第 6 节的部分内容。附录 A.1 总结了对这些部分的更改。 RFC 2251 的其余部分已被 [RFC4511]、[RFC4513] 和 [RFC4510] 文档废弃。

This document obsoletes RFC 2252, Sections 4, 5, and 7.  Appendix A.2 summarizes changes to these sections.  The remainder of RFC 2252 is obsoleted by [RFC4517].
本文档废弃了 RFC 2252 第 4、5 和 7 节。附录 A.2 总结了对这些部分的更改。 RFC 2252 的其余部分已被 [RFC4517] 废弃。

This document obsoletes RFC 2256, Sections 5.1, 5.2, 7.1, and 7.2. Appendix A.3 summarizes changes to these sections.  The remainder of RFC 2256 is obsoleted by [RFC4519] and [RFC4517].
本文档废弃了 RFC 2256 第 5.1、5.2、7.1 和 7.2 节。 附录 A.3 总结了对这些部分的更改。 RFC 2256 的其余部分已被 [RFC4519] 和 [RFC4517] 废弃。

This document obsoletes RFC 3674 in its entirety.  Appendix A.4 summarizes changes since RFC 3674.
本文档完全废弃了 RFC 3674。 附录 A.4 总结了自 RFC 3674 以来的变化。



## 1.2.  Relationship to X.501

This document includes material, with and without adaptation, from [X.501] as necessary to describe this protocol.  These adaptations (and any other differences herein) apply to this protocol, and only this protocol.
本文档包括描述本协议所必需的来自 [X.501] 的材料，无论是否经过改编。 这些改编（以及此处的任何其他差异）适用于本协议，并且仅适用于本协议。



## 1.3.  Conventions(约定)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].
本文中的关键字...是按照BCP 14 [RFC2119]中的描述进行解释。

Schema definitions are provided using LDAP description formats (as defined in Section 4.1).  Definitions provided here are formatted (line wrapped) for readability.  Matching rules and LDAP syntaxes referenced in these definitions are specified in [RFC4517].
提供的  模式/schema定义  是使用 LDAP 描述格式（如第 4.1 节中定义的）。 此处提供的定义已格式化（换行）以提高可读性。 这些定义中引用的匹配规则和 LDAP 语法在 [RFC4517] 中指定。

## 1.4.  Common ABNF Productions(ABNF中常用的格式/形式)

A number of syntaxes in this document are described using Augmented Backus-Naur Form (ABNF) [RFC4234].  These syntaxes (as well as a number of syntaxes defined in other documents) rely on the following common productions:
<font color=red>本文档中的许多语法 使用增强型 巴科斯范式 (ABNF) [RFC4234] 进行描述。</font> 这些语法（以及其他文档中定义的许多语法）依赖于以下常见的产生式：

```ABNF
      keystring = leadkeychar *keychar
      leadkeychar = ALPHA
      keychar = ALPHA / DIGIT / HYPHEN
      number  = DIGIT / ( LDIGIT 1*DIGIT )								-- 数字 
    
      ALPHA   = %x41-5A / %x61-7A   ; "A"-"Z" / "a"-"z"
      DIGIT   = %x30 / LDIGIT       ; "0"-"9"
      LDIGIT  = %x31-39             ; "1"-"9"
      HEX     = DIGIT / %x41-46 / %x61-66 ; "0"-"9" / "A"-"F" / "a"-"f"
    
      SP      = 1*SPACE  ; one or more " "								-- 一个或多个 空格
      WSP     = 0*SPACE  ; zero or more " "								-- 0 个或多个空格

      NULL    = %x00 ; null (0)
      SPACE   = %x20 ; space (" ")										-- 空格 即" "
      DQUOTE  = %x22 ; quote (""")
      SHARP   = %x23 ; octothorpe (or sharp sign) ("#")
      DOLLAR  = %x24 ; dollar sign ("$")
      SQUOTE  = %x27 ; single quote ("'")
      LPAREN  = %x28 ; left paren ("(")
      RPAREN  = %x29 ; right paren (")")
      PLUS    = %x2B ; plus sign ("+")
      COMMA   = %x2C ; comma (",")
      HYPHEN  = %x2D ; hyphen ("-")
      DOT     = %x2E ; period (".")
      SEMI    = %x3B ; semicolon (";")
      LANGLE  = %x3C ; left angle bracket ("<")
      EQUALS  = %x3D ; equals sign ("=")
      RANGLE  = %x3E ; right angle bracket (">")
      ESC     = %x5C ; backslash ("\")									-- \
      USCORE  = %x5F ; underscore ("_")
      LCURLY  = %x7B ; left curly brace "{"
      RCURLY  = %x7D ; right curly brace "}"
    
      ; Any UTF-8 [RFC3629] encoded Unicode [Unicode] character			-- 任何UTF-8编码的Unicode字符
      UTF8    = UTF1 / UTFMB
      UTFMB   = UTF2 / UTF3 / UTF4
      UTF0    = %x80-BF
      UTF1    = %x00-7F
      UTF2    = %xC2-DF UTF0
      UTF3    = %xE0 %xA0-BF UTF0 / %xE1-EC 2(UTF0) /
                %xED %x80-9F UTF0 / %xEE-EF 2(UTF0)
      UTF4    = %xF0 %x90-BF 2(UTF0) / %xF1-F3 3(UTF0) /
                %xF4 %x80-8F 2(UTF0)
    
      OCTET   = %x00-FF ; Any octet (8-bit data unit)
```


Object identifiers (OIDs) [X.680] are represented in LDAP using a dot-decimal format conforming to the ABNF:
对象标识符 (OID) [X.680] 在 LDAP 中使用 符合ABNF 的 点分十进制格式 表示：

```ABNF
  numericoid = number 1*( DOT number )
```

<font color=red>**<font>

Short names, also known as descriptors, are used as more readable aliases for object identifiers.  Short names are case insensitive and conform to the ABNF:
短名称，也称为描述符，用作 对象标识符/OID 的更易读的别名。 短名称不区分大小写并符合 ABNF：

```ABNF
  descr = keystring
```



Where either an object identifier or a short name may be specified, the following production is used:
如果可以指定对象标识符/OID或短名称，则使用以下产生式：

```ABNF
  oid = descr / numericoid
```

While the `<descr>` form is generally preferred when the usage is restricted to short names referring to object identifiers that identify like kinds of objects (e.g., attribute type descriptions, matching rule descriptions, object class descriptions), the `<numericoid> `form should be used when the object identifiers may identify multiple kinds of objects or when an unambiguous short name (descriptor) is not available.
虽然` <descr>` 形式  在用法  被限制为  短名称引用 标识类似/相似种类对象的 对象标识符  通常 是首选的(例如，属性类型描述、匹配规则描述、对象类描述)，
但是，当 对象标识符 可以/可能 标识多种对象 或 没有 明确的短名称/descr 可用时，应该使用`<numericoid>`。

Implementations SHOULD treat short names (descriptors) used in an ambiguous manner (as discussed above) as unrecognized. Short Names (descriptors) are discussed further in Section 6.2.
实现"应该"将  以不明确方式(如上所述)使用的短名称/descr视为无法识别。 短名称/descr在第 6.2 节中进一步讨论。



总结： 

​	<font color=red>OID/对象标识符： 是使用 ABNF的点分十进制表示；</font>
​	<font color=red>descr/短名称：     是OID的别名；</font>



# 2.Model of Directory User Information(目录的用户信息模型)

- As [X.501] states: 正如[X.501]所述
    - The purpose of the Directory is to hold, and provide access to, information about objects of interest (objects) in some 'world'. An object can be anything which is identifiable (can be named).
        - <font color=red>目录的目的是 保存，并提供 对某些感兴趣  对象信息的访问。 </font>
        - 对象可以是任何可识别(可以命名)的东西。
    - An object class is an identified family of objects, or conceivable objects, which share certain characteristics.  Every object belongs to at least one class.  An object class may be a subclass of other object classes, in which case the members of the former class, the subclass, are also considered to be members of the latter classes, the superclasses.  There may be subclasses of subclasses, etc., to an arbitrary depth.
        - <font color=red>对象类/object-class</font>是  已识别的对象族或可得到的对象，<font color=red>它们共享某些特征。 </font>
        - <font color=red>每个对象至少属于一个类。 </font>
        - <font color=red>一个对象类可能是其他对象类的子类，在这种情况下，前一个类/子类 的成员 也被认为是后一个类/超类 的成员。 </font>
        - 可能存在任意深度的子类的子类等。

A directory entry, a named collection of information, is the basic unit of information held in the Directory.  There are multiple kinds of directory entries.
目录(中的)<font color=red>条目</font>，<font color=red>一个</font>命名的<font color=red>信息集合</font>，<font color=red>是目录中保存信息的基本单元</font>。 
有多种目录条目。

An object entry represents a particular object.  An alias entry provides alternative naming.  A subentry holds administrative and/or operational information.
<font color=red>对象条目/object-entry   代表一个特定的对象/object。</font>
<font color=red>别名条目/alias-entry      提供替代命名。</font>
<font color=red>子条目/subentry            包含管理和/或操作信息。</font>

The set of entries representing the DIB are organized hierarchically in a tree structure known as the Directory Information Tree (DIT).
表示/代表DIB 的  <font color=red>条目集合</font>，<font color=red>被分层组织在 一个称为目录信息树 (DIT)   的树结构中。</font>

Section 2.1 describes the Directory Information Tree.   2.1 节描述了目录信息树。
Section 2.2 discusses the structure of entries. 2.2 节讨论了条目的结构。
Section 2.3 discusses naming of entries.          2.3 节讨论了条目的命名。
Section 2.4 discusses object classes.                 2.4 节讨论对象类。
Section 2.5 discusses attribute descriptions.   2.5 节讨论了属性描述。
Section 2.6 discusses alias entries.                    2.6 节讨论别名条目。



## 2.1. The Directory Information Tree(目录信息树DIT)

As noted above, the DIB is composed of a set of entries organized hierarchically in a tree structure known as the Directory Information Tree (DIT); specifically, a tree where vertices are the entries.
如上所述，DIB由 以树结构 分层组织的 条目集合组成，称为目录信息树 (DIT)； 
具体来说，一棵树，其中顶点是条目。

The arcs between vertices define relations between entries.  If an arc exists from X to Y, then the entry at X is the immediate superior of Y, and Y is the immediate subordinate of X.  An entry's superiors are the entry's immediate superior and its superiors.  An entry's subordinates are all of its immediate subordinates and their subordinates.
<<font color=red>顶点之间的弧定义了条目之间的关系。 如果从 X 到 Y 存在弧，则 X 处的条目是 Y 的直接上级，Y 是 X 的直接下级。</font>
条目的上级是条目的直接上级及其上级。 
一个条目的下属是它的所有直接下属和他们的下属。

Similarly, the superior/subordinate relationship between object entries can be used to derive a relation between the objects they represent.  DIT structure rules can be used to govern relationships between objects.
类似地，对象条目之间的上级/下级关系可用于导出它们所代表的对象之间的关系。 
<font color=red>DIT 结构/structure规则 可用于管理对象之间的关系。</font>

Note: An entry's immediate superior is also known as the entry's parent, and an entry's immediate subordinate is also known as the entry's child.  Entries that have the same parent are known as siblings.
注意：<font color=red>条目的直接上级也称为条目的父级，条目的直接下级也称为条目的子级。 具有相同父亲的条目称为兄弟。</font>



## 2.2.  Structure of an Entry(entry的结构)

An entry consists of a set of attributes that hold information about the object that the entry represents.  Some attributes represent user information and are called user attributes.  Other attributes represent operational and/or administrative information and are called operational attributes.
<font color=red>条目由属性集合组成，这些属性保存了 条目所代表的对象的信息。</font> 
<font color=red>有些属性代表用户信息，称为用户属性。 </font>
<font color=red>其他属性表示操作和/或管理信息，称为操作属性。</font>

An attribute is an attribute description (a type and zero or more options) with one or more associated values.  An attribute is often referred to by its attribute description.  For example, the 'givenName' attribute is the attribute that consists of the attribute description 'givenName' (the 'givenName' attribute type [RFC4519] and zero options) and one or more associated values.
<font color=red>属性 有  一个属性描述(一种类型和零个或多个选项)  和1个或多个关联值。</font>
<font color=red>属性 通常通过 其属性描述 来引用。</font>
例如 "givenName"属性   是由属性描述"givenName" ("givenName"属性类型[RFC4519]和零选项) 和一个或多个相关值组成的属性。

The attribute type governs whether the attribute can have multiple values, the syntax and matching rules used to construct and compare values of that attribute, and other functions.  Options indicate  subtypes and other functions.
<font color=red>属性类型/attribute-type  控制属性是否可以具有多个值、用于构造和比较  该属性值的 语法和匹配规则 、以及其他功能。</font>
选项/Optionos 表示子类型和其他功能。



Attribute values conform to the defined syntax of the attribute type.
<font color=red>属性值attribute-value  符合 属性类型/attribute-type 的定义语法。</font>

No two values of an attribute may be equivalent.  Two values are considered equivalent if and only if they would match according to the equality matching rule of the attribute type.  Or, if the attribute type is defined with no equality matching rule, two values are equivalent if and only if they are identical.  (See 2.5.1 for other restrictions.)
<font color=red>一个属性的两个值不可能是等价的。</font>
<font color=red>当且仅当 它们根据 属性类型的相等匹配规则 匹配时，两个值才被认为是等效的。</font>
<font color=red>或者，如果属性类型定义为没有相等匹配规则，则两个值相等当且仅当它们相同。 （其他限制见 2.5.1。）</font>

For example, a 'givenName' attribute can have more than one value, they must be Directory Strings, and they are case insensitive.  A 'givenName' attribute cannot hold both "John" and "JOHN", as these are equivalent values per the equality matching rule of the attribute type.
例如，“givenName”属性可以有多个值，它们必须是目录字符串，并且不区分大小写。 “givenName”属性不能同时包含“John”和“JOHN”，因为 根据/按照 属性类型的相等匹配规则，它们是等效的值。



Additionally, no attribute is to have a value that is not equivalent to itself.  For example, the 'givenName' attribute cannot have as a value a directory string that includes the REPLACEMENT CHARACTER (U+FFFD) code point, as matching involving that directory string is Undefined per this attribute's equality matching rule.
此外，任何属性都不应具有与其自身不同的值。例如，“givenName”属性不能将包含 REPLACEMENT CHARACTER (U+FFFD) 代码点的目录字符串作为值，因为根据此属性的相等匹配规则，涉及该目录字符串的匹配是未定义的。



When an attribute is used for naming of the entry, one and only one value of the attribute is used in forming the Relative Distinguished Name.  This value is known as a distinguished value.
当一个属性用于命名条目时，该属性的一个且仅一个值用于形成相对可分辨名称/RDN。该值称为可分辨值。





## 2.3.  Naming of Entries(entry的命名)

### 2.3.1.  Relative Distinguished Names(RDN的命名)

Each entry is named relative to its immediate superior.  This relative name, known as its Relative Distinguished Name (RDN) [X.501], is composed of an unordered set of one or more attribute value assertions (AVA) consisting of an attribute description with zero options and an attribute value.  These AVAs are chosen to match attribute values (each a distinguished value) of the entry.
每个条目的命名 都相对于其直接上级。 这个相对名称，称为它的相对可分辨名称 (RDN) [X.501]，由一组无序的1个或多个属性值断言 (AVA) 组成，其中包含一个具有0个选项的属性描述和1个属性值。 选择这些 AVA 来匹配条目的属性值（每个都是一个可区分的值）。

An entry's relative distinguished name must be unique among all immediate subordinates of the entry's immediate superior (i.e., all siblings).
<font color=red>条目的 相对可分辨名称/RDN 在条目的直接上级的所有直接下级(即 所有兄弟姐妹)中必须是唯一的。</font>

The following are examples of string representations of RDNs [RFC4514]:
以下是 RDN [RFC4514] 的字符串表示示例：

```ldif
  UID=12345
  OU=Engineering
  CN=Kurt Zeilenga+L=Redwood Shores
```

The last is an example of a multi-valued RDN; that is, an RDN composed of multiple AVAs.
最后一个是多值 RDN 的例子； 即由多个 AVA 组成的 RDN。



### 2.3.2.  Distinguished Names(DN)

An entry's fully qualified name, known as its Distinguished Name (DN) [X.501], is the concatenation of its RDN and its immediate superior's DN.  A Distinguished Name unambiguously refers to an entry in the tree.  The following are examples of string representations of DNs [RFC4514]:
一个条目的完全限定名称，称为其专有名称 (DN) [X.501]，是其 RDN 与其直接上级 DN 的串联。 专有名称明确地指代树中的条目。 以下是 DN [RFC4514] 的字符串表示示例：

```ldif
  UID=nobody@example.com,DC=example,DC=com
  CN=John Smith,OU=Sales,O=ACME Limited,L=Moab,ST=Utah,C=US
```

<font color=red>一个条目的DN由：其RDN和其直接上级的DN 串联 而成</font>



### 2.3.3.  Alias Names(别名)

An alias, or alias name, is "an name for an object, provided by the use of alias entries" [X.501].  Alias entries are described in Section 2.6.

<font color=red>别名是  一个对象的名称，通过使用 别名条目/alias-entry 提供”[X.501]</font>。 别名条目在第 2.6 节中描述。





## 2.4.  Object Classes

An object class is "an identified family of objects (or conceivable objects) that share certain characteristics" [X.501].
一个<font color=red>对象类</font>是  一个已识别的对象族(或可得到的对象)，它们<font color=red>共享某些特征</font>[X.501]。 

As defined in [X.501]:  
如[X.501]中所定义

  - <font color=red>Object classes </font>are used in the Directory for a number of purposes: 目录中使用的对象类有多种用途
    - describing and categorizing objects and the entries that correspond to these objects;
        - <font color=red>描述和分类 object 以及与这些object对应的entry</font>；
    - where appropriate, controlling the operation of the Directory;
        - 在适当的情况下，<font color=red>控制目录的操作/operation</font>；
    - regulating, in conjunction <font color=red>with DIT structure rule specifications</font>, the position of entries in the DIT;  
        - 结合 DIT结构规则规范，<font color=red>调整条目/entry 在 DIT 中的位置</font>；
    - regulating, in conjunction <font color=red>with DIT content rule specifications</font>, the attributes that are contained in entries;
        - 结合 DIT 内容规则规范，<font color=red>调整 条目中包含的属性</font>；
    - identifying classes of entry that are to be associated with a particular policy by the appropriate administrative authority.
        - 由适当的管理机构  识别与特定策略相关的 条目类别。
  - An object class (a subclass) may be derived from an object class (its direct superclass) which is itself derived from an even more  generic object class.  For structural object classes, this process stops at the most generic object class, 'top' (defined in Section  2.4.1).  An ordered set of superclasses up to the most superior  object class of an object class is its superclass chain.
      - <font color=red>subclass可以从superclass派生，而superclass本身又是从更通用的object-class派生的。</font>
      - <font color=red>对于structure-object-class，此过程在最通用的object-class "top"（在第 2.4.1 节中定义）处停止。</font>
      - 一个object-class的superclass-chain，是一个有序的 superclasses/超类 集合，是直到该object-class的most-superior-object-class。
  - An object class may be derived from two or more direct superclasses (superclasses not part of the same superclass chain).  This feature of subclassing is termed multiple inheritance.
      - <font color=red>一个object-class可以派生自两个或多个直接superclasses/超类</font>（超类不是同一超类链的一部分）。
      - 子类的这种特性称为多重继承。

Each object class identifies the set of attributes <font color=red>required to be  present</font> in entries belonging to the class and the set of attributes <font color=red>allowed to be present</font> in entries belonging to the class.  As an entry of a class must meet the requirements of each class it belongs to, it can be said that an object class inherits the sets of allowed and required attributes from its superclasses.  A subclass can identify an attribute allowed by its superclass as being required.  If an   attribute is a member of both sets, it is required to be present.
<font color=red> 每个object-calss标识：在属于该class的entry中 "需要" 存在的属性集合，以及  在属于该class的entry中 "允许" 存在的属性集。 </font>
<font color=red>由于entry必须满足它所属于的每个class的要求，所以可以说一个object-calss继承了它的superclasses的"允许"和"必需"的属性集。 </font>
<font color=red>subclass可以 将其superclasses"允许的"属性  标识为"必需的"。 如果一个属性是两个集合的成员，则它必须存在。</font>

Each object class is defined to be one of three kinds of object classes: Abstract, Structural, or Auxiliary.
每个对象类都定义为以下三种对象类之一：抽象、结构或辅助。
<font color=red> object-class分为三种： abstract/抽象型，structural/结构型，auxiliary/辅助型</font>

Each object class is identified by an object identifier (OID) and, optionally, one or more short names (descriptors).
每个对象类由对象标识符 (OID) 和可选的一个或多个短名称（描述符）标识。
<font color=red> 每个object-class由 OID 或 1个或多个descr  标识</font>





### 2.4.1.  Abstract Object Classes(抽象(型)-对象类)

An abstract object class, as the name implies, provides a base of characteristics from which other object classes can be defined to inherit from.  An entry cannot belong to an abstract object class unless it belongs to a structural or auxiliary class that inherits from that abstract class.
顾名思义，<font color=red>Abstract-Object-Class定义了一些基本的特征，其他Object-Class可以继承这些特征，来实现自身的定义。</font>
<font color=red>entry不能直接从属/继承 Abstract-Object-Classes；</font>；
<font color=red>entry可以从属于 Structural或Auxiliary ，然后Structural或Auxiliary 可以 从属于/继承自 Abstract。</font>

Abstract object classes cannot derive from structural or auxiliary object classes.
<font color=blue>Abstract-object-class 不能直接 从structural-object-classe或auxiliary-object-classe派生。</font>

All structural object classes derive (directly or indirectly) from the 'top' abstract object class.  Auxiliary object classes do not necessarily derive from 'top'.
<font color=red>所有structural-object-classe 直接或间接 派生自 "top"Abstract-object-class</font>
<font color=red>auxiliary-object-classe不需要派生自"top"</font>

The following is the object class definition (see Section 4.1.1) for  the 'top' object class:
<font color=red>"top"Abstract-object-class的定义如下：</font>

```ASN.1
  ( 2.5.6.0 NAME 'top' ABSTRACT MUST objectClass )
```

All entries belong to the 'top' abstract object class.
<font color=red>所有entry都从属于"top"object-class</font>

<font color=red>

### 2.4.2.  Structural Object Classes(结构(型)-对象类)

As stated in [X.501]:
如 [X.501] 所述：

- An object class defined for use in the structural specification of the DIT is termed a structural object class.  Structural object classes are used in the definition of the structure of the names of the objects for compliant entries.
    - <font color=red>为了在 DIT的 结构规范/structural-specification 中使用 而定义的object-class 称为 structural-object-class。</font>
    - <font color=red>structural-object-class 用于  定义    适用于entry的    对象名称的结构/structure。</font>
- An object or alias entry is characterized by precisely one  structural object class superclass chain which has a single structural object class as the most subordinate object class. This structural object class is referred to as the structural object class of the entry.
    - <font color=red>object或alias-entry 的特征在于恰好是一个structural-object-class</font>，
        - <font color=red> superclass-chain具有单个structural-object-class作为最后从属的object-class。</font>，
        - <font color=red>该structural-object-class被称为entry的structural-object-class。</font>
- Structural object classes are related to associated entries: <font color=red>structural-object-class与关联的entry相关</font>：
  - an entry conforming to a structural object class shall represent the real-world object constrained by the object class;
      - <font color=red>符合structural-object-class的entry，应代表/表示了 受object-class约束的现实中的object；</font>
  - DIT structure rules only refer to structural object classes; the structural object class of an entry is used to specify the position of the entry in the DIT;
      - <font color=red>DIT结构规则只涉及structural-object-class； </font>
      - <font color=red>entry的structural-object-class用于指定entry在DIT中的位置；</font>
  - the structural object class of an entry is used, along with an associated DIT content rule, to control the content of an entry.
      - <font color=red>entry  使用structural-object-class  以及关联的 DIT内容规则/content-rule  来控制entry的内容/content。</font>
- The structural object class of an entry shall not be changed.
    - <font color=red>entry的structural-object-class不得更改。</font>

Each structural object class is a (direct or indirect) subclass of  the 'top' abstract object class.
<font color=red>每个structural-object-class都是"top"abstract-object-class(直接或间接)子类。</font>

Structural object classes cannot subclass auxiliary object classes.
<font color=red>structural-object-class不能子类化auxiliary-object-class。</font>

Each entry is said to belong to its structural object class as well as all classes in its structural object class's superclass chain.
<font color=red>每个entry都属于  其structural-object-class   以及  其structural-object-class的superclass-chain中的所有class。</font>



### 2.4.3.  Auxiliary Object Classes(辅助(型)-对象类)

Auxiliary object classes are used to augment the characteristics of entries.  They are commonly used to augment the sets of attributes required and allowed to be present in an entry.  They can be used to describe entries or classes of entries.
<font color=red>auxiliary-object-class用于增加条目的特征。 </font>
它们通常用于增加条目中"所需"和"允许的"属性集合。 
它们可用于描述entry或entry's class。

Auxiliary object classes cannot subclass structural object classes.
辅助对象类 不能子类化 结构对象类。(即：<font color=red>结构对象类 不能作为 辅助对象类的子类</font>)

An entry can belong to any subset of the set of auxiliary object classes allowed by the DIT content rule associated with the structural object class of the entry.  If no DIT content rule is associated with the structural object class of the entry, the entry cannot belong to any auxiliary object class.
entry可以属于  与条目的 结构对象类 相关联的DIT内容规则 所允许的 辅助对象类集合的任何子集。 如果没有 与条目的结构对象类关联的 DIT 内容规则，则该条目不能属于任何辅助对象类。

<font color=red>entry 可以属于   entry的structural-object-class关联的DIR-content-rule 所允许的auxiliary-object-class集合的子集 </font>
<font color=red>当没有与  entry的structural-object-class关联的DIR-content-rule，那么entry不能属于任何auxiliary-object-class</font>



The set of auxiliary object classes that an entry belongs to can change over time.
条目所属的辅助对象类集合可以随时间变化。





## 2.5.  Attribute Descriptions

An attribute description is composed of an attribute type (see Section 2.5.1) and a set of zero or more attribute options (see Section 2.5.2).
<font color=red>attribute-description  由   attribute-type(见第2.5.1节)  和      0个或多个attribute-option/属性选项 的集合(见第2.5.1节)    组成。</font>

An attribute description is represented by the ABNF:
attribute-description由ABNF表示：

```ABNF
  attributedescription = attributetype options
  attributetype = oid
  options = *( SEMI option )
  option = 1*keychar
```

where <attributetype> identifies the attribute type and each <option>   identifies an attribute option.  Both <attributetype> and <option>   productions are case insensitive.  The order in which <option>s appear is irrelevant.  That is, any two <attributedescription>s that consist of the same <attributetype> and same set of <option>s are equivalent.
其中，<font color=red>`<attributetype>` 标识了 attribute-type；每个` <option> `标识了attribute-option；`<attributetype>` 和` <option> `都是不区分大小写的。</font>
<font color=red>`<option>s`中各个option出现的顺序 无关紧要。</font>
<font color=red>也就是说，由相同的`<attributetype>` 和`<option>s` 组成的任意两个`<attributedescription>s`是等价的。</font>

Examples of valid attribute-descriptions:
有效的 attribute-descriptions 的示例：

```ASN.1
  2.5.4.0
  cn;lang-de;lang-en
  owner
```

An attribute description with an unrecognized attribute type is to be treated as unrecognized.  Servers SHALL treat an attribute description with an unrecognized attribute option as unrecognized. Clients MAY treat an unrecognized attribute option as a tagging option (see Section 2.5.2.1).
含有无法识别的attribute-type的attribute-description将被视为无法识别。
服务器`应该`将带有无法识别attribute-option的attribute-description视为无法识别。
客户端可以将无法识别的attribute-option视为 tag-option/标记选项(见第2.5.2.1节)。

<font color=red> 即：attribute-description的 attribute-type或attribute-option只要无法识别 ， attribute-description就被视为无法识别 </font> 

All attributes of an entry must have distinct attribute descriptions.
<font color=red>entry的所有attributes必须有不同的attribute-description。</font>



### 2.5.1.  Attribute Types

An attribute type governs whether the attribute can have multiple values, the syntax and matching rules used to construct and compare values of that attribute, and other functions.
<font color=red>attribute type决定了：attribute是否可以有多个value、用于构造和比较该attribute-value的语法和匹配规则，以及其他功能。</font>



If no equality matching is specified for the attribute type:
<font color=red>如果没有为attribute-type指定相等匹配:</font>

  - the attribute (of the type) cannot be used for naming;
      - <font color=red>attribute-type不能用于命名；</font>
  - when adding the attribute (or replacing all values), no two values may be equivalent (see 2.2);
      - <font color=red>当添加attribute-value或 替换所有attribute-value时，不能有两个value是相等的；</font>
  - individual values of a multi-valued attribute are not to be independently added or deleted;
      - <font color=red>多值属性的单个值不能单独添加或删除;</font>
  - attribute value assertions (such as matching in search filters and comparisons) using values of such a type cannot be performed.
      - 不能使用  type的value(attribute-type的value) 执行 attribute-value-assertion(如搜索过滤器中的匹配和比较)。

Otherwise, the specified equality matching rule is to be used to evaluate attribute value assertions concerning the attribute type. The specified equality rule is to be transitive and commutative.
否则，特定的/指定的 相等匹配规则  用于评估 和attribute-type相关的attribute-value-assertion。
指定的/特定的  相等规则是可传递和可交换的。

The attribute type indicates whether the attribute is a user attribute or an operational attribute.  If operational, the attribute type indicates the operational usage and whether or not the attribute is modifiable by users.  Operational attributes are discussed in Section 3.4.
<font color=red>attribute-type指示：这个attribute是个user-attribute还是一个operational-attribute；</font>
<font color=red>若是operational，则attribute-type指示了operational的用法，以及 这个attribute是否可以被user修改。</font>
Operational将在3.4节讨论。

An attribute type (a subtype) may derive from a more generic attribute type (a direct supertype).  The following restrictions apply to subtyping:
attribute-type(a subtype)可以从更通用的attribute-type(supertype)派生。以下限制 适用于 subtype/子类型：

   - a subtype must have the same usage as its direct supertype,
        - subtype 必须具有与其直接 supertype 相同的用法，
   - a subtype's syntax must be the same, or a refinement of, its supertype's syntax, and
        - subtype 的语法必须(与父类的语法)相同，或者是 父类/supertype 语法的细化，并且
   - a subtype must be collective [RFC3671] if its supertype is collective.
        - 如果supertype是collective/集合，那么subtype必须是collective/集合；

An attribute description consisting of a subtype and no options is said to be the direct description subtype of the attribute description consisting of the subtype's direct supertype and no options.
<font color=blue>(由 一个subtype和0个options 组成的) attribute-description，</font>
<font color=blue>称为  attribute-description(由subtype的直接supertype和0个options组成的)  的direct-subtype-description</font>

Each attribute type is identified by an object identifier (OID) and, optionally, one or more short names (descriptors).
<font color=red>每个attribute-type都由  一个OID和，可选的，1个或多个短名称/desc  来标识。</font>



### 2.5.2.  Attribute Options

There are multiple kinds of attribute description options.  The LDAP technical specification details one kind: tagging options.
<font color=red>有多种attribute-description-options/属性描述选项。LDAP技术规范详细说明了一种:tagging options/标记选项.。</font>

Not all options can be associated with attributes held in the directory.  Tagging options can be.
<font color=red>并非所有options都可以与目录中保存的attribute相关联。tagging options/标记选项可以。</font>

Not all options can be used in conjunction with all attribute types. In such cases, the attribute description is to be treated as unrecognized.
<font color=red>并非所有options可以与所有属性类型/attribute-type一起使用。在这种情况下，属性描/attribute description  述将被视为无法识别。</font>

An attribute description that contains mutually exclusive options shall be treated as unrecognized.  That is, "cn;x-bar;x-foo", where "x-foo" and "x-bar" are mutually exclusive, is to be treated as unrecognized.
<font color=red>包含  相互排斥的  optionss  的attribute-description将被视为不可识别。</font>
b比如，“cn;x-bar;x-foo”，其中“x-foo”和“x-bar”是互斥的，将被视为不可识别。

Other kinds of options may be specified in future documents.  These documents must detail how new kinds of options they define relate to tagging options.  In particular, these documents must detail whether or not new kinds of options can be associated with attributes held in the directory, how new kinds of options affect transfer of attribute values, and how new kinds of options are treated in attribute description hierarchies.
其他种类的options可能在将来的文件中指定。这些文档必须详细说明它们定义的新类型的options如何与tagging options相关。特别是，这些文档必须详细说明新类型的options是否可以与目录中保存的attribute相关联，新类型的options如何影响attribute-value的传递，以及如何在attribute-description层次结构中处理新类型的options。

Options are represented as short, case-insensitive textual strings conforming to the <option> production defined in Section 2.5 of this document.
<font color=red>options表示为一个 短的，不区分大小写的文本字符串</font>，符合本文档的2.5节定义的`<option>`

Procedures for registering options are detailed in BCP 64, RFC 4520 [RFC4520].
<font color=red>注册options的程序，在BCP 64, RFC 4520 [RFC4520]中详细讨论。</font>





#### 2.5.2.1.  Tagging Options

Attributes held in the directory can have attribute descriptions with any number of tagging options.  Tagging options are never mutually exclusive.
<font color=red>保存在目录中的attribute  的attribute-description(可以 含有任意数量的tagging options)。</font>
<font color=red>(因为)tagging options从来不相互排斥。</font>

An attribute description with N tagging options is a direct (description) subtype of all attribute descriptions of the same attribute type and all but one of the N options.  If the attribute type has a supertype, then the attribute description is also a direct (description) subtype of the attribute description of the supertype and the N tagging options.  That is, 'cn;lang-de;lang-en' is a direct (description) subtype of 'cn;lang-de', 'cn;lang-en', and 'name;lang-de;lang-en' ('cn' is a subtype of 'name'; both are defined in [RFC4519]).
<font color=blue>一个attribute-description(含有N个tagging-options)   是所有attribute-description(含有相同的attribute-type 并且N个options除了1个之外都相同)    的direct-(description)-subtype。</font>
<font color=blue>如果attribute-type有supertype，那么attribute-description也是  supertype的attribute-description(含有N个tagging options) 的direct-(description)-subtype。</font>
<font color=blue>例如：</font>
	<font color=blue> 'cn;lang-de;lang-en'   是   'cn;lang-de', 'cn;lang-en'和'name;lang-de;lang-en'的direct-(description)-subtype/直接(描述)子类型</font>
	<font color=blue>('cn'是'name'的子类型/subtype;两者都在[RFC4519]中定义)。</font>



### 2.5.3.  Attribute Description (attribute-description的层次)

An attribute description can be the direct subtype of zero or more other attribute descriptions as indicated by attribute type subtyping (as described in Section 2.5.1) or attribute tagging option subtyping (as described in Section 2.5.2.1).  These subtyping relationships are used to form hierarchies of attribute descriptions and attributes.
<font color=blue>attribute-description可以是  0个或多个其他attribute-description的 direct-subtype/直接子类型，</font>
	<font color=blue>如attribute-type子类型(如2.5.1节所述)或attribute-tagging-option子类型(如2.5.2.1节所述)。</font>
	<font color=blue>(即：使用attribute-type或attribute-options来划分attribute-description的 subtype/子类型)</font>
<font color=green>这些子类型关系用于形成属性描述/attribute-description和属性/attribute的层次结构。</font>

As adapted from [X.501]:

- Attribute hierarchies allow access to the DIB with varying degrees of granularity.  This is achieved by allowing the value components of attributes to be accessed by using either their specific attribute description (a direct reference to the attribute) or a more generic attribute description (an indirect reference).
  - <font color=green>属性层次结构允许以不同程度的粒度访问DIB。</font>
  - <font color=green>这是通过 使用   属性的特定属性描述(对属性的直接引用)  或  更通用的属性描述(间接引用)来  访问属性的值组件  来实现的。</font>
- Semantically related attributes may be placed in a hierarchical relationship, the more specialized being placed subordinate to the more generalized.  Searching for or retrieving attributes and their values is made easier by quoting the more generalized attribute description; a filter item so specified is evaluated for the more specialized descriptions as well as for the quoted description.
  - <font color=green>语义相关的属性可以放在层次关系中，越专门化的属性  从属于 越泛化的属性。</font>
  - <font color=green>通过引用  更通用/泛化的  属性描述，可以更容易地搜索或检索  属性及其值; </font>
    - 这样特定的筛选项将对  更专门化/特定的描述 和 引用描述  进行评估。
- Where subordinate specialized descriptions are selected to be returned as part of a search result these descriptions shall be returned if available.  Where the more general descriptions are selected to be returned as part of a search result both the general and the specialized descriptions shall be returned, if available.  An attribute value shall always be returned as a value of its own attribute description.
  - <font color=green>如果选择了从属的特定描述作为搜索结果的一部分返回，这些描述应返回(如果可用)。</font>
  - <font color=green>如果选择了更泛化/通用的描述作为搜索结果的一部分返回，则应返回泛化的/通用的描述和特定的描述(如果可用)。</font>
  - <font color=green>attribute-value 总是作为 其自身  attribute-description的value  返回。</font>
- All of the attribute descriptions in an attribute hierarchy are treated as distinct and unrelated descriptions for user modification of entry content.
  - 属性层次结构中的所有attribute-description都被视为不同的、不相关的描述，以便用户修改条目内容。
- An attribute value stored in an object or alias entry is of precisely one attribute description.  The description is indicated when the value is originally added to the entry.
  - <font color=green>存储在对象或别名条目中的attribute-value恰好是一个attribute-description。当value最初添加到entry时，该description将被指出。</font>

For the purpose of subschema administration of the entry, a specification that an attribute is required is fulfilled if the entry contains a value of an attribute description belonging to an attribute hierarchy where the attribute type of that description is the same as the required attribute's type.  That is, a "MUST name" specification is fulfilled by 'name' or 'name;x-tag-option', but is not fulfilled by 'CN' or 'CN;x-tag-option' (even though 'CN' is a subtype of 'name').  Likewise, an entry may contain a value of an attribute description belonging to an attribute hierarchy where the attribute type of that description is either explicitly included in the definition of an object class to which the entry belongs or allowed by the DIT content rule applicable to that entry.  That is, 'name' and 'name;x-tag-option' are allowed by "MAY name" (or by "MUST name"), but 'CN' and 'CN;x-tag-option' are not allowed by "MAY name" (or by "MUST name").
出于对entry的subschema管理的目的，
   如果entry包含    attribute-description(属于attribute层次结构) 的value，
   其中/且，该description的attribute-type 与所需attribute的type相同，
   则满足attribute必需的规范。 
<font color=green>也就是说，“MUST name”规范由“name”或“name;x-tag-option”满足，但不由“CN”或“CN;x-tag-option”满足（即使“CN” 是“name”的subype）。 </font>
同样，
	entry可能包含 attribute-description(属于attribute层次结构) 的value，
	其中，该description的attribute-type  要么显示的包含在entry所属的object-class的定义中，要么被适用于该entry的 DIT 内容规则所允许。 
<font color=green>也就是说，'name' 和 'name;x-tag-option' 被“MAY name”（或“MUST name”）允许，但 'CN' 和 'CN;x-tag-option' 不被允许 “MAY name”（或“MUST name”）。</font>

For the purposes of other policy administration, unless stated otherwise in the specification of the particular administrative model, all of the attribute descriptions in an attribute hierarchy are treated as distinct and unrelated descriptions.
出于对其他策略管理的目的，除非在特定管理模型的规范中另有说明，否则属性层次结构中的所有属性描述都被视为不同和不相关的描述。



## 2.6.  Alias Entries

As adapted from [X.501]:

- An alias, or an alias name, for an object is an alternative name for an object or object entry which is provided by the use of alias entries.
  <font color=DeepPink>object的alias或alias-name，  是alias-entry的object或object-entry  的替代名称。</font>
- Each alias entry contains, within the 'aliasedObjectName' attribute (known as the 'aliasedEntryName' attribute in X.500), a name of some object.  The distinguished name of the alias entry is thus also a name for this object.
  <font color=DeepPink>每个alias-entry包含了 'aliasedObjectName'-attribute(X.500中称为'aliasedEntryName'-attribute)，(这个attribute中)包含某个object的name。</font>
  <font color=DeepPink>alias-entry的DN，也是该object的name。</font>
  - NOTE - The name within the 'aliasedObjectName' is said to be pointed to by the alias.  It does not have to be the distinguished name of any entry.
  <font color=blue>说明：在'aliasedObjectName'-attribute中的name 是由alias指向的。它不必是任何entry的DN。</font>
- The conversion of an alias name to an object name is termed (alias) dereferencing and comprises the systematic replacement of alias names, where found within a purported name, by the value of the corresponding 'aliasedObjectName' attribute.  The process may require the examination of more than one alias entry.
  <font color=blue>一个alias-name转换到一个object-name  称为(别名)解引用，并且 系统地替换alias-name</font>，其中  
- Any particular entry in the DIT may have zero or more alias names. It therefore follows that several alias entries may point to the same entry.  An alias entry may point to an entry that is not a leaf entry and may point to another alias entry.
  <font color=DeepPink>DIT中的任何特定entry  可能含有0个或多个alias-name。</font>
  <font color=DeepPink>因此多个alias-entry可能指向同一entry。</font>
  <font color=DeepPink>一个alias-entry  可能指向一个非叶子的entry，并且可能指向另外的alias-entry。</font>
- An alias entry shall have no subordinates, so that an alias entry is always a leaf entry.
  <font color=DeepPink>每个alias-entry不应有从属/子条目，所以  alias-entry总是一个leaf-entry/叶条目。</font>
- Every alias entry shall belong to the 'alias' object class.
<font color=DeepPink>每一个alias-entry，必须属于/具有 'alias' object class。</font>

An entry with the 'alias' object class must also belong to an object  class (or classes), or be governed by a DIT content rule, which allows suitable naming attributes to be present.
<font color=DeepPink>一个具有'alias' object class的entry，还必须属于1个或多个object class，或者受DIT内容规则的管理，以允许出现合适的 命名attribute</font>

Example:

```ASN.1
  dn: cn=bar,dc=example,dc=com
  objectClass: top
  objectClass: alias				--此entry，含有 alias object class
  objectClass: extensibleObject

  cn: bar
  aliasedObjectName: cn=foo,dc=example,dc=com
```



### 2.6.1.  'alias' Object Class

Alias entries belong to the 'alias' object class.

```ASN.1
  ( 2.5.6.1 NAME 'alias'      	-- 名字是alias
    SUP top STRUCTURAL			-- 从属于 top 和 structural 
    MUST aliasedObjectName )	-- 必须包含 aliasedObjectName
```



### 2.6.2.  'aliasedObjectName' Attribute Type

The 'aliasedObjectName' attribute holds the name of the entry an alias points to.  The 'aliasedObjectName' attribute is known as the 'aliasedEntryName' attribute in X.500.
<font color=DarkRed>'aliasedObjectName'-attribute包含了 本alias-entry  指向的entry的name。</font>
aliasedObjectName' 在X.500中称为'aliasedEntryName'。

```ASN.1
  ( 2.5.4.1 NAME 'aliasedObjectName'
    EQUALITY distinguishedNameMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.12
    SINGLE-VALUE )
```

The 'distinguishedNameMatch' matching rule and the DistinguishedName (1.3.6.1.4.1.1466.115.121.1.12) syntax are defined in [RFC4517].
'distinguishedNameMatch'的   匹配规则和DN(1.3.6.1.4.1.1466.115.121.1.12)的语法，被定义在[RFC4517]。



# 3. Directory Administrative and Operational Information(目录管理和操作信息)

This section discusses select aspects of the X.500 Directory Administrative and Operational Information model [X.501].  LDAP implementations MAY support other aspects of this model.

本节讨论X.500  目录管理和操作信息模型[X.501]的某些方面。LDAP实现 可能支持这个模型的其他方面。

## 3.1.  Subtrees

As defined in [X.501]:
- A subtree is a collection of object and alias entries situated at the vertices of a tree.  Subtrees do not contain subentries.  The prefix sub, in subtree, emphasizes that the base (or root) vertex of this tree is usually subordinate to the root of the DIT.
<font color=red>subtree位于tree的顶点上，它是一个 object和alias-entry的 集合。</font>
<font color=red>subtree不包含subentry。</font>
subtree中的前缀sub，强调这棵树的 base/root顶点 通常 从属于DIT的root。
- A subtree begins at some vertex and extends to some identifiable lower boundary, possibly extending to leaves.  A subtree is always defined within a context which implicitly bounds the subtree.  For example, the vertex and lower boundaries of a subtree defining a replicated area are bounded by a naming context.
subtree/子树从某个顶点开始并延伸到某个可识别的下边界，可能延伸到叶子。 
子树总是在  隐式限定子树的上下文 中定义。 例如，定义复制区域的子树的顶点和下边界受命名上下文的限制。



## 3.2.  Subentries

A subentry is a "special sort of entry, known by the Directory, used  to hold information associated with a subtree or subtree refinement"  [X.501]. Subentries are used in Directory to hold for administrative  and operational purposes as defined in [X.501].  Their use in LDAP is  detailed in [RFC3672].
<font color=red>subentry是 ”目录中已知的，特定/特殊顺序的entry，用于保存  与subtree或subtree细化相关的信息“[X.501]。</font>
<font color=red>subentry在目录中 用于保存  [X.501]中定义的管理和操作目的。</font>
在LDAP中使用它们，在[RFC372]中有详细说明。

The term "(sub)entry" in this specification indicates that servers  implementing X.500(93) models are, in accordance with X.500(93) as described in [RFC3672], to use a subentry and that other servers are  to use an object entry belonging to the appropriate auxiliary class  normally used with the subentry (e.g., 'subschema' for subschema  subentries) to mimic the subentry.  This object entry's RDN SHALL be  formed from a value of the 'cn' (commonName) attribute [RFC4519] (as  all subentries are named with 'cn').
本规范中的术语"(sub)entry" 指示实现 X.500(93) 模型的server，按照 [RFC3672] 中描述的 X.500(93)，   使用subentry，
	其他server  subentry通常与  属于适当auxiliary-class的object-entry  一起使用  （例如，subschema subentry的“subschema”）来模仿subentry。
该对象条目的RDN / object entry's RDN     应由“cn”（commonName）属性 [RFC4519] 的值构成（因为<font color=red>所有subentry都以“cn”命名</font>）。



## 3.3.  The 'objectClass' attribute(objectClass-attribute)

Each entry in the DIT has an 'objectClass' attribute.
<font color=blue>DIT中的每个entry 都有一个'objectClass'-attribute。</font>

```ASN.1
  ( 2.5.4.0 NAME 'objectClass'					--OID是2.5.4.0  name是objectClass
    EQUALITY objectIdentifierMatch				--对OID执行EQUALITY匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.38 )		--语法的ID号
```

The 'objectIdentifierMatch' matching rule and the OBJECT IDENTIFIER  (1.3.6.1.4.1.1466.115.121.1.38) syntax are defined in [RFC4517].
'objectIdentifierMatch' match-rule 和 OID (1.3.6.1.4.1.1466.115.121.1.38) 语法在 [RFC4517] 中定义。

The 'objectClass' attribute specifies the object classes of an entry,  which (among other things) are used in conjunction with the  controlling schema to determine the permitted attributes of an entry.  Values of this attribute can be modified by clients, but the  'objectClass' attribute cannot be removed.
<font color=blue>'objectClass'-attribute 指定entry的object-class，这些object-class与control-schmea结合使用 以确定entry允许的属性。 </font>
<font color=blue>client可以修改此'objectClass'-attribute的value，但不能删除'objectClass'-attribute。</font>

Servers that follow X.500(93) models SHALL restrict modifications of  this attribute to prevent the basic structural class of the entry  from being changed.  That is, one cannot change a 'person' into a  'country'.
<font color=blue>遵循X.500(93)-models的server  应限制对该'objectClass'-attribute的修改，以防止entry的basic-structural-class被更改。 </font>
<font color=blue>比如：不能把一个'person/个人'变成一个'country/国家'。</font>

When creating an entry or adding an 'objectClass' value to an entry,  all superclasses of the named classes SHALL be implicitly added as  well if not already present.  That is, if the auxiliary class 'x-a'  is a subclass of the class 'x-b', adding 'x-a' to 'objectClass'  causes 'x-b' to be implicitly added (if is not already present).  
<font color=blue>在创建entry或向entry添加'objectClass'-value时，如果尚未存在，则还应隐式添加class的所有superclass。</font>
​	<font color=blue>也就是说，如果  辅助类“x-a”  是  类“x-b”  的子类，则将“x-a”添加到“objectClass”会导致隐式添加“x-b”(如果尚未存在)。</font> 

Servers SHALL restrict modifications of this attribute to prevent  superclasses of remaining 'objectClass' values from being deleted.  That is, if the auxiliary class 'x-a' is a subclass of the auxiliary class 'x-b' and the 'objectClass' attribute contains 'x-a' and 'x-b',  an attempt to delete only 'x-b' from the 'objectClass' attribute is  an error.
<font color=blue>server应限制对该'objectClass'-attribute的修改，以防止删除 保存了'objectClass'-value  的superclass。 </font>
<font color=blue>也就是说，如果   辅助类“xa”  是  辅助类“xb”   的子类，并且'objectClass'-attribute包含“x-a”和“x-b”，则尝试从'objectClass'-attribute中仅删除“x-b” 是一个错误。 </font>



## 3.4.  Operational Attributes(operational-attribute)

Some attributes, termed operational attributes, are used or maintained by servers for administrative and operational purposes. As stated in [X.501]: "There are three varieties of operational attributes:  Directory operational attributes, DSA-shared operational attributes, and DSA-specific operational attributes".
<font color=red>某些称为operational-attribute/操作属性的attribute，由server出于**管理和操作**的目的  使用或维护。 </font>
<font color=red>如 [X.501] 所述：“operational-attribute/操作属性分为三种：目录操作属性、DSA -shared操作属性和 DSA-specific操作属性”</font>

A directory operational attribute is used to represent operational and/or administrative information in the Directory Information Model. This includes operational attributes maintained by the server (e.g., 'createTimestamp') as well as operational attributes that hold values administrated by the user (e.g., 'ditContentRules').
<font color=green>1 - 目录操作属性/directory-operational-attribute  -->>  用于表示：目录信息模型中的  操作和/或管理  信息。 </font>
<font color=green>这包括：由服务器维护的操作属性(例如 'createTimestamp') 以及  由用户管理的保存值的操作属性(例如 'ditContentRules')。</font>

A DSA-shared operational attribute is used to represent information of the DSA Information Model that is shared between DSAs.
<font color=green>2 - DSA共享的操作属性/DSA-shared operational attribute  -->>  用于表示：DSA之间共享的 DSA信息模型。</font>

A DSA-specific operational attribute is used to represent information of the DSA Information Model that is specific to the DSA (though, in some cases, may be derived from information shared between DSAs; e.g., 'namingContexts').
<font color=green>3 - 特定于DSA的操作属性/DSA-specific operational attribute  -->>  用于表示：  特定于DSA的 DSA信息模型的信息(尽管，在某些情况下，派生自 DSA之间共享的信息，例如 'namingContexts')</font>

The DSA Information Model operational attributes are detailed in [X.501].
<font color=red>DSA信息模型操作属性 /DSA Information Model operational attribute    -->   在[X.501]中有详细说明。</font>

Operational attributes are not normally visible.  They are not returned in search results unless explicitly requested by name. Not all operational attributes are user modifiable.
<font color=red>操作属性 通常不可见。除非明确使用name请求，否则它们不会在serarch-result中返回。</font>
<font color=red>并非所有操作属性 都是用户可修改的。</font>

Entries may contain, among others, the following operational attributes:      entry可能包含以下操作属性

  - creatorsName: the Distinguished Name of the user who added this entry to the directory,
    将此entry添加到目录的  用户的DN，(即 创建者的DN)
    
  - createTimestamp: the time this entry was added to the directory,
    该entry被添加到目录的 时间，           (即 添加时的时间)

  - modifiersName: the Distinguished Name of the user who last modified this entry, and
    最后修改此entry的  用户的DN            (即 最后修改时的 修改者的DN)
    
  - modifyTimestamp: the time this entry was last modified.
    此entry  最后被修改的时间                 (即 最后修改时的时间)

Servers SHOULD maintain the 'creatorsName', 'createTimestamp', 'modifiersName', and 'modifyTimestamp' attributes for all entries of the DIT.
<font color=green>server"应该"为DIT中的所有entry 维护 'creatorsName', 'createTimestamp', 'modifiersName', and 'modifyTimestamp' attributes</font>


### 3.4.1.  'creatorsName'

This attribute appears in entries that were added using the protocol (e.g., using the Add operation).  The value is the distinguished name of the creator.
<font color=red>该attribute出现在 使用协议添加  的entry中(例如 使用 add-operation)。</font>
<font color=red>value是 创建者的DN。</font>

```ABNF
  ( 2.5.18.3 NAME 'creatorsName'             -- 此attribute/属性   的 name= 'creatorsName'               
    EQUALITY distinguishedNameMatch          -- 此attribute/属性   的 匹配规则 是 distinguishedNameMatch --匹配规则 对DN进行匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.12     -- 此attribute/属性   的语法的OID 是                        --语法
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是单值的                              --单值
    USAGE directoryOperation )               -- 此attribute/属性   的使用
```

The 'distinguishedNameMatch' matching rule and the DistinguishedName (1.3.6.1.4.1.1466.115.121.1.12) syntax are defined in [RFC4517].
匹配规则-'distinguishedNameMatch' 和 语法-DistinguishedName ，被定义在[RFC4517]。



### 3.4.2.  'createTimestamp'

This attribute appears in entries that were added using the protocol (e.g., using the Add operation).  The value is the time the entry was added.
<font color=red>该attribute出现在 使用协议添加  的entry中(例如 使用 add-operation)。</font>
<font color=red>value是entry被添加的时间。</font>

```ABNF
  ( 2.5.18.1 NAME 'createTimestamp'          -- 此attribute/属性   的  name
    EQUALITY generalizedTimeMatch            -- 此attribute/属性   的  匹配规则  对产生时间进行匹配
    ORDERING generalizedTimeOrderingMatch    -- 此attribute/属性   的  匹配规则  对产生时间的顺序进行匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.24     -- 此attribute/属性   的  语法
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是  单值的
    USAGE directoryOperation )               -- 此attribute/属性   的  用法
```

The 'generalizedTimeMatch' and 'generalizedTimeOrderingMatch' matching rules and the GeneralizedTime  (1.3.6.1.4.1.1466.115.121.1.24) syntax are defined in [RFC4517].
匹配规则-'generalizedTimeMatch' 和 'generalizedTimeOrderingMatch'，以及 语法-GeneralizedTime(1.3.6.1.4.1.1466.115.121.1.24)，被定义在[RFC4517]中。 

### 3.4.3.  'modifiersName'

This attribute appears in entries that have been modified using the protocol (e.g., using the Modify operation).  The value is the distinguished name of the last modifier.
<font color=red>该attribute出现在  使用协议修改的 entry中(例如 使用Modify-operation)。</font>
<font color=red>value是 最后修改者的DN。</font>

```ABNF
  ( 2.5.18.4 NAME 'modifiersName'            -- 此attribute/属性   的  name
    EQUALITY distinguishedNameMatch          -- 此attribute/属性   的  匹配规则  对DN使用相等匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.12     -- 此attribute/属性   的  语法
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是  单值
    USAGE directoryOperation )               -- 此attribute/属性   的  使用
```

The 'distinguishedNameMatch' matching rule and the DistinguishedName  (1.3.6.1.4.1.1466.115.121.1.12) syntax are defined in [RFC4517].
匹配规则-'distinguishedNameMatch'  和  语法-DistinguishedName(1.3.6.1.4.1.1466.115.121.1.12) 被定义在[RFC4517]中。



### 3.4.4.  'modifyTimestamp'

This attribute appears in entries that have been modified using the  protocol (e.g., using the Modify operation).  The value is the time  the entry was last modified.
<font color=red>该attribute出现在  使用协议修改的 entry中(例如 使用Modify-operation)。</font>
<font color=red>value是 该entry最后被修改的时间</font>

```ABNF
  ( 2.5.18.2 NAME 'modifyTimestamp'          -- 此attribute/属性   的  name
    EQUALITY generalizedTimeMatch            -- 此attribute/属性   的  匹配规则 对产生时间进行匹配
    ORDERING generalizedTimeOrderingMatch    -- 此attribute/属性   的  匹配规则 对产生时间的顺序进行匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.24     -- 此attribute/属性   的  语法
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是  单值
    USAGE directoryOperation )               -- 此attribute/属性   的  使用
```

The 'generalizedTimeMatch' and 'generalizedTimeOrderingMatch'  matching rules and the GeneralizedTime  (1.3.6.1.4.1.1466.115.121.1.24) syntax are defined in [RFC4517].
匹配规则-'generalizedTimeMatch' and 'generalizedTimeOrderingMatch'，语法-GeneralizedTime(1.3.6.1.4.1.1466.115.121.1.24)，被定义在[RFC4517]中。



### 3.4.5.  'structuralObjectClass'

This attribute indicates the structural object class of the entry.
<font color=red>该attribute指示entry的structural-object-class。</font>

```ABNF
  ( 2.5.21.9 NAME 'structuralObjectClass'    -- 此attribute/属性   的  name
    EQUALITY objectIdentifierMatch           -- 此attribute/属性   的  匹配规则  IOD进行匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.38     -- 此attribute/属性   的  语法 
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是  单值
    USAGE directoryOperation )               -- 此attribute/属性   的  使用
```

The 'objectIdentifierMatch' matching rule and OBJECT IDENTIFIER  (1.3.6.1.4.1.1466.115.121.1.38) syntax is defined in [RFC4517].
匹配规则-'objectIdentifierMatch' 和 语法-OID(1.3.6.1.4.1.1466.115.121.1.38)，被定义在[RFC4517]中。



### 3.4.6.  'governingStructureRule'

This attribute indicates the structure rule governing the entry.
<font color=red>该attribute指示 管理entry的structure-rule/结构规则。</font>

```ABNF
  ( 2.5.21.10 NAME 'governingStructureRule'  -- 此attribute/属性   的  name
    EQUALITY integerMatch                    -- 此attribute/属性   的  匹配规则  对integer进行匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.27     -- 此attribute/属性   的  语法
    SINGLE-VALUE NO-USER-MODIFICATION        -- 此attribute/属性   是  单值
    USAGE directoryOperation )               -- 此attribute/属性   的  使用
```

The 'integerMatch' matching rule and INTEGER (1.3.6.1.4.1.1466.115.121.1.27) syntax is defined in [RFC4517].
匹配规则-'integerMatch'和 语法-INTEGER(1.3.6.1.4.1.1466.115.121.1.27)，被定义在[RFC4517]中。



# 4. Directory Schema(目录的schema)

As defined in [X.501]: 如[X.501]所定义：

- The Directory Schema is a set of definitions and constraints concerning the structure of the DIT, the possible ways entries are named, the information that can be held in an entry, the attributes used to represent that information and their organization into hierarchies to facilitate search and retrieval of the information and the ways in which values of attributes may be matched in attribute value and matching rule assertions.
  <font color=blue>目录模式/directory-schema  是一组定义和约束，涉及DIT的结构/structure、entry命名/name的可能方式、entry中可以包含的信息/information、为了便于搜索和检索信息 在层次结构中用于表示信息和组织的attribute  以及在attribute-value和match-rule-assertion中匹配attribute's value的方式。</font>
  
- NOTE 1 - The schema enables the Directory system to, for example:
说明1-scheam使目录系统可以/能够，如：

  - prevent the creation of subordinate entries of the wrong object-class (e.g., a country as a subordinate of a person);
    <font color=red>阻止，为错误的object-class创建从属entry</font>(例如，一个conuntry/国家 作为一个人/person 的从属条目/entry)；
    
  - prevent the addition of attribute-types to an entry inappropriate to the object-class (e.g., a serial number to a person's entry);
    <font color=red>阻止，为不合适的object-class的entry 添加attribute-type</font>(例如，向一个person-entry 添加 一个serial-number)
    
  - prevent the addition of an attribute value of a syntax not matching that defined for the attribute-type (e.g., a printable string to a bit string).
  <font color=red>阻止，添加的attribute-value  不匹配/不符合 定义attribute-type的语法</font>(例如，一个可打印的字符串 添加到 一个子节字符串)

- Formally, the Directory Schema comprises a set of:
  形式上，目录模式/directory-schema 包含一组:
  - a) Name Form definitions that define primitive naming relations for structural object classes;
  <font color=blue>Name-Form-definitions/命名形式定义，定义structural-object-class的   原始命名关系</font>
  
  - b) DIT Structure Rule definitions that define the names that entries may have and the ways in which the entries may be related to one another in the DIT;
  <font color=blue>DIT-structure-rule-definition/DIT结构规则定义，定义了DIT中 entry可能具有的name   以及 entry之间相互关联的方式。</font>
  
  - c) DIT Content Rule definitions that extend the specification of allowable attributes for entries beyond those indicated by the structural object classes of the entries;
  <font color=blue>DIT-Content-Rule-definitions/DIT内容规则定义，扩展了 entry所允许attribute 的规范/specification，超出了entry的structural-object-class所指示的attribute；</font>
  
  - d) Object Class definitions that define the basic set of mandatory and optional attributes that shall be present, and may be present, respectively, in an entry of a given class, and which indicate the kind of object class that is being defined;
  <font color=blue>Object-Class-definitions/对象类定义，定义了 应该出现和可能出现的 强制属性和可选属性的  基本集合，并指示正在定义的object-class的类型。</font>
  
  - e) Attribute Type definitions that identify the object identifier by which an attribute is known, its syntax, associated matching rules, whether it is an operational attribute and if so its type, whether it is a collective attribute, whether it is permitted to have multiple values and whether or not it is derived from another attribute type;
  <font color=blue>Attribute Type definitions/属性类型定义，标识了  已知attribute的OID，它的语法/syntax，相关的匹配规则/match-rule，它是否是一个操作属性/operational-attribute，它是否是一个属性集合/collective-attribute，是否允许多个值/value  以及 它是否派生自 另一个 attribute-type。</font>
  - f) Matching Rule definitions that define matching rules. And in LDAP:
  <font color=blue>Matching Rule definitions/批评规则定义，定义了匹配规则；</font>

  - g) LDAP Syntax definitions that define encodings used in LDAP.
  <font color=red>LDAP-syntax-definitions/LDAP语法定义，定义了LDAP使用的编码。</font>



## 4.1.  Schema Definitions(schema的定义)

Schema definitions in this section are described using ABNF and rely on the common productions specified in Section 1.2 as well as these:
<font color=red>本节中的schema定义 使用ABNF描述</font>，并依赖 1.2节(注意：其实是本文档的1.4节)中指定的 常见的产生方式  以及这些：

```ABNF
  noidlen = numericoid [ LCURLY len RCURLY ]                      -- LCURLY="{" RCURLY="}"
  len = number

  oids = oid / ( LPAREN WSP oidlist WSP RPAREN )
  oidlist = oid *( WSP DOLLAR WSP oid )                           -- DOLLAR="$"

  extensions = *( SP xstring SP qdstrings )
  xstring = "X" HYPHEN 1*( ALPHA / HYPHEN / USCORE )              -- HYPHEN="-"   USCORE="_"

  qdescrs = qdescr / ( LPAREN WSP qdescrlist WSP RPAREN )         -- LPAREN="("  WSP=0个或多个" " RPAREN=")"
  qdescrlist = [ qdescr *( SP qdescr ) ]
  qdescr = SQUOTE descr SQUOTE                                    -- 'descr'

  qdstrings = qdstring / ( LPAREN WSP qdstringlist WSP RPAREN )
  qdstringlist = [ qdstring *( SP qdstring ) ]                    -- SP=1个或多个" " 
  qdstring = SQUOTE dstring SQUOTE                                -- 'dstring'
  dstring = 1*( QS / QQ / QUTF8 )   ; escaped UTF-8 string        -- 转义的UTF-8字符串

  QQ =  ESC %x32 %x37 ; "\27"                                     -- ESC是在1.4节定义的,是"\"    即 "\" "2" "7" --> "\27"
  QS =  ESC %x35 ( %x43 / %x63 ) ; "\5C" / "\5c"			         -- "\" "5" ("C" / "c")       --> "\5C" /"\5c"-->"\\"

  ; Any UTF-8 encoded Unicode character                           -- UTF-8编码的Unicode字符
  ; except %x27 ("\'") and %x5C ("\")                             -- 除了 '  和  \
  QUTF8    = QUTF1 / UTFMB

  ; Any ASCII character except %x27 ("\'") and %x5C ("\")         -- 任何ASCII字符 ，除了  ' 和 \
  QUTF1    = %x00-26 / %x28-5B / %x5D-7F
```

Schema definitions in this section also share a number of common terms.
本节中的schema定义，也共享许多通用术语。

The NAME field provides a set of short names (descriptors) that are to be used as aliases for the OID.
NAME字段 提供了：一组用作 OID别名的短名称(描述符)。

The DESC field optionally allows a descriptive string to be provided by the directory administrator and/or implementor.  While specifications may suggest a descriptive string, there is no requirement that the suggested (or any) descriptive string be used.
DESC字段可选地允许 目录管理员和/或实现者 提供描述性字符串。 虽然规范可能会建议一个描述性字符串，但并不要求使用建议的(或任何)描述性字符串。

The OBSOLETE field, if present, indicates the element is not active.
OBSOLETE 字段(如果存在)：表示该元素未处于活动状态。

Implementors should note that future versions of this document may expand these definitions to include additional terms.  Terms whose identifier begins with "X-" are reserved for private experiments and are followed by `<SP>` and `<qdstrings>` tokens.
实施者应注意，本文档的未来版本可能会扩展这些定义以包括附加术语。 
标识符以“X-”开头的术语保留用于私人实验，后跟 `<SP> `和 `<qdstrings>` 标记。



#### 4.1.1.  Object Class Definitions(object-class的ABNF定义定义)

Object Class definitions are written according to the ABNF:
<font color=red>object-class的定义 是根据ABNF编写的：</font>

```ABNF
 ObjectClassDescription = LPAREN WSP
     numericoid                 ; object identifier			-- OID
     [ SP "NAME" SP qdescrs ]   ; short names (descriptors)	-- 1个或多个短名称(OID的别名)
     [ SP "DESC" SP qdstring ]  ; description               -- 描述性字符串，是个UTF-8编码的字符串
     [ SP "OBSOLETE" ]          ; not active                -- 表示：未激活
     [ SP "SUP" SP oids ]       ; superior object classes   -- 指定该object-class的直接 superclass
     [ SP kind ]                ; kind of class             -- ABSTRACT或STRUCTURAL或AUXILIARY，默认是structural
     [ SP "MUST" SP oids ]      ; attribute types           -- 必需包含的 attribute-type集合
     [ SP "MAY" SP oids ]       ; attribute types           -- 可以包含的 attribute-type集合
     extensions WSP RPAREN

 kind = "ABSTRACT" / "STRUCTURAL" / "AUXILIARY"
```

where: 
其中：

   `<numericoid>` is object identifier assigned to this object class; 
   `<numericoid>` 是分配给这个object-class的 对象标识符/OID；

   NAME `<qdescrs>` are short names (descriptors) identifying this object class;
   NAME `<qdescrs>` 是标识这个object-class的短名称（描述符）；     

​	 DESC` <qdstring>` is a short descriptive string;
​	 DESC` <qdstring>` 是一个简短的描述性字符串；

   OBSOLETE indicates this object class is not active;
​	 OBSOLETE 表示该object-class未激活；

   SUP `<oids>` specifies the direct superclasses of this object class;
   SUP `<oids>` 指定了这个object-class的直接超类/superclasses；

   the kind of object class is indicated by one of ABSTRACT, STRUCTURAL, or AUXILIARY (the default is STRUCTURAL);
   object-class的种类：由ABSTRACT/abstract、STRUCTURAL/structural 或 AUXILIARY/auxiliary 之一指示（默认为 STRUCTURAL/structural）；

   MUST and MAY specify the sets of required and allowed attribute types, respectively; and 
   MUST和MAY分别指定必需和允许的属性类型集； 和

   `<extensions>` describe extensions.
   `<extensions>`描述扩展。



#### 4.1.2.  Attribute Types(attribute-type的定义)

Attribute Type definitions are written according to the ABNF:
<font color=red>attribute-type的定义 是根据ABNF编写的：</font>

```ABNF
     AttributeTypeDescription = LPAREN WSP
         numericoid                    ; object identifier        -- OID
         [ SP "NAME" SP qdescrs ]      ; short names (descriptors)-- 短名称
         [ SP "DESC" SP qdstring ]     ; description              --描述性字符串
         [ SP "OBSOLETE" ]             ; not active               --表示：未激活
         [ SP "SUP" SP oid ]           ; supertype                --指定它的直接supertype
         [ SP "EQUALITY" SP oid ]      ; equality matching rule
         [ SP "ORDERING" SP oid ]      ; ordering matching rule
         [ SP "SUBSTR" SP oid ]        ; substrings matching rule
         [ SP "SYNTAX" SP noidlen ]    ; value syntax             -- oid标识的 值语法
         [ SP "SINGLE-VALUE" ]         ; single-value             -- 单值
         [ SP "COLLECTIVE" ]           ; collective               -- 集合
         [ SP "NO-USER-MODIFICATION" ] ; not user modifiable      -- 用户不可修改
         [ SP "USAGE" SP usage ]       ; usage                    -- 用法  
         extensions WSP RPAREN         ; extensions               --扩展
    
     usage = "userApplications"     /  ; user
             "directoryOperation"   /  ; directory operational
             "distributedOperation" /  ; DSA-shared operational
             "dSAOperation"            ; DSA-specific operational
```
where:
其中
   <numericoid> is object identifier assigned to this attribute type;
   <numericoid> 是分配给该attribute-type的 对象标识符/OID；

   NAME <qdescrs> are short names (descriptors) identifying this attribute type;
   NAME <qdescrs> 是标识此attribute-type的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this attribute type is not active;
   OBSOLETE 表示该attribute-type未激活；

   SUP oid specifies the direct supertype of this type;
   SUP oid 指定该attribute-type的 直接 超类型/supertype；

   EQUALITY, ORDERING, and SUBSTR provide the oid of the equality, ordering, and substrings matching rules, respectively;
   EQUALITY、ORDERING、SUBSTR分别提供了：oid的 相等、排序、子串  匹配规则；

   SYNTAX identifies value syntax by object identifier and may suggest a minimum upper bound;
   SYNTAX通过OID识别值语法，并可能建议一个最小上限；

   SINGLE-VALUE indicates attributes of this type are restricted to a single value;
   SINGLE-VALUE 表示该attribute-type的attribute仅限于单个值/value；

   COLLECTIVE indicates this attribute type is collective [X.501][RFC3671];
   COLLECTIVE 表示该attribute-type是集体/集合 [X.501][RFC3671]；

   NO-USER-MODIFICATION indicates this attribute type is not user modifiable;
   NO-USER-MODIFICATION 表示该attribute-type是用户/user不可修改的；

   USAGE indicates the application of this attribute type; and
   USAGE 表示该属性类型的应用； 和

   <extensions> describe extensions.
   <extensions> 描述扩展。

Each attribute type description must contain at least one of the SUP or SYNTAX fields.  If no SYNTAX field is provided, the attribute type description takes its value from the supertype.
<font color=red>每个attribute-type-description必须至少包含 SUP字段 或 SYNTAX 字段之一。 </font>
<font color=red>如果未提供 SYNTAX 字段，则attribute-type-description从supertype中获取其值/value。</font>

If SUP field is provided, the EQUALITY, ORDERING, and SUBSTRING fields, if not specified, take their value from the supertype.
<font color=red>如果提供了 SUP 字段，则EQUALITY、ORDERING 和 SUBSTRING 字段(如果未指定)  从supertype中获取它们的值/value。</font>



Usage of userApplications, the default, indicates that attributes of this type represent user information.  That is, they are user attributes.
<font color=red>usage = userApplications时，默认值，指示该type的attribute：代表用户信息。 也就是说，它们是用户属性/user-attribute。</font>

A usage of directoryOperation, distributedOperation, or dSAOperation indicates that attributes of this type represent operational and/or administrative information.  That is, they are operational attributes.
<font color=red>当usage是directoryOperation、distributedOperation 或 dSAOperation时，指示这种type的attribute：代表操作和/或管理信息。 也就是说，它们是操作属性。</font>

directoryOperation usage indicates that the attribute of this type is a directory operational attribute.  distributedOperation usage indicates that the attribute of this type is a DSA-shared usage operational attribute.  dSAOperation usage indicates that the attribute of this type is a DSA-specific operational attribute.
<font color=red>usage = directoryOperation时，指示该type的attribute：为目录操作属性。 </font>
<font color=red>usage = distributedOperation时，指示该type的attribute：是DSA-共享用法操作属性。</font> 
<font color=red>usage = dSAOperation时，表明该type的attribute：是DSA-特定的操作属性。</font>



COLLECTIVE requires usage userApplications.  Use of collective attribute types in LDAP is discussed in [RFC3671].
<font color=red>COLLECTIVE需要usage=userApplications。 [RFC3671] 中讨论了LDAP中 集合属性类型 的使用。</font>

NO-USER-MODIFICATION requires an operational usage.
<font color=red>NO-USER-MODIFICATION 需要 usage = XXXOperation。</font>



Note that the `<AttributeTypeDescription> `does not list the matching rules that can be used with that attribute type in an extensibleMatch search filter [RFC4511].  This is done using the 'matchingRuleUse' attribute described in Section 4.1.4.
请注意，`<AttributeTypeDescription> `未列出  可在extensibleMatch搜索过滤器[RFC4511]中  与该attribute-type一起使用的匹配规则。 
这是使用第4.1.4节中描述的'matchingRuleUse'-attribute完成的。

This document refines the schema description of X.501 by requiring that the SYNTAX field in an <AttributeTypeDescription> be a string representation of an object identifier for the LDAP string syntax definition, with an optional indication of the suggested minimum bound of a value of this attribute.
本文档通过要求  `<AttributeTypeDescription>`中的SYNTAX字段  是LDAP字符串语法定义的OID  的字符串表示  来改进/细化 X.501的schema描述，并可选指示此此attribute-value的建议最小界限。

A suggested minimum upper bound on the number of characters in a value with a string-based syntax, or the number of bytes in a value for all other syntaxes, may be indicated by appending this bound count inside of curly braces following the syntax's OBJECT IDENTIFIER in an Attribute Type Description.  This bound is not part of the syntax name itself.  For instance, "1.3.6.4.1.1466.0{64}" suggests that server implementations should allow a string to be 64 characters long, although they may allow longer strings.  Note that a single character of the Directory String syntax may be encoded in more than one octet since UTF-8 [RFC3629] is a variable-length encoding.
当value 是基于  a string-based syntax 时，我们可以 建议value(是字符组成的字符串)的字符数的最小上限，或者 当value基于其他语法 也可以...
<font color=red>可以在attribute-type-description的syntax's OID  后面的大括号内  追加此边界数  (来限制value的字符个数)。</font>
这个界限不是 syntax-name/语法名称 本身的一部分。 
例如，"1.3.6.4.1.1466.0{64}"建议server实现应该  允许一个字符串长度为 64 个字符，尽管它们可能允许更长的字符串。 
请注意，由于UTF-8[RFC3629]是一种可变长度编码，因此  目录字符串语法  的单个字符可能会被编码为多个八位字节。



#### 4.1.3. Matching Rules(match-rule的定义)

Matching rules are used in performance of attribute value assertions, such as in performance of a Compare operation.  They are also used in evaluating search filters, determining which individual values are to be added or deleted during performance of a Modify operation, and in comparing distinguished names.
<font color=red>matching-rule  用于执行   attribute-value-assertion，例如执行compare-operation。 </font>
<font color=red>它们还用于评估search-filter、确定在执行修改操作期间要添加或删除哪些单独的值/value，以及比较 可分辨名称/DN。</font>

Each matching rule is identified by an object identifier (OID) and, optionally, one or more short names (descriptors).
<font color=red>每个matching-rule由对象标识符 (OID) 和可选的一个或多个短名称（描述符）标识。</font>

Matching rule definitions are written according to the ABNF:
<font color=red>matching-rule定义 根据ABNF编写：</font>

```ABNF
 MatchingRuleDescription = LPAREN WSP
     numericoid                 ; object identifier         -- OID
     [ SP "NAME" SP qdescrs ]   ; short names (descriptors) -- 短名称
     [ SP "DESC" SP qdstring ]  ; description               -- 描述字符串
     [ SP "OBSOLETE" ]          ; not active                -- 未激活
     SP "SYNTAX" SP numericoid  ; assertion syntax          -- 语法
     extensions WSP RPAREN      ; extensions                -- 扩展
```

where:
   <numericoid> is object identifier assigned to this matching rule;
   <numericoid> 是分配给该match-rule/匹配规则的对象标识符/OID；

   NAME <qdescrs> are short names (descriptors) identifying this matching rule;
   NAME <qdescrs> 是标识此matching-rule的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this matching rule is not active;
   OBSOLETE 表示matching-rule未激活；

   SYNTAX identifies the assertion syntax (the syntax of the assertion value) by object identifier; and
   SYNTAX 通过 OID 标识 断言语法/assertion-syntax(断言值的语法)； 和

   <extensions> describe extensions.
   <extensions> 描述扩展。



##### 补充([ABNF](https://en.wikipedia.org/wiki/Augmented_Backus%E2%80%93Naur_form)的概述)

An ABNF specification is a set of derivation rules, written as:
一个ABNF规范是一些推导规则的集合，书写为：

```ABNF
rule = definition ; comment CR LF
规则 = 定义;注释 回车 换行
```

where rule is a [case-insensitive](https://en.wikipedia.org/wiki/Case_sensitivity) [nonterminal](https://en.wikipedia.org/wiki/Nonterminal), the definition consists of sequences of symbols that define the rule, a comment for documentation, and ending with a carriage return and line feed.
其中：

- <font color=red>“规则/rule”是不区分大小写的 非最终符号</font>
- “定义”由定义该规则的一系列符号组成
- “注释”用于记录
- “CR LF”（回车、换行）用来结束

Rule names are case-insensitive: `<rulename>`, `<Rulename>`, `<RULENAME>`, and `<rUlENamE>` all refer to the same rule. Rule names consist of a letter followed by letters, numbers, and hyphens.
规则名字是不区分大小写的: `<rulename>`, `<Rulename>`, `<RULENAME>`和`<rUlENamE>`都指的是同一个规则。
规则名字由一个字母以及后续的多个字母、数字和连字符（减号）组成。

Angle brackets (`<`, `>`) are not required around rule names (as they are in BNF). However, they may be used to delimit a rule name when used in prose to discern a rule name.
用尖括号（“`<`”，“`>`”）包围 规则名/rule-name 并不是必需的（如同它们在BNF里那样），但是它们可以用来在散文中  界定规则名，以方便识别出 规则名。



#### 4.1.4.  Matching Rule Uses(match-rule-use的定义)

A matching rule use lists the attribute types that are suitable for use with an extensibleMatch search filter.
<font color=red>matching-rule-use列出了: 适合与 extensibleMatch搜索过滤器  一起使用的  属性类型。</font>

Matching rule use descriptions are written according to the following ABNF:
<font color=red>Matching-rule-use-descriptions按照以下ABNF编写：</font>

```ABNF
 MatchingRuleUseDescription = LPAREN WSP
     numericoid                 ; object identifier         -- matching-rule的OID
     [ SP "NAME" SP qdescrs ]   ; short names (descriptors) -- 
     [ SP "DESC" SP qdstring ]  ; description
     [ SP "OBSOLETE" ]          ; not active
     SP "APPLIES" SP oids       ; attribute types           -- 列出了适合与 extensibleMatch搜索过滤器 一起使用的 attribute-type
     extensions WSP RPAREN      ; extensions
```
where:
其中
   <numericoid> is the object identifier of the matching rule associated with this matching rule use description;
   <numericoid> 是与此matching-rule-use-description相关联的matching-rule的OID；

   NAME <qdescrs> are short names (descriptors) identifying this matching rule use;
   NAME <qdescrs> 是标识此matching-rule-use的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this matching rule use is not active;
   OBSOLETE 表示此matching-rule-use未激活；

   APPLIES provides a list of attribute types the matching rule applies to; and
   APPLIES 提供了matching-rule适用的attribute-type列表； 和

   <extensions> describe extensions.
   <extensions>描述扩展。

#### 4.1.5.  LDAP Syntaxes(LDAP-syntax的定义)

LDAP Syntaxes of (attribute and assertion) values are described in terms of ASN.1 [X.680] and, optionally, have an octet string encoding known as the LDAP-specific encoding.  Commonly, the LDAP-specific encoding is constrained to a string of Unicode [Unicode] characters in UTF-8 [RFC3629] form.
<font color=red>(属性和断言)值的LDAP-syntax 根据ASN.1[X.680] 进行描述，并且可选地，具有称为 LDAP-specific-encoding的八位字节字符串编码/octet-string-encoding。 </font>
<font color=red>通常，LDAP-specific-encoding 被限制为 UTF-8[RFC3629]格式的 Unicode[Unicode]字符字符串。</font>

Each LDAP syntax is identified by an object identifier (OID).
<font color=red>每个 LDAP-syntax都由OID标识。</font>

LDAP syntax definitions are written according to the ABNF:
<font color=red>LDAP-syntax 定义是根据 ABNF 编写的：</font>

```ASN.1
 SyntaxDescription = LPAREN WSP
     numericoid                 ; object identifier
     [ SP "DESC" SP qdstring ]  ; description
     extensions WSP RPAREN      ; extensions
```
where:
   <numericoid> is the object identifier assigned to this LDAP syntax;
   <numericoid> 是分配给此 LDAP-syntax的OID；

   DESC <qdstring> is a short descriptive string; and
   DESC <qdstring> 是一个简短的描述性字符串； 和

   <extensions> describe extensions.
   <extensions> 描述扩展。



#### 4.1.6.  DIT Content Rules(DIT-content-rule的定义)

A DIT content rule is a "rule governing the content of entries of a particular structural object class" [X.501].
<font color=red>DIT-content-rule是 “管理  特定的structural-object-class's -entry   的content-rule”[X.501]。</font>

For DIT entries of a particular structural object class, a DIT content rule specifies which auxiliary object classes the entries are allowed to belong to and which additional attributes (by type) are required, allowed, or not allowed to appear in the entries.
<font color=red>对于  特定structural-object-class  的DIT-entry，</font>
<font color=red>DIT-content-rule则指定   允许entry属于哪些auxiliary-object-class  以及    哪些附加attribute(按type) "required/必须"、"allowed/允许"或"not-allowed/不允许"出现在entry中。</font>

The list of precluded attributes cannot include any attribute listed as mandatory in the rule, the structural object class, or any of the allowed auxiliary object classes.
排除属性-列表  不能包括  rule中列为强制性的任何attribute、structural-object-class或任何允许的auxiliary-object-class。

Each content rule is identified by the object identifier, as well as any short names (descriptors), of the structural object class it applies to.
<font color=red>每个content--rule由  OID 以及 它适用的structural-object-class的任何短名称(描述符) 标识。</font>

An entry may only belong to auxiliary object classes listed in the governing content rule.
<font color=red>一个entry可能只属于  governing-content-rule中列出的auxiliary-object-class。</font>

An entry must contain all attributes required by the object classes the entry belongs to as well as all attributes required by the governing content rule.
<font color=blue>entry  "必须/must" 包含  entry所属的/requiredobject-class所需的所有attribute  以及 governing-content-rule所需的/required所有attribute。</font>

An entry may contain any non-precluded attributes allowed by the object classes the entry belongs to as well as all attributes allowed by the governing content rule.
<font color=blue>entry  可以/可能  包含   entry所属的object-class允许的  任何非排除attribute   以及  governing-content-rule允许的所有attribute。</font>

An entry cannot include any attribute precluded by the governing content rule.
<font color=blue>entry  不能包含  任何被governing-content-rule排除的attribute。</font>

An entry is governed by (if present and active in the subschema) the DIT content rule that applies to the structural object class of the entry (see Section 2.4.2).  If no active rule is present for the entry's structural object class, the entry's content is governed by the structural object class (and possibly other aspects of user and system schema).  DIT content rules for superclasses of the structural object class of an entry are not applicable to that entry.
<font color=green>entry(如果存在并在subschema/子模式中处于活动状态)  受  适用于 entry的structural-object-class的 DIT-content-rule   的管理(参见第 2.4.2 节)。 </font>
<font color=green>如果entry的structural-object-class不存在 活动的-rule，则entry的content由structural-object-class(以及用户和系统schema的可能其他方面)管理。 </font>
<font color=green>entry的structural-object-class的superclass的 DIT-content-rule  不适用于该entry。</font>

DIT content rule descriptions are written according to the ABNF:
<font color=red>DIT-content-rule-description  是根据 ABNF 编写的：</font>

```ABNF
     DITContentRuleDescription = LPAREN WSP
         numericoid                 ; object identifier
         [ SP "NAME" SP qdescrs ]   ; short names (descriptors)
         [ SP "DESC" SP qdstring ]  ; description
         [ SP "OBSOLETE" ]          ; not active
         [ SP "AUX" SP oids ]       ; auxiliary object classes    -- 受此DIT-content-rule约束的entry，可能属于的auxiliary-object-class的列表
         [ SP "MUST" SP oids ]      ; attribute types
         [ SP "MAY" SP oids ]       ; attribute types
         [ SP "NOT" SP oids ]       ; attribute types
         extensions WSP RPAREN      ; extensions
```
where:
   <numericoid> is the object identifier of the structural object class associated with this DIT content rule;
   <numericoid> 是与此 DIT-content-rule 关联的structutral-object-class的OID；

   NAME <qdescrs> are short names (descriptors) identifying this DIT content rule;
   NAME <qdescrs> 是标识此 DIT-content-rule  的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this DIT content rule use is not active;
   OBSOLETE 表示此 DIT-content-rule的使用未激活；

   AUX specifies a list of auxiliary object classes that entries subject to this DIT content rule may belong to;
   AUX指定  受此DIT-content-rule约束的  entry可能属于的  auxiliary-object-class的列表；

   MUST, MAY, and NOT specify lists of attribute types that are required, allowed, or precluded, respectively, from appearing in entries subject to this DIT content rule; and
   MUST、MAY和NOT 分别指定： 需要、允许或禁止，出现在 受此DIT-content-rule约束 的entry   中的attrbute-type列表；

   <extensions> describe extensions.
   <extensions> 描述扩展。



#### 4.1.7.  DIT Structure Rules and Name Forms(DIT结构规则和命名形式)

It is sometimes desirable to regulate where object and alias entries can be placed in the DIT and how they can be named based upon their structural object class.
<font color=red>**有时需要规定 entry和alias-entry可以放置在 DIT 中的什么位置，以及如何根据它们的structrual-object-class来命名它们。**</font>



##### 4.1.7.1.  DIT Structure Rules(DIT-structural-rule的定义)

A DIT structure rule is a "rule governing the structure of the DIT by specifying a permitted superior to subordinate entry relationship.  A structure rule relates a name form, and therefore a structural object class, to superior structure rules.  This permits entries of the structural object class identified by the name form to exist in the DIT as subordinates to entries governed by the indicated superior structure rules" [X.501].
<font color=green>DIT-structure-rule 是  “ 通过指定  允许的上级到下级条目的关系  来管理 DIT的structural的rule。</font>
<font color=green>structural-rule，将name-form和structural-object-class  与上级structural-rule相关联。</font>
<font color=green>这允许  由name-form标识的  structural-object-class的entry 存在于 DIT 中，作为  受指示的 上级structure-rule管理的  entry的从属 “ [X.501]。</font>

DIT structure rule descriptions are written according to the ABNF:
<font color=red>DIT-structure-rule-description 是根据ABNF编写的：</font>

```ABNF
     DITStructureRuleDescription = LPAREN WSP
         ruleid                     ; rule identifier
         [ SP "NAME" SP qdescrs ]   ; short names (descriptors)
         [ SP "DESC" SP qdstring ]  ; description
         [ SP "OBSOLETE" ]          ; not active
         SP "FORM" SP oid           ; NameForm
         [ SP "SUP" ruleids ]       ; superior rules
         extensions WSP RPAREN      ; extensions
    
     ruleids = ruleid / ( LPAREN WSP ruleidlist WSP RPAREN )
     ruleidlist = ruleid *( SP ruleid )
     ruleid = number
```
where:
其中
   <ruleid> is the rule identifier of this DIT structure rule;
   <ruleid>是这个DIT-structure-rule的rule-OID；

   NAME <qdescrs> are short names (descriptors) identifying this DIT structure rule;
   NAME <qdescrs> 是标识此 DIT-structure-rule 的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this DIT structure rule use is not active;
   OBSOLETE DIT-structure-rule 的使用未激活；

   FORM is specifies the name form associated with this DIT structure rule;
   FORM 是指定与此 DIT-structure-rule  相关联的name-form；

   SUP identifies superior rules (by rule id); and
  <font color=red> **SUP 识别/确定 上级/rule（通过rule-id）**</font>； 和

   <extensions> describe extensions.
   <extensions> 描述扩展。

If no superior rules are identified, the DIT structure rule applies to an autonomous administrative point (e.g., the root vertex of the subtree controlled by the subschema) [X.501].
如果没有识别 上级rule，则 DIT-structure-rule 适用于 自治管理点（例如，由子模式/subschema 控制的  子树/subtree的根/root顶点）[X.501]。



##### 4.1.7.2.  Name Forms(命名形式)

A name form "specifies a permissible RDN for entries of a particular structural object class.  A name form identifies a named object class and one or more attribute types to be used for naming (i.e., for the RDN).  Name forms are primitive pieces of specification used in the definition of DIT structure rules" [X.501].
<font color=red>name-form/命名形式  “为 特定structural-object-class的entry 指定了一个允许的RDN。</font>
<font color=red>name-form/命名形式  标识了1个name-object-class  和  1个或多个用于命名(即 用于RDN)的attribute-type。</font>
<font color=red>name-form/命名形式  是 DIT-structural-rule定义中使用的基本规范”[X.501]。</font>

Each name form indicates the structural object class to be named, a set of required attribute types, and a set of allowed attribute types.  A particular attribute type cannot be in both sets.
<font color=red>每个name-form指示：要被命名的structural-object-class、一组必需的attribute-type和一组允许的attribute-type。 </font>
<font color=red>一个特定的attribute-type不能同时出现在两个集合/set 中。</font>

Entries governed by the form must be named using a value from each required attribute type and zero or more values from the allowed attribute types.
<font color=blue>必须使用  来自每个"必需"attribute-type的value  和  来自"允许"attribute-type的0个或多个value  **来命名**  由form管理的entry。</font>

Each name form is identified by an object identifier (OID) and, optionally, one or more short names (descriptors).
<font color=blue>每个name-form都由 OID和可选的1个或多个短名称（描述符）标识。</font>

Name form descriptions are written according to the ABNF:
<font color=red>name-form-description 是根据 ABNF 编写的：</font>

```ABNF
 NameFormDescription = LPAREN WSP
     numericoid                 ; object identifier
     [ SP "NAME" SP qdescrs ]   ; short names (descriptors)
     [ SP "DESC" SP qdstring ]  ; description
     [ SP "OBSOLETE" ]          ; not active
     SP "OC" SP oid             ; structural object class   -- 标识此rule适用的structural-object-class
     SP "MUST" SP oids          ; attribute types
     [ SP "MAY" SP oids ]       ; attribute types
     extensions WSP RPAREN      ; extensions
```
where:
   <numericoid> is object identifier that identifies this name form;
   <numericoid> 是标识此name-form 的OID；

   NAME <qdescrs> are short names (descriptors) identifying this name form;
   NAME <qdescrs> 是标识此name-form 的短名称（描述符）；

   DESC <qdstring> is a short descriptive string;
   DESC <qdstring> 是一个简短的描述性字符串；

   OBSOLETE indicates this name form is not active;
   OBSOLETE 表示此name-form 未激活；

   OC identifies the structural object class this rule applies to,
   OC 标识此rule适用的structural-object-class，

   MUST and MAY specify the sets of required and allowed, respectively, naming attributes for this name form; and
   MUST 和 MAY 分别为这个name-form指定了必需和允许的命名属性集/naming-attribute-set；和

   <extensions> describe extensions.
   <extensions> 描述扩展。

All attribute types in the required ("MUST") and allowed ("MAY") lists shall be different.
<font color=red>**required ("MUST") 和 allowed ("MAY")列表中的 所有attribute-type都应不同。**</font>



## 4.2.  Subschema Subentries

Subschema (sub)entries are used for administering information about the directory schema.  A single subschema (sub)entry contains all schema definitions (see Section 4.1) used by entries in a particular part of the directory tree.
<font color=blue>Subschema-(sub)entries/子模式(子)条目：用于管理有关directory-schema的信息。</font>
<font color=green>单个 subschema (sub)entry  包含   目录树特定部分中的entry  使用的所有schema定义（参见第 4.1 节）。</font>

Servers that follow X.500(93) models SHOULD implement subschema using the X.500 subschema mechanisms (as detailed in Section 12 of [X.501]), so these are not ordinary object entries but subentries (see Section 3.2).  LDAP clients SHOULD NOT assume that servers implement any of the other aspects of X.500 subschema.
<font color=blue>遵循X.500(93)模型的server  应该使用 X.500-subschema机制  实现schema(详见[X.501]的第12节), 因此这些不是普通的object-entry而是subentry（参见第 3.2 节）。    LDAP-client不应该假设  server实现了X.500-subschema的任何其他方面。</font>

Servers MAY allow subschema modification.  Procedures for subschema modification are discussed in Section 14.5 of [X.501].
<font color=green>server可以允许 subschema/子模式修改。 [X.501] 的第 14.5 节讨论了子模式修改的过程。</font>

A server that masters entries and permits clients to modify these entries SHALL implement and provide access to these subschema (sub)entries including providing a 'subschemaSubentry' attribute in each modifiable entry.  This is so clients may discover the attributes and object classes that are permitted to be present.  It is strongly RECOMMENDED that all other servers implement this as well.
<font color=blue>**server掌握了这些entry 并允许client修改这些entry，则必须实现并提供 对这些subschema (sub)entries的访问，包括在每个可修改的entry中提供一个'subschemaSubentry'-attribute。**</font>
<font color=red>这样client就可以发现允许存在/出现的 attribute和object-class。**？？？**</font>
<font color=blue>**强烈建议所有其他server也实现这一点**。</font>

The value of the 'subschemaSubentry' attribute is the name of the subschema (sub)entry holding the subschema controlling the entry.
<font color=red>**'subschemaSubentry'-attribute的value 保存了 控制该entry的subschema的 subschema (sub)entry的名称。**</font>

```schema
  ( 2.5.18.10 NAME 'subschemaSubentry'    --此attribute的名字是 subschemaSubentry   
    EQUALITY distinguishedNameMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.12
    SINGLE-VALUE NO-USER-MODIFICATION     -- 4.1.2节  NO-USER-MODIFICATION 表示该attribute-type是用户/user不可修改的；
    USAGE directoryOperation )
```

The 'distinguishedNameMatch' matching rule and the DistinguishedName (1.3.6.1.4.1.1466.115.121.1.12) syntax are defined in [RFC4517].
'distinguishedNameMatch'-match-rule 和 DistinguishedName(1.3.6.1.4.1.1466.115.121.1.12)-syntax  在 [RFC4517] 中定义。



Subschema is held in (sub)entries belonging to the subschema auxiliary object class.
<font color=red>**在属于subschema-auxiliary-object-class的  (sub)entries中 保存着subschema**。</font>

```schema
  ( 2.5.20.1 NAME 'subschema' AUXILIARY                     ;--subschema和是个辅助/auxiliary
    MAY ( dITStructureRules $ nameForms $ ditContentRules $ ;可能包含的...
      objectClasses $ attributeTypes $ matchingRules $
      matchingRuleUse ) )
```

The 'ldapSyntaxes' operational attribute may also be present in subschema entries.
<font color=red>'ldapSyntaxes'-operational-attribute  也可能出现在 subschema-entries  中。</font>

Servers MAY provide additional attributes (described in other documents) in subschema (sub)entries.
<font color=red>server可以在  子模式(子)条目/subschema (sub)entries  中提供附加attribute</font>（在其他文档中描述）。

Servers SHOULD provide the attributes 'createTimestamp' and 'modifyTimestamp' in subschema (sub)entries, in order to allow clients to maintain their caches of schema information.
<font color=red>**server应该在subschema (sub)entries中提供 attribute 'createTimestamp' and 'modifyTimestamp'，以允许client维护他们的schema信息缓存。**</font>

The following subsections provide attribute type definitions for each of schema definition attribute types.
<font color=blue>以下小节  为每个  schema定义的attribute-type  提供attribute-type定义。</font>



### 4.2.1.  'objectClasses'(object-classes的schema定义)

This attribute holds definitions of object classes.
<font color=red>这个attribute保存了object-classes的schema定义。</font>

```schema
  ( 2.5.21.6 NAME 'objectClasses'                  --此attribute的名字是  objectClasses
    EQUALITY objectIdentifierFirstComponentMatch   --使用的"相等匹配规则"是... OID第一组件匹配
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.37           --语法的OID是
    USAGE directoryOperation )                     --usage=directoryOperation 用法是：目录操作
```

The 'objectIdentifierFirstComponentMatch' matching rule and the ObjectClassDescription (1.3.6.1.4.1.1466.115.121.1.37) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule和ObjectClassDescription(1.3.6.1.4.1.1466.115.121.1.37)-syntax，被定义在[RFC4517]中。



### 4.2.2.  'attributeTypes'(attribute-types的schema定义)

This attribute holds definitions of attribute types.
<font color=red>这个attribute保存了attribute-types的schema定义。</font>

```schema
  ( 2.5.21.5 NAME 'attributeTypes'                 --此attribute的名字是attributeTypes
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.3
    USAGE directoryOperation )
```

The 'objectIdentifierFirstComponentMatch' matching rule and the AttributeTypeDescription (1.3.6.1.4.1.1466.115.121.1.3) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule和AttributeTypeDescription (1.3.6.1.4.1.1466.115.121.1.3)-syntax  ，被定义在[RFC4517]中。



### 4.2.3.  'matchingRules'(matching-rules的schema定义)

This attribute holds definitions of matching rules.
<font color=red>这个attribute保存了matching-rules的schema定义。</font>

```schema
  ( 2.5.21.4 NAME 'matchingRules'                  --此attribute的名字是matchingRules
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.30
    USAGE directoryOperation )
```

The 'objectIdentifierFirstComponentMatch' matching rule and the MatchingRuleDescription (1.3.6.1.4.1.1466.115.121.1.30) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule 和 MatchingRuleDescription (1.3.6.1.4.1.1466.115.121.1.30)-syntax  ，被定义在[RFC4517]中。



### 4.2.4 'matchingRuleUse'(matching-rule-uses的schema定义)

This attribute holds definitions of matching rule uses.
<font color=red>这个attribute保存了matching-rule-uses的schema定义。</font>

```schema
  ( 2.5.21.8 NAME 'matchingRuleUse'                --此attribute的名字是matchingRuleUse
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.31
    USAGE directoryOperation )
```
The 'objectIdentifierFirstComponentMatch' matching rule and the MatchingRuleUseDescription (1.3.6.1.4.1.1466.115.121.1.31) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule 和 MatchingRuleUseDescription (1.3.6.1.4.1.1466.115.121.1.31)-syntax  ，被定义在[RFC4517]中。



### 4.2.5.  'ldapSyntaxes'(LDAP-syntaxes的schema定义)

This attribute holds definitions of LDAP syntaxes.
<font color=red>这个attribute保存了LDAP-syntaxes的schema定义。</font>

```schema
  ( 1.3.6.1.4.1.1466.101.120.16 NAME 'ldapSyntaxes'   --此attribute的名字是ldapSyntaxes
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.54
    USAGE directoryOperation )
```
The 'objectIdentifierFirstComponentMatch' matching rule and the SyntaxDescription (1.3.6.1.4.1.1466.115.121.1.54) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule 和 SyntaxDescription (1.3.6.1.4.1.1466.115.121.1.54)-syntax  ，被定义在[RFC4517]中。



### 4.2.6.  'dITContentRules'(DIT-content-rule的schema定义)

This attribute lists DIT Content Rules that are present in the subschema.
<font color=red>这个attribute列出了 subscheam中出现的 DIT-content-rules的schema定义。</font>

```schema
  ( 2.5.21.2 NAME 'dITContentRules'                   --此attribute的名字是dITContentRules
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.16
    USAGE directoryOperation )
```

The 'objectIdentifierFirstComponentMatch' matching rule and the DITContentRuleDescription (1.3.6.1.4.1.1466.115.121.1.16) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule 和 DITContentRuleDescription (1.3.6.1.4.1.1466.115.121.1.16)-syntax  ，被定义在[RFC4517]中。



### 4.2.7.  'dITStructureRules'(DIT-structure-rules的schema定义)

This attribute lists DIT Structure Rules that are present in the subschema.
<font color=red>这个attribute列出了 subscheam中出现的 DIT-structure-rules的schema定义。</font>

```schema
  ( 2.5.21.1 NAME 'dITStructureRules'                 --此attribute的名字是dITStructureRules
    EQUALITY integerFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.17
    USAGE directoryOperation )
```

The 'integerFirstComponentMatch' matching rule and the DITStructureRuleDescription (1.3.6.1.4.1.1466.115.121.1.17) syntax are defined in [RFC4517].
'integerFirstComponentMatch'-matching-rule 和 DITStructureRuleDescription (1.3.6.1.4.1.1466.115.121.1.17)-syntax  ，被定义在[RFC4517]中。



### 4.2.8 'nameForms'(name-forms的schema定义)

This attribute lists Name Forms that are in force.
<font color=red>这个attribute列出了 有效的 name-forms的schema定义。</font>

```schema
  ( 2.5.21.7 NAME 'nameForms'                         --此attribute的名字是nameForms
    EQUALITY objectIdentifierFirstComponentMatch
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.35
    USAGE directoryOperation )
```

The 'objectIdentifierFirstComponentMatch' matching rule and the NameFormDescription (1.3.6.1.4.1.1466.115.121.1.35) syntax are defined in [RFC4517].
'objectIdentifierFirstComponentMatch'-matching-rule 和 NameFormDescription (1.3.6.1.4.1.1466.115.121.1.35)-syntax  ，被定义在[RFC4517]中。



## 4.3.  'extensibleObject' object class(extensibleObject-object-class的schema定义)

The 'extensibleObject' auxiliary object class allows entries that belong to it to hold any user attribute.  The set of allowed attribute types of this object class is implicitly the set of all attribute types of userApplications usage.
<font color=red>**'extensibleObject'-auxiliary-object-class 允许属于它的entry   保存  任何用户属性/user-attribute。** </font>
<font color=blue>该object-class允许的attribute-type集合  隐式是 usage=userApplications的所有attribute-type的集合。</font>

```schema
  ( 1.3.6.1.4.1.1466.101.120.111 NAME 'extensibleObject'
    SUP top AUXILIARY )
```

The mandatory attributes of the other object classes of this entry are still required to be present, and any precluded attributes are still not allowed to be present.
该entry的 其他object-class的必需属性仍然需要存在，并且仍然不允许存在任何  排除的属性。
<font color=red>即，其他object-class要求必须存在的attribute则必须存在，不允许出现的attribute仍然不允许出现。</font>



## 4.4.  Subschema Discovery

To discover the DN of the subschema (sub)entry holding the subschema controlling a particular entry, a client reads that entry's 'subschemaSubentry' operational attribute.  To read schema attributes from the subschema (sub)entry, clients MUST issue a Search operation [RFC4511] where baseObject is the DN of the subschema (sub)entry,scope is baseObject, filter is "(objectClass=subschema)" [RFC4515], and the attributes field lists the names of the desired schema attributes (as they are operational).  Note: the "(objectClass=subschema)" filter allows LDAP servers that gateway to X.500 to detect that subentry information is being requested.
为了发现控制特定条目的子模式的子模式（子）条目的 DN，客户端读取该条目的“subschemaSubentry”操作属性。 要从子模式（子）条目中读取模式属性，客户端必须发出搜索操作 [RFC4511]，其中 baseObject 是子模式（子）条目的 DN，范围是 baseObject，过滤器是“（objectClass=subschema）”[RFC4515] ，属性字段列出了所需架构属性的名称（因为它们是可操作的）。 注意：“(objectClass=subschema)”过滤器允许连接到 X.500 的 LDAP 服务器检测正在请求的子条目信息。

Clients SHOULD NOT assume that a published subschema is complete, that the server supports all of the schema elements it publishes, or that the server does not support an unpublished element.
客户端不应该假设发布的子模式是完整的，服务器支持它发布的所有模式元素，或者服务器不支持未发布的元素。



# 5. DSA (Server) Informational Model(server端-DSA信息模型)

The LDAP protocol assumes there are one or more servers that jointly provide access to a Directory Information Tree (DIT).  The server holding the original information is called the "master" (for that information).  Servers that hold copies of the original information are referred to as "shadowing" or "caching" servers.
<font color=green>LDAP-protocol/协议  假设有1台或多台server共同提供对目录信息树 (DIT) 的访问/access。</font>
<font color=green>保存原始信息的server称为"主/master"(对于该信息)。</font>
<font color=green>保存原始信息副本的server称为"shadowing/镜像"或"caching/缓存"服务器。</font>

As defined in [X.501]:
如 [X.501] 中所定义：

- context prefix: The sequence of RDNs leading from the Root of the DIT to the initial vertex of a naming context; corresponds to the distinguished name of that vertex.
<font color=blue>context-prefix/上下文前缀：从  DIT的root/根  到命名上下文的初始顶点   的RDN序列； 对应于该顶点的  专有名称/DN。</font>
- naming context: A subtree of entries held in a single master DSA.
<font color=blue>naming-context/命名上下文：保存在   单个主DSA中的    entry的subtree。</font>

That is, a naming context is the largest collection of entries, starting at an entry that is mastered by a particular server, and including all its subordinates and their subordinates, down to the entries that are mastered by different servers.  The context prefix is the name of the initial entry.
<font color=red>**也就是说，naming-context/命名上下文： 是entry最大的集合，从  由特定server控制的entry  开始，包括其所有下属及其下属，一直到由不同server控制的entry。** </font>
<font color=red>**context-prefix/上下文前缀：是初始entry的name。**</font>

The root of the DIT is a DSA-specific Entry (DSE) and not part of any naming context (or any subtree); each server has different attribute values in the root DSE.
<font color=blue>**DIT的根/root  是一个 DSA-specific Entry (DSE) ，而不是任何 naming-context/命名上下文(或任何subtree)的一部分； 每个服务器在根 DSE 中都有不同的attribute-value。**</font>



## 5.1.  Server-Specific Data Requirements(特定于server的数据请求)

An LDAP server SHALL provide information about itself and other  information that is specific to each server.  This is represented as  a group of attributes located in the root DSE, which is named with  the DN with zero RDNs (whose [RFC4514] representation is as the  zero-length string).

These attributes are retrievable, subject to access control and other  restrictions, if a client performs a Search operation [RFC4511] with  an empty baseObject, scope of baseObject, the filter



Zeilenga                    Standards Track                    [Page 36]

RFC 4512                      LDAP Models                      June 2006

"(objectClass=*)" [RFC4515], and the attributes field listing the names of the desired attributes.  It is noted that root DSE attributes are operational and, like other operational attributes,  are not returned in search requests unless requested by name.

The root DSE SHALL NOT be included if the client performs a subtree search starting from the root.

Servers may allow clients to modify attributes of the root DSE, where appropriate.

The following attributes of the root DSE are defined below. Additional attributes may be defined in other documents.
- altServer: alternative servers;
- namingContexts: naming contexts;
- supportedControl: recognized LDAP controls;
- supportedExtension: recognized LDAP extended operations;
- supportedFeatures: recognized LDAP features;
- supportedLDAPVersion: LDAP versions supported; and
- supportedSASLMechanisms: recognized Simple Authentication and Security Layers (SASL) [RFC4422] mechanisms.

The values provided for these attributes may depend on session-specific and other factors.  For example, a server supporting the SASL EXTERNAL mechanism might only list "EXTERNAL" when the client's identity has been established by a lower level.  See [RFC4513].

The root DSE may also include a 'subschemaSubentry' attribute.  If it does, the attribute refers to the subschema (sub)entry holding the schema controlling the root DSE.  Clients SHOULD NOT assume that this subschema (sub)entry controls other entries held by the server. General subschema discovery procedures are provided in Section 4.4.












Zeilenga                    Standards Track                    [Page 37]

RFC 4512                      LDAP Models                      June 2006

### 5.1.1.  'altServer'

The 'altServer' attribute lists URIs referring to alternative servers that may be contacted when this server becomes unavailable.  URIs for servers implementing the LDAP are written according to [RFC4516]. Other kinds of URIs may be provided.  If the server does not know of any other servers that could be used, this attribute will be absent. Clients may cache this information in case their preferred server later becomes unavailable.

```ABNF
  ( 1.3.6.1.4.1.1466.101.120.6 NAME 'altServer'
    SYNTAX 1.3.6.1.4.1.1466.115.121.1.26
    USAGE dSAOperation )
```

   The IA5String (1.3.6.1.4.1.1466.115.121.1.26) syntax is defined in [RFC4517].



### 5.1.2.  'namingContexts'

   The 'namingContexts' attribute lists the context prefixes of the
   naming contexts the server masters or shadows (in part or in whole).
   If the server is a first-level DSA [X.501], it should list (in
   addition) an empty string (indicating the root of the DIT).  If the
   server does not master or shadow any information (e.g., it is an LDAP
   gateway to a public X.500 directory) this attribute will be absent.
   If the server believes it masters or shadows the entire directory,
   the attribute will have a single value, and that value will be the
   empty string (indicating the root of the DIT).

   This attribute may be used, for example, to select a suitable entry
   name for subsequent operations with this server.

      ( 1.3.6.1.4.1.1466.101.120.5 NAME 'namingContexts'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.12
        USAGE dSAOperation )

   The DistinguishedName (1.3.6.1.4.1.1466.115.121.1.12) syntax is
   defined in [RFC4517].

### 5.1.3.  'supportedControl'

   The 'supportedControl' attribute lists object identifiers identifying
   the request controls [RFC4511] the server supports.  If the server
   does not support any request controls, this attribute will be absent.
   Object identifiers identifying response controls need not be listed.

   Procedures for registering object identifiers used to discovery of
   protocol mechanisms are detailed in BCP 64, RFC 4520 [RFC4520].



Zeilenga                    Standards Track                    [Page 38]

RFC 4512                      LDAP Models                      June 2006


      ( 1.3.6.1.4.1.1466.101.120.13 NAME 'supportedControl'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.38
        USAGE dSAOperation )

   The OBJECT IDENTIFIER (1.3.6.1.4.1.1466.115.121.1.38) syntax is
   defined in [RFC4517].

### 5.1.4.  'supportedExtension'

   The 'supportedExtension' attribute lists object identifiers
   identifying the extended operations [RFC4511] that the server
   supports.  If the server does not support any extended operations,
   this attribute will be absent.

   An extended operation generally consists of an extended request and
   an extended response but may also include other protocol data units
   (such as intermediate responses).  The object identifier assigned to
   the extended request is used to identify the extended operation.
   Other object identifiers used in the extended operation need not be
   listed as values of this attribute.

   Procedures for registering object identifiers used to discovery of
   protocol mechanisms are detailed in BCP 64, RFC 4520 [RFC4520].

      ( 1.3.6.1.4.1.1466.101.120.7 NAME 'supportedExtension'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.38
        USAGE dSAOperation )

   The OBJECT IDENTIFIER (1.3.6.1.4.1.1466.115.121.1.38) syntax is
   defined in [RFC4517].

### 5.1.5.  'supportedFeatures'

   The 'supportedFeatures' attribute lists object identifiers
   identifying elective features that the server supports.  If the
   server does not support any discoverable elective features, this
   attribute will be absent.

      ( 1.3.6.1.4.1.4203.1.3.5 NAME 'supportedFeatures'
          EQUALITY objectIdentifierMatch
          SYNTAX 1.3.6.1.4.1.1466.115.121.1.38
          USAGE dSAOperation )

   Procedures for registering object identifiers used to discovery of
   protocol mechanisms are detailed in BCP 64, RFC 4520 [RFC4520].

   The OBJECT IDENTIFIER (1.3.6.1.4.1.1466.115.121.1.38) syntax and
   objectIdentifierMatch matching rule are defined in [RFC4517].



Zeilenga                    Standards Track                    [Page 39]

RFC 4512                      LDAP Models                      June 2006

### 5.1.6.  'supportedLDAPVersion'

   The 'supportedLDAPVersion' attribute lists the versions of LDAP that
   the server supports.

      ( 1.3.6.1.4.1.1466.101.120.15 NAME 'supportedLDAPVersion'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.27
        USAGE dSAOperation )

   The INTEGER (1.3.6.1.4.1.1466.115.121.1.27) syntax is defined in
   [RFC4517].

### 5.1.7.  'supportedSASLMechanisms'

   The 'supportedSASLMechanisms' attribute lists the SASL mechanisms
   [RFC4422] that the server recognizes and/or supports [RFC4513].  The
   contents of this attribute may depend on the current session state.
   If the server does not support any SASL mechanisms, this attribute
   will not be present.

      ( 1.3.6.1.4.1.1466.101.120.14 NAME 'supportedSASLMechanisms'
        SYNTAX 1.3.6.1.4.1.1466.115.121.1.15
        USAGE dSAOperation )

   The Directory String (1.3.6.1.4.1.1466.115.121.1.15) syntax is
   defined in [RFC4517].

# 6. Other Considerations

## 6.1.  Preservation of User Information

   Syntaxes may be defined that have specific value and/or value form
   (representation) preservation requirements.  For example, a syntax
   containing digitally signed data can mandate that the server preserve
   both the value and form of value presented to ensure that the
   signature is not invalidated.

   Where such requirements have not been explicitly stated, servers
   SHOULD preserve the value of user information but MAY return the
   value in a different form.  And where a server is unable (or
   unwilling) to preserve the value of user information, the server
   SHALL ensure that an equivalent value (per Section 2.3) is returned.









Zeilenga                    Standards Track                    [Page 40]

RFC 4512                      LDAP Models                      June 2006

## 6.2.  Short Names

   Short names, also known as descriptors, are used as more readable
   aliases for object identifiers and are used to identify various
   schema elements.  However, it is not expected that LDAP
   implementations with human user interface would display these short
   names (or the object identifiers they refer to) to the user.
   Instead, they would most likely be performing translations (such as
   expressing the short name in one of the local national languages).
   For example, the short name "st" (stateOrProvinceName) might be
   displayed to a German-speaking user as "Land".

   The same short name might have different meaning in different
   subschemas, and, within a particular subschema, the same short name
   might refer to different object identifiers each identifying a
   different kind of schema element.

   Implementations MUST be prepared that the same short name might be
   used in a subschema to refer to the different kinds of schema
   elements.  That is, there might be an object class 'x-fubar' and an
   attribute type 'x-fubar' in a subschema.

   Implementations MUST be prepared that the same short name might be
   used in the different subschemas to refer to the different schema
   elements.  That is, there might be two matching rules 'x-fubar', each
   in different subschemas.

   Procedures for registering short names (descriptors) are detailed in
   BCP 64, RFC 4520 [RFC4520].

6.3.  Cache and Shadowing

   Some servers may hold cache or shadow copies of entries, which can be
   used to answer search and comparison queries, but will return
   referrals or contact other servers if modification operations are
   requested.  Servers that perform shadowing or caching MUST ensure
   that they do not violate any access control constraints placed on the
   data by the originating server.













Zeilenga                    Standards Track                    [Page 41]

RFC 4512                      LDAP Models                      June 2006

# 7. Implementation Guidelines

## 7.1.  Server Guidelines

   Servers MUST recognize all names of attribute types and object
   classes defined in this document but, unless stated otherwise, need
   not support the associated functionality.  Servers SHOULD recognize
   all the names of attribute types and object classes defined in
   Section 3 and 4, respectively, of [RFC4519].

   Servers MUST ensure that entries conform to user and system schema
   rules or other data model constraints.

   Servers MAY support DIT Content Rules.  Servers MAY support DIT
   Structure Rules and Name Forms.

   Servers MAY support alias entries.

   Servers MAY support the 'extensibleObject' object class.

   Servers MAY support subentries.  If so, they MUST do so in accordance
   with [RFC3672].  Servers that do not support subentries SHOULD use
   object entries to mimic subentries as detailed in Section 3.2.

   Servers MAY implement additional schema elements.  Servers SHOULD
   provide definitions of all schema elements they support in subschema
   (sub)entries.

## 7.2.  Client Guidelines

   In the absence of prior agreements with servers, clients SHOULD NOT
   assume that servers support any particular schema elements beyond
   those referenced in Section 7.1.  The client can retrieve subschema
   information as described in Section 4.4.

   Clients MUST NOT display or attempt to decode a value as ASN.1 if the
   value's syntax is not known.  Clients MUST NOT assume the LDAP-
   specific string encoding is restricted to a UTF-8 encoded string of
   Unicode characters or any particular subset of Unicode (such as a
   printable subset) unless such restriction is explicitly stated.
   Clients SHOULD NOT send attribute values in a request that are not
   valid according to the syntax defined for the attributes.









Zeilenga                    Standards Track                    [Page 42]

RFC 4512                      LDAP Models                      June 2006

# 8. Security Considerations

Attributes of directory entries are used to provide descriptive information about the real-world objects they represent, which can be people, organizations, or devices.  Most countries have privacy laws regarding the publication of information about people.

General security considerations for accessing directory information with LDAP are discussed in [RFC4511] and [RFC4513].

# 9. IANA Considerations(IANA分配号码)

The Internet Assigned Numbers Authority (IANA) has updated the LDAP descriptors registry as indicated in the following template:

```
   Subject: Request for LDAP Descriptor Registration Update
   Descriptor (short name): see comment
   Object Identifier: see comment
   Person & email address to contact for further information:
       Kurt Zeilenga <kurt@OpenLDAP.org>
   Usage: see comment
   Specification: RFC 4512
   Author/Change Controller: IESG
   Comments:
```

   The following descriptors (short names) has been added to the registry.

```
        NAME                         Type OID
        ------------------------     ---- -----------------
        governingStructureRule          A 2.5.21.10
        structuralObjectClass           A 2.5.21.9

```

   The following descriptors (short names) have been updated to refer to this RFC.

```
        NAME                         Type OID
        ------------------------     ---- -----------------
        alias                           O 2.5.6.1
        aliasedObjectName               A 2.5.4.1
        altServer                       A 1.3.6.1.4.1.1466.101.120.6
        attributeTypes                  A 2.5.21.5
        createTimestamp                 A 2.5.18.1
        creatorsName                    A 2.5.18.3
        dITContentRules                 A 2.5.21.2
        dITStructureRules               A 2.5.21.1
        extensibleObject                O 1.3.6.1.4.1.1466.101.120.111
        ldapSyntaxes                    A 1.3.6.1.4.1.1466.101.120.16
        matchingRuleUse                 A 2.5.21.8
        matchingRules                   A 2.5.21.4
        modifiersName                   A 2.5.18.4
        modifyTimestamp                 A 2.5.18.2
        nameForms                       A 2.5.21.7
        namingContexts                  A 1.3.6.1.4.1.1466.101.120.5
        objectClass                     A 2.5.4.0
        objectClasses                   A 2.5.21.6
        subschema                       O 2.5.20.1
        subschemaSubentry               A 2.5.18.10
        supportedControl                A 1.3.6.1.4.1.1466.101.120.13
        supportedExtension              A 1.3.6.1.4.1.1466.101.120.7
        supportedFeatures               A 1.3.6.1.4.1.4203.1.3.5
        supportedLDAPVersion            A 1.3.6.1.4.1.1466.101.120.15
        supportedSASLMechanisms         A 1.3.6.1.4.1.1466.101.120.14
        top 
```

# 10. Acknowledgements(致谢)

   This document is based in part on RFC 2251 by M. Wahl, T. Howes, and
   S. Kille; RFC 2252 by M. Wahl, A. Coulbeck, T. Howes, S. Kille; and
   RFC 2556 by M. Wahl, all products of the IETF Access, Searching and
   Indexing of Directories (ASID) Working Group.  This document is also
   based in part on "The Directory: Models" [X.501], a product of the
   International Telephone Union (ITU).  Additional text was borrowed
   from RFC 2253 by M. Wahl, T. Howes, and S. Kille.

   This document is a product of the IETF LDAP Revision (LDAPBIS)
   Working Group.






















Zeilenga                    Standards Track                    [Page 44]

RFC 4512                      LDAP Models                      June 2006

# 11. Normative References(参考)

   [RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate
                 Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC3629]     Yergeau, F., "UTF-8, a transformation format of ISO
                 10646", STD 63, RFC 3629, November 2003.

   [RFC3671]     Zeilenga, K., "Collective Attributes in the Lightweight
                 Directory Access Protocol (LDAP)", RFC 3671, December
                 2003.

   [RFC3672]     Zeilenga, K., "Subentries in the Lightweight Directory
                 Access Protocol (LDAP)", RFC 3672, December 2003.

   [RFC4234]     Crocker, D. and P. Overell, "Augmented BNF for Syntax
                 Specifications: ABNF", RFC 4234, October 2005.

   [RFC4422]     Melnikov, A., Ed. and K. Zeilenga, Ed., "Simple
                 Authentication and Security Layer (SASL)", RFC 4422,
                 June 2006.

   [RFC4510]     Zeilenga, K., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Technical Specification Road Map", RFC
                 4510, June 2006.

   [RFC4511]     Sermersheim, J., Ed., "Lightweight Directory Access
                 Protocol (LDAP): The Protocol", RFC 4511, June 2006.

   [RFC4513]     Harrison, R., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Authentication Methods and Security
                 Mechanisms", RFC 4513, June 2006.

   [RFC4514]     Zeilenga, K., Ed., "Lightweight Directory Access
                 Protocol (LDAP): String Representation of Distinguished
                 Names", RFC 4514, June 2006.

   [RFC4515]     Smith, M., Ed. and T. Howes, "Lightweight Directory
                 Access Protocol (LDAP): String Representation of Search
                 Filters", RFC 4515, June 2006.

   [RFC4516]     Smith, M., Ed. and T. Howes, "Lightweight Directory
                 Access Protocol (LDAP): Uniform Resource Locator", RFC
                 4516, June 2006.

   [RFC4517]     Legg, S., Ed., "Lightweight Directory Access Protocol
                 (LDAP): Syntaxes and Matching Rules", RFC 4517, June
                 2006.



Zeilenga                    Standards Track                    [Page 45]

RFC 4512                      LDAP Models                      June 2006


   [RFC4519]     Sciberras, A., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Schema for User Applications", RFC
                 4519, June 2006.

   [RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority
                 (IANA) Considerations for the Lightweight Directory
                 Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

   [Unicode]     The Unicode Consortium, "The Unicode Standard, Version
                 3.2.0" is defined by "The Unicode Standard, Version
                 3.0" (Reading, MA, Addison-Wesley, 2000.  ISBN 0-201-
                 61633-5), as amended by the "Unicode Standard Annex
                 #27: Unicode 3.1"
                 (http://www.unicode.org/reports/tr27/) and by the
                 "Unicode Standard Annex #28: Unicode 3.2"
                 (http://www.unicode.org/reports/tr28/).

   [X.500]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Overview of concepts, models and
                 services," X.500(1993) (also ISO/IEC 9594-1:1994).

   [X.501]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Models," X.501(1993) (also ISO/IEC 9594-
                 2:1994).

   [X.680]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "Abstract
                 Syntax Notation One (ASN.1) - Specification of Basic
                 Notation", X.680(2002) (also ISO/IEC 8824-1:2002).



















Zeilenga                    Standards Track                    [Page 46]

RFC 4512                      LDAP Models                      June 2006

# Appendix A.  Changes

   This appendix is non-normative.

   This document amounts to nearly a complete rewrite of portions of RFC
   2251, RFC 2252, and RFC 2256.  This rewrite was undertaken to improve
   overall clarity of technical specification.  This appendix provides a
   summary of substantive changes made to the portions of these
   documents incorporated into this document.  Readers should consult
   [RFC4510], [RFC4511], [RFC4517], and [RFC4519] for summaries of
   remaining portions of these documents.

## A.1.  Changes to RFC 2251

   This document incorporates from RFC 2251, Sections 3.2 and 3.4, and
   portions of Sections 4 and 6 as summarized below.

### A.1.1.  Section 3.2 of RFC 2251

   Section 3.2 of RFC 2251 provided a brief introduction to the X.500
   data model, as used by LDAP.  The previous specification relied on
   [X.501] but lacked clarity in how X.500 models are adapted for use by
   LDAP.  This document describes the X.500 data models, as used by
   LDAP, in greater detail, especially in areas where adaptation is
   needed.

   Section 3.2.1 of RFC 2251 described an attribute as "a type with one
   or more associated values".  In LDAP, an attribute is better
   described as an attribute description, a type with zero or more
   options, and one or more associated values.

   Section 3.2.2 of RFC 2251 mandated that subschema subentries contain
   objectClasses and attributeTypes attributes, yet X.500(93) treats
   these attributes as optional.  While generally all implementations
   that support X.500(93) subschema mechanisms will provide both of
   these attributes, it is not absolutely required for interoperability
   that all servers do.  The mandate was removed for consistency with
   X.500(93).   The subschema discovery mechanism was also clarified to
   indicate that subschema controlling an entry is obtained by reading
   the (sub)entry referred to by that entry's 'subschemaSubentry'
   attribute.










Zeilenga                    Standards Track                    [Page 47]

RFC 4512                      LDAP Models                      June 2006

### A.1.2.  Section 3.4 of RFC 2251

   Section 3.4 of RFC 2251 provided "Server-specific Data Requirements".
   This material, with changes, was incorporated in Section 5.1 of this
   document.

   Changes:

   - Clarify that attributes of the root DSE are subject to "other
     restrictions" in addition to access controls.

   - Clarify that only recognized extended requests need to be
     enumerated 'supportedExtension'.

   - Clarify that only recognized request controls need to be enumerated
     'supportedControl'.

   - Clarify that root DSE attributes are operational and, like other
     operational attributes, will not be returned in search requests
     unless requested by name.

   - Clarify that not all root DSE attributes are user modifiable.

   - Remove inconsistent text regarding handling of the
     'subschemaSubentry' attribute within the root DSE.  The previous
     specification stated that the 'subschemaSubentry' attribute held in
     the root DSE referred to "subschema entries (or subentries) known
     by this server".  This is inconsistent with the attribute's
     intended use as well as its formal definition as a single valued
     attribute [X.501].  It is also noted that a simple (possibly
     incomplete) list of subschema (sub)entries is not terribly useful.
     This document (in Section 5.1) specifies that the
     'subschemaSubentry' attribute of the root DSE refers to the
     subschema controlling the root DSE.  It is noted that the general
     subschema discovery mechanism remains available (see Section 4.4 of
     this document).

### A.1.3.  Section 4 of RFC 2251

   Portions of Section 4 of RFC 2251 detailing aspects of the
   information model used by LDAP were incorporated in this document,
   including:

   - Restriction of distinguished values to attributes whose
     descriptions have no options (from Section 4.1.3);






Zeilenga                    Standards Track                    [Page 48]

RFC 4512                      LDAP Models                      June 2006


   - Data model aspects of Attribute Types (from Section 4.1.4),
     Attribute Descriptions (from 4.1.5), Attribute (from 4.1.8),
     Matching Rule Identifier (from 4.1.9); and

   - User schema requirements (from Sections 4.1.6, 4.5.1, and 4.7).

   Clarifications to these portions include:

   - Subtyping and AttributeDescriptions with options.

### A.1.4.  Section 6 of RFC 2251

   The Section 6.1 and the second paragraph of Section 6.2 of RFC 2251
   where incorporated into this document.

## A.2.  Changes to RFC 2252

   This document incorporates Sections 4, 5, and 7 from RFC 2252.

### A.2.1.  Section 4 of RFC 2252

   The specification was updated to use Augmented BNF [RFC4234].  The
   string representation of an OBJECT IDENTIFIER was tightened to
   disallow leading zeros as described in RFC 2252.

   The <descr> syntax was changed to disallow semicolon (U+003B)
   characters in order to appear to be consistent its natural language
   specification "descr is the syntactic representation of an object
   descriptor, which consists of letters and digits, starting with a
   letter".  In a related change, the statement "an AttributeDescription
   can be used as the value in a NAME part of an
   AttributeTypeDescription" was deleted.  RFC 2252 provided no
   specification of the semantics of attribute options appearing in NAME
   fields.

   RFC 2252 stated that the <descr> form of <oid> SHOULD be preferred
   over the <numericoid> form.  However, <descr> form can be ambiguous.
   To address this issue, the imperative was replaced with a statement
   (in Section 1.4) that while the <descr> form is generally preferred,
   <numericoid> should be used where an unambiguous <descr> is not
   available.  Additionally, an expanded discussion of descriptor issues
   is in Section 6.2 ("Short Names").

   The ABNF for a quoted string (qdstring) was updated to reflect
   support for the escaping mechanism described in Section 4.3 of RFC
   2252.





Zeilenga                    Standards Track                    [Page 49]

RFC 4512                      LDAP Models                      June 2006

### A.2.2.  Section 5 of RFC 2252

   Definitions of operational attributes provided in Section 5 of RFC
   2252 where incorporated into this document.

   The 'namingContexts' description was clarified.  A first-level DSA
   should publish, in addition to other values, "" indicating the root
   of the DIT.

   The 'altServer' description was clarified.  It may hold any URI.

   The 'supportedExtension' description was clarified.  A server need
   only list the OBJECT IDENTIFIERs associated with the extended
   requests of the extended operations it recognizes.

   The 'supportedControl' description was clarified.  A server need only
   list the OBJECT IDENTIFIERs associated with the request controls it
   recognizes.

   Descriptions for the 'structuralObjectClass' and
   'governingStructureRule' operational attribute types were added.

   The attribute definition of 'subschemaSubentry' was corrected to list
   the terms SINGLE-VALUE and NO-USER-MODIFICATION in proper order.

### A.2.3.  Section 7 of RFC 2252

   Section 7 of RFC 2252 provides definitions of the 'subschema' and
   'extensibleObject' object classes.  These definitions where
   integrated into Section 4.2 and Section 4.3 of this document,
   respectively.  Section 7 of RFC 2252 also contained the object class
   implementation requirement.  This was incorporated into Section 7 of
   this document.

   The specification of 'extensibleObject' was clarified regarding how
   it interacts with precluded attributes.

## A.3.  Changes to RFC 2256

   This document incorporates Sections 5.1, 5.2, 7.1, and 7.2 of RFC
   2256.

   Section 5.1 of RFC 2256 provided the definition of the 'objectClass'
   attribute type.  This was integrated into Section 2.4.1 of this
   document.  The statement "One of the values is either 'top' or
   'alias'" was replaced with statement that one of the values is 'top'
   as entries belonging to 'alias' also belong to 'top'.




Zeilenga                    Standards Track                    [Page 50]

RFC 4512                      LDAP Models                      June 2006


   Section 5.2 of RFC 2256 provided the definition of the
   'aliasedObjectName' attribute type.  This was integrated into Section
   2.6.2 of this document.

   Section 7.1 of RFC 2256 provided the definition of the 'top' object
   class.  This was integrated into Section 2.4.1 of this document.

   Section 7.2 of RFC 2256 provided the definition of the 'alias' object
   class.  This was integrated into Section 2.6.1 of this document.

## A.4.  Changes to RFC 3674

   This document made no substantive change to the 'supportedFeatures'
   technical specification provided in RFC 3674.

Editor's Address

   Kurt D.  Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org






























Zeilenga                    Standards Track                    [Page 51]

RFC 4512                      LDAP Models                      June 2006

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

Acknowledgement

   Funding for the RFC Editor function is provided by the IETF
   Administrative Support Activity (IASA).







Zeilenga                    Standards Track                    [Page 52]

