





Network Working Group                                        K. Zeilenga
Request for Comments: 4526                           OpenLDAP Foundation
Category: Standards Track                                      June 2006


# Lightweight Directory Access Protocol (LDAP) Absolute True and False Filters

## Status of This Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice

   Copyright (C) The Internet Society (2006).

# Abstract(摘要)

This document extends the Lightweight Directory Access Protocol (LDAP) to support absolute True and False filters based upon similar capabilities found in X.500 directory systems.  The document also extends the String Representation of LDAP Search Filters to support these filters.
本文扩展了轻量级目录访问协议(LDAP)，以支持基于X.500目录系统中类似功能的绝对True和False filter。
本文档还扩展了LDAP-search-filter的字符串表示   以支持这些filter。


```
Table of Contents
   1. Background ......................................................1
   2. Absolute True and False Filters .................................2
   3. Security Considerations .........................................2
   4. IANA Considerations .............................................3
   5. References ......................................................3
      5.1. Normative References .......................................3
      5.2. Informative References .....................................3
```

# 1.  Background

The X.500 Directory Access Protocol (DAP) [X.511] supports absolute True and False assertions.  An 'and' filter with zero elements always evaluates to True.  An 'or' filter with zero elements always evaluates to False.  These filters are commonly used when requesting DSA-specific Entries (DSEs) that do not necessarily have 'objectClass' attributes; that is, where "(objectClass=*)" may    evaluate to False.
X.5005目录访问协议(DAP) [X.511]支持： 绝对的true和false  assertion/断言。
带有零元素的'and'-fliter的计算结果总是True。
带有零元素的'or'-filter的计算结果总是为False。
这些filter通常用于请求：不一定具有'objectClass'属性的DSA-specific Entries (DSEs)时; 
也就是说，"(objectClass=*)"可能评估为False。


Although LDAPv2 [RFC1777][RFC3494] placed no restriction on the number of elements in 'and' and 'or' filter sets, the LDAPv2 string representation [RFC1960][RFC3494] could not represent empty 'and' and 'or' filter sets.  Due to this, absolute True or False filters were (unfortunately) eliminated from LDAPv3 [RFC4510].
虽然LDAPv2 [RFC1777][RFC3494]没有限制过滤集合中元素的数量，但是LDAPv2字符串表示[RFC1960][RFC3494]不能表示空的'and' and' or'过滤集合。
因此，LDAPv3 [RFC4510]中消除了绝对真或假过滤器。

This documents extends LDAPv3 to support absolute True and False assertions by allowing empty 'and' and 'or' in Search filters [RFC4511] and extends the filter string representation [RFC4515] to allow empty filter lists.
本文档扩展了LDAPv3，允许在搜索过滤器中使用空的'and'和'or'来支持绝对的True和False断言[RFC4511]，
并扩展了过滤器字符串表示[RFC4515]来允许空的过滤器列表。

It is noted that certain search operations, such as those used to retrieve subschema information [RFC4512], require use of particular filters.  This document does not change these requirements.
需要注意的是，某些搜索操作，比如用于检索子模式信息的操作[RFC4512]，需要使用特定的过滤器。本文档不修改这些要求。

This feature is intended to allow a more direct mapping between DAP and LDAP (as needed to implement DAP-to-LDAP gateways).
这个特性的目的是允许DAP和LDAP之间更直接的映射(根据需要实现DAP到LDAP网关)。

In this document, the key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in BCP 14 [RFC2119].
在本文件中，关键字"MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"应按照BCP 14 [RFC2119]中的描述进行解释。



# 2.  Absolute True and False Filters

Implementations of this extension SHALL allow 'and' and 'or' choices with zero filter elements.
这个扩展的实现应该允许'和'和'或'选择零过滤器元素。

An 'and' filter consisting of an empty set of filters SHALL evaluate to True.  This filter is represented by the string "(&)".
由一组空过滤器组成的'and'过滤器的值为True。这个过滤器由字符串“(&)”表示。

An 'or' filter consisting of an empty set of filters SHALL evaluate to False.  This filter is represented by the string "(|)".
由一组空过滤器组成的or过滤器的值为False。这个过滤器由字符串"(|)"表示。

