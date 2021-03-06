





Network Working Group                                   K. Zeilenga, Ed.
Request for Comments: 4510                           OpenLDAP Foundation
Obsoletes: 2251, 2252, 2253, 2254, 2255,                       June 2006
           2256, 2829, 2830, 3377, 3771
Category: Standards Track

# Lightweight Directory Access Protocol (LDAP): Technical Specification Road Map(LDAP技术规范的路线)

## Status of This Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice

   Copyright (C) The Internet Society (2006).

## Abstract(摘要)

The Lightweight Directory Access Protocol (LDAP) is an Internet protocol for accessing distributed directory services that act in accordance with X.500 data and service models.  This document provides a road map of the LDAP Technical Specification.
轻量级目录访问协议(LDAP)是一种Internet协议，用于访问 按照X.500数据和服务模型运行的 分布式目录服务。
<font color=red>本文档提供了LDAP技术规范的实现思路。</font>
         

# 1. The LDAP Technical Specification

The technical specification detailing version 3 of the Lightweight Directory Access Protocol (LDAP), an Internet Protocol, consists of this document and the following documents:
详细介绍 轻量级目录访问协议(LDAP)版本3 的技术规范，一种 Internet 协议，
由本文档和以下文档组成：

```txt
  LDAP: The Protocol [RFC4511]                                   协议
  LDAP: Directory Information Models [RFC4512]                   目录信息模型
  LDAP: Authentication Methods and Security Mechanisms [RFC4513] 身份验证方法和安全机制
  LDAP: String Representation of Distinguished Names [RFC4514]   DN的字符串表示
  LDAP: String Representation of Search Filters [RFC4515]        搜索过滤器的字符串表示
  LDAP: Uniform Resource Locator [RFC4516]                       统一资源定位器
  LDAP: Syntaxes and Matching Rules [RFC4517]                    语法和匹配规则
  LDAP: Internationalized String Preparation [RFC4518]           国际化字符串准备
  LDAP: Schema for User Applications [RFC4519]                   用户应用程序架构/schema   
```

The terms "LDAP" and "LDAPv3" are commonly used to refer informally to the protocol specified by this technical specification.  The LDAP suite, as defined here, should be formally identified in other documents by a normative reference to this document.
术语"LDAP"和"LDAPv3"通常用于 非正式地指代/指定 本技术规范 指定的协议。 
此处定义的LDAP套件 ，应通过对本文档的规范性引用 ，在其他文档中正式标识(此处定义的LDAP套件)。
         
LDAP is an extensible protocol.  Extensions to LDAP may be specified in other documents.  Nomenclature denoting such combinations of LDAP-plus-extensions is not defined by this document but may be defined in some future document(s).  Extensions are expected to be truly optional.  Considerations for the LDAP extensions described in BCP 118, RFC 4521 [RFC4521] fully apply to this revision of the LDAP Technical Specification.
<font color=green>LDAP 是一种可扩展的协议。</font> 
LDAP的扩展可能在其他文档中指定。 
本文档未定义/指定 表示此类 "LDAP-plus-extensions"组合的 命名法，但可能会在某些未来的文档中定义。 
预计扩展是真正可选的。 
BCP118,RFC4521[RFC4521]中描述的LDAP扩展的注意事项   完全适用于 LDAP 技术规范的此修订版。

IANA (Internet Assigned Numbers Authority) considerations for LDAP described in BCP 64, RFC 4520 [RFC4520] apply fully to this revision of the LDAP technical specification.
BCP 64、RFC 4520 [RFC4520] 中描述的 IANA（互联网号码分配机构）
对LDAP的考虑 完全适用于LDAP技术规范的这一修订版。



## 1.1.  Conventions(约定)

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].
本文档中的关键词 "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"是按照 BCP14[RFC2119]中的描述进行解释的。
      

# 2. Relationship to X.500(与X.500的关系)

This technical specification defines LDAP in terms of [X.500] as an X.500 access mechanism.  An LDAP server MUST act in  accordance with the X.500 (1993) series of International Telecommunication Union - Telecommunication Standardization (ITU-T) Recommendations when providing the service.  However, it is not required that an LDAP server make use of any X.500 protocols in providing this service. For example, LDAP can be mapped onto any other directory system so long as the X.500 data and service models [X.501][X.511], as used in LDAP, are not violated in the LDAP interface.
该技术规范  根据[X.500]   将LDAP  定义为 一个X.500访问机制。 
LDAP-server 在提供服务时必须按照  国际电信联盟-电信标准化(ITU-T)   建议的X.500(1993)系列进行操作。 
但是，LDAP-server 在提供此服务时不需要使用任何 X.500协议。 
例如，
	<font color=blue>只要 LDAP中使用的 X.500数据和服务模型[X.501][X.511] ，不违反  LDAP接口，LDAP 就可以映射到任何其他目录系统。</font>

