





Network Working Group                                             G. Good
Request for Comments: 2849                   iPlanet e-commerce Solutions
Category: Standards Track                                       June 2000

# The LDAP Data Interchange Format (LDIF) - Technical Specification(LDIF规范)

## Status of this Memo

This document specifies an Internet standards track protocol for the Internet community, and requests discussion and suggestions for improvements.  Please refer to the current edition of the "Internet Official Protocol Standards" (STD 1) for the standardization state and status of this protocol. Distribution of this memo is unlimited.

## Copyright Notice

Copyright (C) The Internet Society (2000).  All Rights Reserved.



# 0. Abstract

This document describes a file format suitable for describing directory information or modifications made to directory information. The file format, known as LDIF, for LDAP Data Interchange Format, is typically used to import and export directory information between LDAP-based directory servers, or to describe a set of changes which are to be applied to a directory.
<font color=red>本文档描述了 一种文件格式：适用于 描述目录信息 或 对目录信息进行修改  。 </font>
<font color=blue>LDAP-Data-Interchange-Format/**LDAP数据交换格式**  的 文件格式称为 LDIF，</font>
<font color=red>通常用于 1)在基于LDAP的目录服务器之间导入和导出目录信息，或 2)描述了一组将要应用于目录的更改。</font>



## 0.1 Background and Intended Usage(背景和预期用途)

There are a number of situations where a common interchange format is desirable.  For example, one might wish to export a copy of the contents of a directory server to a file, move that file to a different machine, and import the contents into a second directory server.
在许多情况下，需要通用交换格式。 
<font color=green>例如，人们可能希望将  目录服务器内容的副本  导出到文件中，将该文件移动到另一台机器上，然后将内容导入到第二个目录服务器中。</font>

Additionally, by using a well-defined interchange format, development of data import tools from legacy systems is facilitated.  A fairly simple set of tools written in awk or perl can, for example, convert a database of personnel information into an LDIF file. This file can then be imported into a directory server, regardless of the internal database representation the target directory server uses.
此外，通过使用定义明确的交换格式，可以促进从遗留系统  开发数据导入工具。 
例如，用 awk 或 perl 编写的一组相当简单的工具   <font color=blue>可以将</font>人事信息<font color=blue>数据库转换为 LDIF 文件</font>。 
<font color=blue>然后可以将此文件导入目录服务器，而不管目标目录服务器使用何种内部数据库表示。</font>

The LDIF format was originally developed and used in the University of Michigan LDAP implementation.  The first use of LDIF was in describing directory entries.  Later, the format was expanded to allow representation of changes to directory entries.
LDIF 格式最初是在密歇根大学 LDAP 实现中开发和使用的。 
<font color=green>LDIF 的第一次使用是   描述目录条目。 后来，该格式被扩展  以允许表示目录条目的更改。</font>



## 0.2 Relationship to the application/directory MIME content-type:

The application/directory MIME content-type [1] is a general framework and format for conveying directory information, and is independent of any particular directory service.  The LDIF format is a simpler format which is perhaps easier to create, and may also be used, as noted, to describe a set of changes to be applied to a directory.
application/directory MIME content-type [1]   是用于传送目录信息的   通用框架和格式，并且独立于任何特定目录服务。 
<font color=blue>LDIF格式  是一种更简单的格式，它可能更容易创建，并且如上所述，还可用于描述 要应用于目录的一组更改。</font>

The key words "MUST", "MUST NOT", "MAY", "SHOULD", and "SHOULD NOT" used in this document are to be interpreted as described in [7].
本文档中使用的关键词“MUST”、“MUST NOT”、“MAY”、“SHOULD”和“SHOULD NOT”将按照[7]中的描述进行解释。



## 0.3 Definition of the LDAP Data Interchange Format(LDIF的定义)

The LDIF format is used to convey directory information, or a description of a set of changes made to directory entries.  An LDIF file consists of a series of records separated by line separators.  A record consists of a sequence of lines describing a directory entry, or a sequence of lines describing a set of changes to a directory entry.  An LDIF file specifies a set of directory entries, or a set of changes to be applied to directory entries, but not both.
<font color=green>LDIF 格式用于   传送目录信息，或 描述对目录条目所做的一组更改。 </font>
<font color=green>LDIF文件  由一系列 由行分隔符分隔的 记录组成。 </font>
<font color=green>记录由  一系列描述目录条目的行  或  一系列描述目录条目更改的行  组成。 </font>
LDIF 文件指定一组目录条目或一组要应用于目录条目的更改，但不能同时指定两者。

There is a one-to-one correlation between LDAP operations that modify the directory (add, delete, modify, and modrdn), and the types of changerecords described below ("add", "delete", "modify", and "modrdn" or "moddn").  This correspondence is intentional, and permits a straightforward translation from LDIF changerecords to protocol operations.
<font color=green>修改目录的 LDAP 操作(add, delete, modify, and modrdn) 与下面描述的更改记录的类型("add", "delete", "modify", and "modrdn" or "moddn") 是一一对应的。 </font>
<font color=green>这种对应是有意的，并允许  从 LDIF更改记录 到协议操作  的直接转换。</font>



# 1. Formal Syntax Definition of LDIF(LDIF的语法元素)

The following definition uses the augmented Backus-Naur Form specified in RFC 2234 [2].
下面的定义使用RFC 2234[2]中指定的ABNF。

```ABNF
ldif-file                = ldif-content / ldif-changes					; 描述 / 修改

ldif-content             = version-spec 1*(1*SEP ldif-attrval-record)	; version+描述性记录
ldif-changes             = version-spec 1*(1*SEP ldif-change-record)	; version+修改性记录

ldif-attrval-record      = dn-spec SEP 1*attrval-spec					; DN+描述性记录
ldif-change-record       = dn-spec SEP *control changerecord			; DN+修改性记录

version-spec             = "version:" FILL version-number				;版本
version-number           = 1*DIGIT
                           ; version-number MUST be "1" for the
                           ; LDIF format described in this document. 	;对于本文档描述的LDIF格式 version-number必须是"1"


dn-spec                  = "dn:" (FILL distinguishedName /				; "dn:"      "ASCII编码的DN"
                                  ":" FILL base64-distinguishedName)	; "dn:"":"   "base64编码的DN" (需要两个":")
distinguishedName        = SAFE-STRING									
                           ; a distinguished name, as defined in [3]	;ASCII编码的DN
base64-distinguishedName = BASE64-UTF8-STRING
                           ; a distinguishedName which has been base64	;base64编码的DN
                           ; encoded (see note 10, below)	


rdn                      = SAFE-STRING									
                           ; a relative distinguished name, defined as	;ASCII编码的RDN
                           ; <name-component> in [3]
base64-rdn               = BASE64-UTF8-STRING							
                           ; an rdn which has been base64 encoded (see	;base64编码的RDN
                           ; note 10, below)


control                  = "control:" FILL ldap-oid        ; controlType	控件的type
                           0*1(1*SPACE ("true" / "false")) ; criticality	是否一定要使用此控件来执行操作
                           0*1(value-spec)                 ; controlValue	控件 所需的附加信息
                           SEP
                           ; (See note 9, below)

ldap-oid                 = 1*DIGIT 0*1("." 1*DIGIT)						
                           ; An LDAPOID, as defined in [4]				;点分十进制的OID

attrval-spec             = AttributeDescription value-spec SEP			; 属性类型: 属性值 回车换行

value-spec               = ":" (    FILL 0*1(SAFE-STRING) /			;值为ASCII编码时
                                ":" FILL (BASE64-STRING) /			;值为base64编码时 需要两个":"
                                "<" FILL url)						;值为URL时
                           ; See notes 7 and 8, below

url                      = <a Uniform Resource Locator,					;URL
                            as defined in [6]>
                                   ; (See Note 6, below)

AttributeDescription     = AttributeType [";" options]					;属性描述
                           ; Definition taken from [4]

AttributeType            = ldap-oid / (ALPHA *(attr-type-chars))		;属性类型

options                  = option / (option ";" options)
option                   = 1*opt-char									; 1个或多个  字母/数字/"-"
attr-type-chars          = ALPHA / DIGIT / "-"							;字母/数字/"-"
opt-char                 = attr-type-chars								;字母/数字/"-"



changerecord             = "changetype:" FILL
                           (change-add / change-delete /
                            change-modify / change-moddn)
change-add               = "add"                SEP 1*attrval-spec	;add    属性和属性值
change-delete            = "delete"             SEP					;delete 属性和属性值
change-moddn             = ("modrdn" / "moddn") SEP
                            "newrdn:" (    FILL rdn /
                                       ":" FILL base64-rdn) SEP		;修改RDN
                            "deleteoldrdn:" FILL ("0" / "1")  SEP	;删除RDN
                            0*1("newsuperior:"						;修改 父级的DN，使得从属于新的父级
                            (    FILL distinguishedName /
                             ":" FILL base64-distinguishedName) SEP)
change-modify            = "modify"             SEP *mod-spec		;修改
mod-spec                 = ("add:" / "delete:" / "replace:")	; add
                           FILL AttributeDescription SEP
                           *attrval-spec
                           "-" SEP

SPACE                    = %x20							;空格
                           ; ASCII SP, space
FILL                     = *SPACE						;0个或多个空格


SEP                      = (CR LF / LF) 				;回车+换行 / 换行
CR                       = %x0D					
                           ; ASCII CR, carriage return	;回车
LF                       = %x0A					
                           ; ASCII LF, line feed		;换行


ALPHA                    = %x41-5A / %x61-7A			
                           ; A-Z / a-z					;A-Z / a-z

DIGIT                    = %x30-39					
                           ; 0-9						; 0-9

UTF8-1                   = %x80-BF
UTF8-2                   = %xC0-DF UTF8-1
UTF8-3                   = %xE0-EF 2UTF8-1
UTF8-4                   = %xF0-F7 3UTF8-1
UTF8-5                   = %xF8-FB 4UTF8-1
UTF8-6                   = %xFC-FD 5UTF8-1

SAFE-CHAR                = %x01-09 / %x0B-0C / %x0E-7F
                           ; any value <= 127 decimal except NUL, LF,
                           ; and CR
SAFE-INIT-CHAR           = %x01-09 / %x0B-0C / %x0E-1F /
                           %x21-39 / %x3B / %x3D-7F
                           ; any value <= 127 except NUL, LF, CR,
                           ; SPACE, colon (":", ASCII 58 decimal)
                           ; and less-than ("<" , ASCII 60 decimal)
SAFE-STRING              = [SAFE-INIT-CHAR *SAFE-CHAR]				; ASCII编码的字符


UTF8-CHAR                = SAFE-CHAR / UTF8-2 / UTF8-3 /
                           UTF8-4 / UTF8-5 / UTF8-6
UTF8-STRING              = *UTF8-CHAR


BASE64-UTF8-STRING       = BASE64-STRING
                           ; MUST be the base64 encoding of a
                           ; UTF8-STRING
BASE64-CHAR              = %x2B / %x2F / %x30-39 / %x3D / %x41-5A /
                           %x61-7A
                           ; +, /, 0-9, =, A-Z, and a-z
                           ; as specified in [5]
BASE64-STRING            = [*(BASE64-CHAR)]							;base64编码的字符
```



# 2. Notes on LDIF Syntax(LDIF语法-的说明)

- 1)  For the LDIF format described in this document, the version  number MUST be "1". If the version number is absent,  implementations MAY choose to interpret the contents as an  older LDIF file format, supported by the University of  Michigan ldap-3.3 implementation [8].
  <font color=green>对于本文档中描述的 LDIF格式，version-number**"必须"**为**"1"**。</font>
  <font color=green>如果version-number不存在，实现可以选择将内容解释为旧的 LDIF 文件格式</font>，由密歇根大学 ldap-3.3 实现 [8] 支持。
  
- 2)  Any non-empty line, including comment lines, in an LDIF file  MAY be folded by inserting a line separator (SEP) and a SPACE.  Folding MUST NOT occur before the first character of the line.  In other words, folding a line into two lines, the first of  which is empty, is not permitted. Any line that begins with a  single space MUST be treated as a continuation of the previous  (non-empty) line. When joining folded lines, exactly one space  character at the beginning of each continued line must be  discarded. Implementations SHOULD NOT fold lines in the middle  of a multi-byte UTF-8 character.
  <font color=blue>LDIF 文件中的  任何非空行，包括注释行，可以通过插入 行分隔符 (SEP) 和 空格 来折叠。</font>
  折叠不得出现在该行的第一个字符之前。换句话说，不允许将一行折叠成两行(其中第一行是空的)。
  <font color=blue>任何以单个空格开头的行都必须被视为前一个（非空）行的延续。</font>连接折叠线时，必须丢弃每条连续线开头的一个空格字符。
  <font color=blue>实现不应在 "多字节UTF-8字符"  的中间折叠行。</font>
  
- 3)  Any line that begins with a pound-sign ("#", ASCII 35) is a  comment line, and MUST be ignored when parsing an LDIF file.
<font color=green>任何以井号（“#”，ASCII 35）开头的行都是注释行，在解析 LDIF 文件时必须忽略。</font>

- 4)  Any dn or rdn that contains characters other than those  defined as "SAFE-UTF8-CHAR", or begins with a character other  than those defined as "SAFE-INIT-UTF8-CHAR", above, MUST be  base-64 encoded.  Other values MAY be base-64 encoded.  Any  value that contains characters other than those defined as  "SAFE-CHAR", or begins with a character other than those  defined as "SAFE-INIT-CHAR", above, MUST be base-64 encoded.  Other values MAY be base-64 encoded.
<font color=blue>任何dn或rdn 包含了"SAFE-UTF8-CHAR"以外的字符，或以"SAFE-UTF8-CHAR"以外的字符开头，必须是 base-64编码。</font>其他值可能是 base-64 编码的。
<font color=blue>任何  包含了"SAFE-CHAR"以外的字符的值，或以"SAFE-INIT-CHAR"以外的字符开头的值，都必须采用 base-64 编码。</font>其他值可能是 base-64 编码的。

- 5)  When a zero-length attribute value is to be included directly  in an LDIF file, it MUST be represented as  AttributeDescription ":" FILL SEP.  For example, "seeAlso:"  followed by a newline represents a zero-length "seeAlso"  attribute value.  It is also permissible for the value  referred to by a URL to be of zero length.
<font color=green>当0长度的  属性值 被直接包含在 LDIF 文件中时，它必须表示为 AttributeDescription ":" FILL(空格) SEP(换行)。</font>
例如，“seeAlso:”后跟 换行符 表示0长度的"seeAlso"属性值。 
URL引用  的值的长度为0  也是允许的。

- 6) When a URL is specified in an attrval-spec, the following  conventions apply:
当在 attrval-spec 中指定 URL 时，以下约定适用：
  - a) Implementations SHOULD support the file:// URL format.  The contents of the referenced file are to be included verbatim  in the interpreted output of the LDIF file.
  <font color=blue>实现"应该"支持 file:// URL 格式。</font>
  引用文件的内容  将逐字包含在  LDIF文件的解释输出中。

  - b) Implementations MAY support other URL formats.  The semantics associated with each supported URL will be documented in an associated Applicability Statement.
  <font color=blue>实现"可以"支持其他 URL 格式。</font>
  与每个支持的 URL 相关的语义  将记录在相关的适用性声明中。

- 7)  Distinguished names, relative distinguished names, and  attribute values of DirectoryString syntax MUST be valid UTF-8  strings.  Implementations that read LDIF MAY interpret files  in which these entities are stored in some other character set  encoding, but implementations MUST NOT generate LDIF content  which does not contain valid UTF-8 data.
<font color=green>DirectoryString语法的   DN、RDN和attribute-value   必须是有效的UTF-8字符串。</font>
读取LDIF的实现  可以解释   以其他字符集编码存储这些实体的文件，但实现不能生成    不包含有效UTF-8 数据的 LDIF内容。

- 8)  Values or distinguished names that end with SPACE SHOULD be  base-64 encoded.
<font color=blue>以 空格结尾 的value或DN  应该是 base-64 编码的。</font>

- 9)  When controls are included in an LDIF file, implementations MAY choose to ignore some or all of them. This may be necessary if the changes described in the LDIF file are being sent on an LDAPv2 connection (LDAPv2 does not support controls), or the particular controls are not supported by the remote server. If the criticality of a control is "true", then the implementation MUST either include the control, or MUST NOT send the operation to a remote server.
<font color=green>当controls/控件包含在 LDIF 文件中时，实现可以选择忽略其中的部分或全部。</font> 如果在 LDAPv2 连接上发送 LDIF 文件中描述的更改（LDAPv2 不支持控件），或者远程服务器不支持特定控件，则这可能是必要的。
<font color=green>如果控件的关键性为“true”，则实现必须包含该控件，或者不得将操作发送到远程服务器。</font>

- 10)  When an attrval-spec, distinguishedName, or rdn is base64-encoded, the encoding rules specified in [5] are used with the following exceptions:  a) The requirement that base64 output streams must be represented as lines of no more than 76 characters is removed. Lines in LDIF files may only be folded according to the folding rules described in note 2, above.  b) Base64 strings in [5] may contain characters other than those defined in BASE64-CHAR, and are ignored. LDIF does not permit  any extraneous characters, other than those used for line folding.
<font color=blue>当 attrval-spec、DN 或 RDN 是 base64 编码时，使用 [5] 中指定的编码规则，但以下例外： </font>
a)  <font color=blue>删除了    base64输出流必须表示为不超过了 76 个字符的行   的要求 。</font> LDIF 文件中的行只能根据上面注释 2 中描述的折叠规则进行折叠。 
b) [5] 中的 Base64 字符串可能包含 BASE64-CHAR 中定义的字符以外的字符，并被忽略。 <font color=blue>LDIF 不允许任何多余的字符，除了用于行折叠的字符。</font>





# 3. Examples of LDAP Data Interchange Format(LDIF的例子)



Example 1: An simple LDAP file with two entries
示例 1：具有两个条目/entry的简单 LDAP文件

```LDIF
version: 1
dn: cn=Barbara Jensen, ou=Product Development, dc=airius, dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
cn: Barbara Jensen
cn: Barbara J Jensen
cn: Babs Jensen
sn: Jensen
uid: bjensen
telephonenumber: +1 408 555 1212
description: A big sailing fan.

dn: cn=Bjorn Jensen, ou=Accounting, dc=airius, dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
cn: Bjorn Jensen
sn: Jensen
telephonenumber: +1 408 555 1212
```



Example 2: A file containing an entry with a folded attribute value
示例 2：包含  具有折叠属性值-的条目/entry   的文件

```LDIF
version: 1
dn:cn=Barbara Jensen, ou=Product Development, dc=airius, dc=com
objectclass:top
objectclass:person
objectclass:organizationalPerson
cn:Barbara Jensen
cn:Barbara J Jensen
cn:Babs Jensen
sn:Jensen
uid:bjensen
telephonenumber:+1 408 555 1212
description:Babs is a big sailing fan, and travels extensively in sea
 rch of perfect sailing conditions.
title:Product Manager, Rod and Reel Division
```



Example 3: A file containing a base-64-encoded value
示例 3：包含 base-64编码值   的文件

```LDIF
version: 1
dn: cn=Gern Jensen, ou=Product Testing, dc=airius, dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
cn: Gern Jensen
cn: Gern O Jensen
sn: Jensen
uid: gernj
telephonenumber: +1 408 555 1212
description:: V2hhdCBhIGNhcmVmdWwgcmVhZGVyIHlvdSBhcmUhICBUaGlzIHZhbHVl
IGlzIGJhc2UtNjQtZW5jb2RlZCBiZWNhdXNlIGl0IGhhcyBhIGNvbnRyb2wgY2hhcmFjdG
VyIGluIGl0IChhIENSKS4NICBCeSB0aGUgd2F5LCB5b3Ugc2hvdWxkIHJlYWxseSBnZXQg
b3V0IG1vcmUu
```



Example 4: A file containing an entries with UTF-8-encoded attribute values, including language tags.  Comments indicate the contents of UTF-8-encoded attributes and distinguished names.
示例 4：包含  具有UTF-8编码的属性值(包括语言标签)-的条目/entry   的文件。 
注释指示了   UTF-8 编码的attribute和DN的内容。

```LDIF
version: 1
dn:: b3U95Za25qWt6YOoLG89QWlyaXVz
# dn:: ou=<JapaneseOU>,o=Airius
objectclass: top
objectclass: organizationalUnit
ou:: 5Za25qWt6YOo
# ou:: <JapaneseOU>
ou;lang-ja:: 5Za25qWt6YOo
# ou;lang-ja:: <JapaneseOU>
ou;lang-ja;phonetic:: 44GI44GE44GO44KH44GG44G2
# ou;lang-ja:: <JapaneseOU_in_phonetic_representation>
ou;lang-en: Sales
description: Japanese office

dn:: dWlkPXJvZ2FzYXdhcmEsb3U95Za25qWt6YOoLG89QWlyaXVz
# dn:: uid=<uid>,ou=<JapaneseOU>,o=Airius
userpassword: {SHA}O3HSv1MusyL4kTjP+HKI5uxuNoM=
objectclass: top
objectclass: person
objectclass: organizationalPerson
objectclass: inetOrgPerson
uid: rogasawara
mail: rogasawara@airius.co.jp
givenname;lang-ja:: 44Ot44OJ44OL44O8
# givenname;lang-ja:: <JapaneseGivenname>
sn;lang-ja:: 5bCP56yg5Y6f
# sn;lang-ja:: <JapaneseSn>
cn;lang-ja:: 5bCP56yg5Y6fIOODreODieODi+ODvA==
# cn;lang-ja:: <JapaneseCn>
title;lang-ja:: 5Za25qWt6YOoIOmDqOmVtw==
# title;lang-ja:: <JapaneseTitle>
preferredlanguage: ja
givenname:: 44Ot44OJ44OL44O8
# givenname:: <JapaneseGivenname>
sn:: 5bCP56yg5Y6f
# sn:: <JapaneseSn>
cn:: 5bCP56yg5Y6fIOODreODieODi+ODvA==
# cn:: <JapaneseCn>
title:: 5Za25qWt6YOoIOmDqOmVtw==
# title:: <JapaneseTitle>
givenname;lang-ja;phonetic:: 44KN44Gp44Gr44O8
# givenname;lang-ja;phonetic::
<JapaneseGivenname_in_phonetic_representation_kana>
sn;lang-ja;phonetic:: 44GK44GM44GV44KP44KJ
# sn;lang-ja;phonetic:: <JapaneseSn_in_phonetic_representation_kana>
cn;lang-ja;phonetic:: 44GK44GM44GV44KP44KJIOOCjeOBqeOBq+ODvA==
# cn;lang-ja;phonetic:: <JapaneseCn_in_phonetic_representation_kana>
title;lang-ja;phonetic:: 44GI44GE44GO44KH44GG44G2IOOBtuOBoeOCh+OBhg==
# title;lang-ja;phonetic::
# <JapaneseTitle_in_phonetic_representation_kana>
givenname;lang-en: Rodney
sn;lang-en: Ogasawara
cn;lang-en: Rodney Ogasawara
title;lang-en: Sales, Director
```



Example 5: A file containing a reference to an external file
示例 5：包含  对外部文件的引用  的文件

```
version: 1
dn: cn=Horatio Jensen, ou=Product Testing, dc=airius, dc=com
objectclass: top
objectclass: person
objectclass: organizationalPerson
cn: Horatio Jensen

cn: Horatio N Jensen
sn: Jensen
uid: hjensen
telephonenumber: +1 408 555 1212
jpegphoto:< file:///usr/local/directory/photos/hjensen.jpg
```



Example 6: A file containing a series of change records and comments
示例 6：包含 一系列更改记录和注释  的文件

```
version: 1
# Add a new entry
dn: cn=Fiona Jensen, ou=Marketing, dc=airius, dc=com
changetype: add
objectclass: top
objectclass: person
objectclass: organizationalPerson
cn: Fiona Jensen
sn: Jensen
uid: fiona
telephonenumber: +1 408 555 1212
jpegphoto:< file:///usr/local/directory/photos/fiona.jpg

# Delete an existing entry
dn: cn=Robert Jensen, ou=Marketing, dc=airius, dc=com
changetype: delete

# Modify an entry's relative distinguished name
dn: cn=Paul Jensen, ou=Product Development, dc=airius, dc=com
changetype: modrdn
newrdn: cn=Paula Jensen
deleteoldrdn: 1

# Rename an entry and move all of its children to a new location in
# the directory tree (only implemented by LDAPv3 servers).
dn: ou=PD Accountants, ou=Product Development, dc=airius, dc=com
changetype: modrdn
newrdn: ou=Product Development Accountants
deleteoldrdn: 0
newsuperior: ou=Accounting, dc=airius, dc=com

# Modify an entry: add an additional value to the postaladdress
# attribute, completely delete the description attribute, replace
# the telephonenumber attribute with two values, and delete a specific
# value from the facsimiletelephonenumber attribute
dn: cn=Paula Jensen, ou=Product Development, dc=airius, dc=com
changetype: modify
add: postaladdress
postaladdress: 123 Anystreet $ Sunnyvale, CA $ 94086
-

delete: description
-
replace: telephonenumber
telephonenumber: +1 408 555 1234
telephonenumber: +1 408 555 5678
-
delete: facsimiletelephonenumber
facsimiletelephonenumber: +1 408 555 9876
-

# Modify an entry: replace the postaladdress attribute with an empty
# set of values (which will cause the attribute to be removed), and
# delete the entire description attribute. Note that the first will
# always succeed, while the second will only succeed if at least
# one value for the description attribute is present.
dn: cn=Ingrid Jensen, ou=Product Support, dc=airius, dc=com
changetype: modify
replace: postaladdress
-
delete: description
-
```



Example 7: An LDIF file containing a change record with a control
示例 7：包含  带有-控件/control-的更改记录  的LDIF文件

```
version: 1
# Delete an entry. The operation will attach the LDAPv3
# Tree Delete Control defined in [9]. The criticality
# field is "true" and the controlValue field is
# absent, as required by [9].
dn: ou=Product Development, dc=airius, dc=com
control: 1.2.840.113556.1.4.805 true
changetype: delete
```





# Security Considerations(安全注意事项)

Given typical directory applications, an LDIF file is likely to contain sensitive personal data.  Appropriate measures should be taken to protect the privacy of those persons whose data is contained in an LDIF file.
对于典型的目录应用程序，LDIF 文件很可能包含敏感的个人数据。 
应采取适当措施  保护   数据包含在LDIF文件中的  人员的隐私。

Since ":<" directives can cause external content to be included when processing an LDIF file, one should be cautious of accepting LDIF files from external sources.  A "trojan" LDIF file could name a file with sensitive contents and cause it to be included in a directory entry, which a hostile entity could read via LDAP.
<font color=red>由于":<"指令会导致在处理 LDIF 文件时包含外部内容，因此应谨慎接受来自外部来源的 LDIF 文件。 </font>
“特洛伊木马”LDIF 文件可以命名一个包含敏感内容的文件，并将其包含在目录条目中，恶意实体可以通过 LDAP 读取该条目。

LDIF does not provide any method for carrying authentication information with an LDIF file.  Users of LDIF files must take care to verify the integrity of an LDIF file received from an external source.
<font color=blue>LDIF 不提供任何使用 LDIF文件 携带身份验证信息的方法。 </font>
<font color=blue>LDIF 文件的用户必须注意验证从外部源接收的 LDIF 文件的完整性。</font>



# Acknowledgments(致谢.略)

   The LDAP Interchange Format was developed as part of the University of Michigan LDAP reference implementation, and was developed by Tim
   Howes, Mark Smith, and Gordon Good.  It is based in part upon work supported by the National Science Foundation under Grant No.  NCR-9416667.

   Members of the IETF LDAP Extensions Working group provided many helpful suggestions. In particular, Hallvard B. Furuseth of the University of Oslo made many significant contributions to this document, including a thorough review and rewrite of the BNF.

# References(参考)

   [1]  Howes, T. and M. Smith, "A MIME Content-Type for Directory
        Information", RFC 2425, September 1998.

   [2]  Crocker, D., and P. Overell, "Augmented BNF for Syntax
        Specifications: ABNF", RFC 2234, November 1997.

   [3]  Wahl, M., Kille, S. and T. Howes, "A String Representation of
        Distinguished Names", RFC 2253, December 1997.

   [4]  Wahl, M., Howes, T. and S. Kille, "Lightweight Directory Access
        Protocol (v3)", RFC 2251, July 1997.

   [5]  Freed, N. and N. Borenstein, "Multipurpose Internet Mail
        Extensions (MIME) Part One: Format of Internet Message Bodies",
        RFC 2045, November 1996.



Good                        Standards Track                    [Page 12]

RFC 2849              LDAP Data Interchange Format             June 2000


   [6]  Berners-Lee,  T., Masinter, L. and M. McCahill, "Uniform
        Resource Locators (URL)", RFC 1738, December 1994.

   [7]  Bradner, S., "Key Words for use in RFCs to Indicate Requirement
        Levels", BCP 14, RFC 2119, March 1997.

   [8]  The SLAPD and SLURPD Administrators Guide.  University of
        Michigan, April 1996.  <URL:
        http://www.umich.edu/~dirsvcs/ldap/doc/guides/slapd/toc.html>

   [9]  M. P. Armijo, "Tree Delete Control", Work in Progress.

# Author's Address(略)

   Gordon Good
   iPlanet e-commerce Solutions
   150 Network Circle
   Mailstop USCA17-201
   Santa Clara, CA 95054, USA

   Phone: +1 408 276 4351
   EMail:  ggood@netscape.com





























Good                        Standards Track                    [Page 13]

RFC 2849              LDAP Data Interchange Format             June 2000


Full Copyright Statement

   Copyright (C) The Internet Society (2000).  All Rights Reserved.

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

Acknowledgement

   Funding for the RFC Editor function is currently provided by the
   Internet Society.



















Good                        Standards Track                    [Page 14]