Servers supporting this feature SHOULD publish the Object Identifier 1.3.6.1.4.1.4203.1.5.3 as a value of the 'supportedFeatures' [RFC4512] attribute in the root DSE.
支持该特性的服务器应该将对象标识符1.3.6.1.4.1.4203.1.5.3作为'supportedFeatures' [RFC4512]属性的值发布到根DSE中。

Clients supporting this feature SHOULD NOT use the feature unless they know that the server supports it.
支持此特性的客户不应该使用该特性，除非他们知道服务器支持它。



# 3.  Security Considerations

The (re)introduction of absolute True and False filters is not believed to raise any new security considerations.
我们认为(重新)引入绝对真假过滤器不会引起任何新的安全考虑。

Implementors of this (or any) LDAPv3 extension should be familiar with general LDAPv3 security considerations [RFC4510].
这个(或任何)LDAPv3扩展的实现者应该熟悉一般的LDAPv3安全注意事项[RFC4510]。



# 4.  IANA Considerations

Registration of this feature has been completed by the IANA [RFC4520].
该功能的注册已由IANA完成[RFC4520]。

   Subject: Request for LDAP Protocol Mechanism Registration Object
   Identifier: 1.3.6.1.4.1.4203.1.5.3 
   Description: True/False filters
   Person & email address to contact for further information:
        Kurt Zeilenga <kurt@openldap.org> Usage: Feature Specification:
   RFC 4526 Author/Change Controller: IESG Comments: none
主题:请求LDAP协议机制注册对象

标识符:1.3.6.1.4.1.4203.1.5.3

描述:真/假过滤器

联系人及电子邮件地址:

Kurt Zeilenga

RFC 4526 Author/Change Controller: IESG注释:无

This OID was assigned [ASSIGN] by OpenLDAP Foundation, under its IANA-assigned private enterprise allocation [PRIVATE], for use in this specification.
OpenLDAP基金会在其iana分配的私有企业分配[private]下分配[ASSIGN]这个OID用于本规范。



# 5.  References

## 5.1.  Normative References

   [RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate
                 Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC4510]     Zeilenga, K., Ed, "Lightweight Directory Access
                 Protocol (LDAP): Technical Specification Road Map", RFC
                 4510, June 2006.

   [RFC4511]     Sermersheim, J., Ed., "Lightweight Directory Access
                 Protocol (LDAP): The Protocol", RFC 4511, June 2006.

   [RFC4512]     Zeilenga, K., "Lightweight Directory Access Protocol
                 (LDAP): Directory Information Models", RFC 4512, June
                 2006.

   [RFC4515]     Smith, M., Ed. and T. Howes, "Lightweight Directory
                 Access Protocol (LDAP): String Representation of Search
                 Filters", RFC 4515, June 2006.

## 5.2.  Informative References

   [RFC1777]     Yeong, W., Howes, T., and S. Kille, "Lightweight
                 Directory Access Protocol", RFC 1777, March 1995.

   [RFC1960]     Howes, T., "A String Representation of LDAP Search
                 Filters", RFC 1960, June 1996.

   [RFC3494]     Zeilenga, K., "Lightweight Directory Access Protocol
                 version 2 (LDAPv2) to Historic Status", RFC 3494, March
                 2003.



Zeilenga                    Standards Track                     [Page 3]

RFC 4526          LDAP Absolute True and False Filters         June 2006


   [RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority
                 (IANA) Considerations for the Lightweight Directory
                 Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

   [X.500]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Overview of concepts, models and
                 services," X.500(1993) (also ISO/IEC 9594-1:1994).

   [X.501]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Models," X.501(1993) (also ISO/IEC 9594-
                 2:1994).

   [X.511]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory: Abstract Service Definition", X.511(1993)
                 (also ISO/IEC 9594-3:1993).

   [ASSIGN]      OpenLDAP Foundation, "OpenLDAP OID Delegations",
                 http://www.openldap.org/foundation/oid-delegate.txt.

   [PRIVATE]     IANA, "Private Enterprise Numbers",
                 http://www.iana.org/assignments/enterprise-numbers.

# Author's Address

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org




















Zeilenga                    Standards Track                     [Page 4]

RFC 4526          LDAP Absolute True and False Filters         June 2006


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







Zeilenga                    Standards Track                     [Page 5]