This technical specification explicitly incorporates portions of X.500(93).  Later revisions of X.500 do not automatically apply to this technical specification.
该技术规范明确包含 X.500(93) 的某些部分。 
X.500的更高版本不会自动应用于此技术规范。


​         

# 3. Relationship to Obsolete Specifications(与过时规范的关系)

This technical specification, as defined in Section 1, obsoletes entirely the previously defined LDAP technical specification defined
in RFC 3377 (and consisting of RFCs 2251-2256, 2829, 2830, 3771, and 3377 itself).  The technical specification was significantly
reorganized.
如第1节中所定义，该技术规范完全废除了RFC3377（由RFC 2251-2256、2829、2830、3771和3377本身组成）中先前定义的LDAP技术规范。 
对技术规范进行了重大重组。
         
This document replaces RFC 3377 as well as Section 3.3 of RFC 2251. 
[RFC4512] replaces portions of RFC 2251, RFC 2252, and RFC 2256. 
[RFC4511] replaces the majority RFC 2251, portions of RFC 2252, and all of RFC 3771.
[RFC4513] replaces RFC 2829, RFC 2830, and portions of RFC 2251. 
[RFC4517] replaces the majority of RFC 2252 and portions of RFC 2256. 
[RFC4519] replaces the majority of RFC 2256.
[RFC4514] replaces RFC 2253. 
[RFC4515] replaces RFC 2254. 
[RFC4516] replaces RFC 2255.
   本文档替换 RFC3377 以及RFC2251的第3.3节。
   [RFC4512] 替换了 RFC 2251、RFC 2252 和 RFC 2256 的部分内容。
   [RFC4511] 替换了大部分 RFC 2251、部分 RFC 2252 和 RFC 2252 的所有部分。 
   [RFC4513] 替换了 RFC 2829、RFC 2830 和 RFC 2251 的部分。
   [RFC4517] 替换了大部分 RFC 2252 和部分 RFC 2256。
   [RFC4519] 替换了大部分 RFC 2256。
   [RFC4514] 替换了 RFC 2515。 ] 替换 RFC 2254。 
   [RFC4516] 替换 RFC 2255。

[RFC4518] is new to this revision of the LDAP technical specification.
<font color=green>**[RFC4518] 是 LDAP 技术规范修订版的新增内容。**</font>

Each document of this specification contains appendices summarizing changes to all sections of the specifications they replace.  Appendix A.1 of this document details changes made to RFC 3377.  Appendix A.2 of this document details changes made to Section 3.3 of RFC 2251.
本规范的每个文档都包含附录，总结了对它们所取代的规范的所有部分的更改。 
本文档的附录 A.1 详细介绍了对 RFC 3377 所做的更改。
本文档的附录 A.2 详细介绍了对 RFC 2251 的第 3.3 节所做的更改。

Additionally, portions of this technical specification update and/or replace a number of other documents not listed above.  These   relationships are discussed in the documents detailing these portions of this technical specification.
另外，本技术规范的某些部分 会更新和/或替换 上面未列出的许多其他文档。 
这些关系在 详细说明本技术规范的这些部分的文件中 进行了讨论。


​      
# 4. Security Considerations

LDAP security considerations are discussed in each document comprising the technical specification.
在组成技术规范的每个文档中都讨论了LDAP安全注意事项。



# 5. Acknowledgements(致谢.略)

This document is based largely on RFC 3377 by J. Hodges and R. Morgan, a product of the LDAPBIS and LDAPEXT Working Groups.  The document also borrows from RFC 2251 by M. Wahl, T. Howes, and S. Kille, a product of the ASID Working Group.

This document is a product of the IETF LDAPBIS Working Group.



# 6. Normative References(规范参考)

[RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, March 1997.
用于RFC中的关键字/KeyWords，以指示需求级别

[RFC4511]     Sermersheim, J., Ed., "Lightweight Directory Access Protocol (LDAP): The Protocol", RFC 4511, June 2006.
轻量级目录访问协议(LDAP): 协议

[RFC4512]     Zeilenga, K., "Lightweight Directory Access Protocol (LDAP): Directory Information Models", RFC 4512, June 2006.
轻量级目录访问协议(LDAP): 目录信息模型

[RFC4513]     Harrison, R., Ed., "Lightweight Directory Access Protocol (LDAP): Authentication Methods and Security Mechanisms", RFC 4513, June 2006.
轻量级目录访问协议(LDAP): 身份验证方法和安全机制

[RFC4514]     Zeilenga, K., Ed., "Lightweight Directory Access Protocol (LDAP): String Representation of Distinguished Names", RFC 4514, June 2006.
轻量级目录访问协议(LDAP): DN的字符串表示

[RFC4515]     Smith, M., Ed. and T. Howes, "Lightweight Directory Access Protocol (LDAP): String Representation of Search Filters", RFC 4515, June 2006.
轻量级目录访问协议(LDAP): 搜索过滤器的字符串表示

[RFC4516]     Smith, M., Ed. and T. Howes, "Lightweight Directory Access Protocol (LDAP): Uniform Resource Locator", RFC 4516, June 2006.
轻量级目录访问协议(LDAP): 统一资源定位器

[RFC4517]     Legg, S., Ed., "Lightweight Directory Access Protocol (LDAP): Syntaxes and Matching Rules", RFC 4517, June 2006.
轻量级目录访问协议(LDAP): 语法和匹配规则

[RFC4518]     Zeilenga, K., "Lightweight Directory Access Protocol (LDAP): Internationalized String Preparation", RFC4518, June 2006.
轻量级目录访问协议(LDAP): 国际化字符串准备

[RFC4519]     Sciberras, A., Ed., "Lightweight Directory Access Protocol (LDAP): Schema for User Applications", RFC4519, June 2006.
轻量级目录访问协议(LDAP): 用户应用程序架构/schema

[RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority(IANA) Considerations for the Lightweight Directory Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.
 因特网号码分配机构(IANA) 关于 轻量级目录访问协议(LDAP) 的考虑

[RFC4521]     Zeilenga, K., "Considerations for LDAP Extensions", BCP118, RFC 4521, June 2006.
关于LDAP扩展的考虑

[X.500]       International Telecommunication Union - Telecommunication Standardization Sector, "The Directory -- Overview of concepts, models and services", X.500(1993) (also ISO/IEC 9594-1:1994).
国际电信联盟-电信标准化部门， “目录 -- 概念、模型和服务概述”， X.500(1993)（还有 ISO/IEC 9594-1:1994）。

[X.501]       International Telecommunication Union - Telecommunication Standardization Sector, "The Directory -- Models", X.501(1993) (also ISO/IEC 9594-2:1994).
国际电信联盟-电信标准化部门， “目录 -- 模型”， X.501(1993)（还有 ISO/IEC 9594-2:1994）。

[X.511]       International Telecommunication Union - Telecommunication Standardization Sector, "The Directory: Abstract Service Definition", X.511(1993) (also ISO/IEC 9594-3:1993).
国际电信联盟-电信标准化部门， “目录：抽象服务定义”，X.511(1993)（还有 ISO/IEC 9594-3:1993）。



# Appendix A.  Changes to Previous Documents(对以前文档的更改)

This appendix outlines changes this document makes relative to the documents it replaces (in whole or in part).
本附录概述了    本文档相对于它所替换的文档（全部或部分） 所做的更改。
            

## A.1. Changes to RFC 3377

This document is nearly a complete rewrite of RFC 3377 as much of the material of RFC 3377 is no longer applicable.  The changes include redefining the terms "LDAP" and "LDAPv3" to refer to this revision of the technical specification.
该文档几乎是对RFC 3377的完全重写，因为RFC 3377的许多内容已不再适用。 
更改包括重新定义术语“LDAP”和“LDAPv3”以指代技术规范的此修订版。

## A.2. Changes to Section 3.3 of RFC 2251

The section was modified slightly (the word "document" was replaced with "technical specification") to clarify that it applies to the entire LDAP technical specification.
<font color=blue>该部分略有修改（“document/文档”一词被替换为“technical specification/技术规范”） 以阐明它适用于整个 LDAP 技术规范。</font>
         

# Author's Address

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org



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

# Acknowledgement

   Funding for the RFC Editor function is provided by the IETF Administrative Support Activity (IASA).







Zeilenga                    Standards Track                     [Page 7]

