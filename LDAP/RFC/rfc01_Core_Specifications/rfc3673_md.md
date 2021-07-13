





Network Working Group                                        K. Zeilenga
Request for Comments: 3673                           OpenLDAP Foundation
Category: Standards Track                                  December 2003

# Lightweight Directory Access Protocol version 3 (LDAPv3): All Operational Attributes

## Status of this Memo(略)

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice(略)

   Copyright (C) The Internet Society (2003).  All Rights Reserved.



# Abstract(摘要)

The Lightweight Directory Access Protocol (LDAP) supports a mechanism for requesting the return of all user attributes but not all operational attributes.  This document describes an LDAP extension which clients may use to request the return of all operational attributes.
<font color=blue>轻量级目录访问协议(LDAP) 支持  请求返回： 所有用户属性/user-attribute  但不是 所有操作属性/operational-attribute 的机制。</font> 
<font color=blue>本文档描述了 client可用于请求返回 所有操作属性/operational-attribute 的LDAP-extension/扩展。</font>



# 1. Overview(概述)

X.500 [X.500] provides a mechanism for clients to request all operational attributes be returned with entries provided in response to a search operation.  This mechanism is often used by clients to discover which operational attributes are present in an entry.
X.500[X.500]提供了一种机制：让client请求返回所有操作属性/operational-attribute 并在响应搜索操作/search-operation时提供条目/entry。 
<font color=blue>client通常使用此机制来发现entry中存在哪些操作属性/operational-attribute。</font>

This documents extends the Lightweight Directory Access Protocol (LDAP) [RFC3377] to provide a simple mechanism which clients may use to request the return of all operational attributes.  The mechanism is designed for use with existing general purpose LDAP clients (including web browsers which support LDAP URLs) and existing LDAP APIs.
本文档扩展了轻量级目录访问协议 (LDAP) [RFC3377]，以<font color=blue>提供一种简单的机制，client可以使用该机制来请求返回所有操作属性/operational-attribute。 </font>
该机制<font color=blue>旨在与   现有的通用 LDAP client（包括支持 LDAP URL 的 Web 浏览器）和现有的 LDAP API 一起使用。</font>

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].
本文档中的关键词"MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"是 按照 BCP 14 [RFC2119] 中的描述进行解释。



# 2. All Operational Attributes(所有 操作-属性)

The presence of the attribute description "+" (ASCII 43) in the list of attributes in a Search Request [RFC2251] SHALL signify a request for the return of all operational attributes.
<font color=blue>**在search-request[RFC2251]中的attribute-list中  出现attribute-description "+" (ASCII 43)  应表示请求返回所有操作属性/operational-attribute。**</font>

As with all search requests, client implementors should note that results may not include all requested attributes due to access controls or other restrictions.  Client implementors should also note that certain operational attributes may be returned only if requested by name even when "+" is present.  This is because some operational attributes are very expensive to return.
与所有搜索请求一样，客户端实现者应注意，<font color=blue>由于访问控制或其他限制，结果可能不包括所有请求的属性。 </font>
客户端实现者还应注意，<font color=blue>即使存在"+" ，也可能仅在按名称/name请求时才返回某些操作属性/operational-attribute。 </font>
这是因为某些操作属性的返回成本/代价非常高。

Servers supporting this feature SHOULD publish the Object Identifier 1.3.6.1.4.1.4203.1.5.1 as a value of the 'supportedFeatures' [RFC3674] attribute in the root DSE.
<font color=blue>支持此功能的服务器/server，应该发布  OID   1.3.6.1.4.1.4203.1.5.1 作为根 DSE 中'supportedFeatures'[RFC3674] 属性的值。</font>



# 3. Interoperability Considerations(互操作性的考虑)

This mechanism is specifically designed to allow users to request all operational attributes using existing LDAP clients.  In particular, the mechanism is designed to be compatible with existing general purpose LDAP clients including those supporting LDAP URLs [RFC2255].
此机制专门设计用于    允许用户使用现有 LDAP-client  请求所有操作属性/operational-attribute。 
特别是，该机制旨在与现有的通用 LDAP-client兼容，包括那些支持 LDAP-URL 的client [RFC2255]。

The addition of this mechanism to LDAP is not believed to cause any significant interoperability issues (this has been confirmed through testing).  Servers which have yet to implement this specification should ignore the "+" as an unrecognized attribute description per [RFC2251, Section 4.5.1].  From the client's perspective, a server which does not return all operational attributes when "+" is requested should be viewed as having other restrictions.
认为将此机制添加到 LDAP 不会导致任何重大的互操作性问题（这已通过测试确认）。 
尚未实现该规范的<font color=blue>server应该忽略RFC2251章节4.5.1中  未识别的attribute-description中的"+"。 </font>
<font color=blue>从client的角度来看，当请求"+"时不返回所有操作属性的服务器应该被视为具有其他限制。</font>

It is also noted that this mechanism is believed to require no modification of existing LDAP APIs.
<font color=blue>还要注意的是，这种机制被认为不需要修改现有的 LDAP-API。</font>



# 4. Security Considerations(安全性考虑)

This document provides a general mechanism which clients may use to discover operational attributes.  Prior to the introduction of this mechanism, operational attributes were only returned when requested by name.  Some might have viewed this as obscurity feature.  However, this feature offers a false sense of security as the attributes were still transferable.
<font color=blue>本文档提供了client可用于发现operational-attribute的通用机制。 </font>
<font color=blue>在引入此机制之前，仅在按名称/name请求时才返回操作属性/operational-attribute。 </font>
有些人可能将其视为晦涩的功能。 
<font color=blue>但是，此功能提供了一种虚假的安全感，因为属性仍然是可转移的。</font>

Implementations SHOULD implement appropriate access controls mechanisms to restricts access to operational attributes.
实现   <font color=blue>应该实现适当的访问控制机制   来限制对操作属性/operational-attribute的访问。</font>




# 5. IANA Considerations(略)

This document uses the OID 1.3.6.1.4.1.4203.1.5.1 to identify the feature described above.  This OID was assigned [ASSIGN] by OpenLDAP Foundation, under its IANA-assigned private enterprise allocation [PRIVATE], for use in this specification.
本文档使用 OID 1.3.6.1.4.1.4203.1.5.1 来标识上述功能。 
该 OID 由 OpenLDAP 基金会根据其 IANA 分配的私有企业分配 [PRIVATE] 分配 [ASSIGN]，用于本规范。

Registration of this feature has been completed by IANA [RFC3674], [RFC3383].
此功能的注册已由 IANA [RFC3674]、[RFC3383] 完成。

```
   Subject: Request for LDAP Protocol Mechanism Registration

   Object Identifier: 1.3.6.1.4.1.4203.1.5.1

   Description: All Op Attrs

   Person & email address to contact for further information:
        Kurt Zeilenga <kurt@openldap.org>

   Usage: Feature

   Specification: RFC3673

   Author/Change Controller: IESG

   Comments: none
```

# 6. Acknowledgment(略)

   The "+" mechanism is believed to have been first suggested by Bruce
   Greenblatt in a November 1998 post to the IETF LDAPext Working Group
   mailing list.

# 7. Intellectual Property Statement(略)

   The IETF takes no position regarding the validity or scope of any
   intellectual property or other rights that might be claimed to
   pertain to the implementation or use of the technology described in
   this document or the extent to which any license under such rights
   might or might not be available; neither does it represent that it
   has made any effort to identify any such rights.  Information on the
   IETF's procedures with respect to rights in standards-track and
   standards-related documentation can be found in BCP-11.  Copies of
   claims of rights made available for publication and any assurances of
   licenses to be made available, or the result of an attempt made to
   obtain a general license or permission for the use of such
   proprietary rights by implementors or users of this specification can
   be obtained from the IETF Secretariat.



Zeilenga                    Standards Track                     [Page 3]

RFC 3673           LDAPv3: All Operational Attributes      December 2003


   The IETF invites any interested party to bring to its attention any
   copyrights, patents or patent applications, or other proprietary
   rights which may cover technology that may be required to practice
   this standard.  Please address the information to the IETF Executive
   Director.

# 8. References(略)

8.1.  Normative References

   [RFC2119]  Bradner, S., "Key words for use in RFCs to Indicate
              Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC2251]  Wahl, M., Howes, T. and S. Kille, "Lightweight Directory
              Access Protocol (v3)", RFC 2251, December 1997.

   [RFC3377]  Hodges, J. and R. Morgan, "Lightweight Directory Access
              Protocol (v3): Technical Specification", RFC 3377,
              September 2002.

   [RFC3674]  Zeilenga, K., "Feature Discovery in Lightweight Directory
              Access Protocol (LDAP)", RFC 3674, December 2003.

8.2.  Informative References

   [RFC2255]  Howes, T. and M. Smith, "The LDAP URL Format", RFC 2255,
              December 1997.

   [RFC3383]  Zeilenga, K., "Internet Assigned Numbers Authority (IANA)
              Considerations for the Lightweight Directory Access
              Protocol (LDAP)", BCP 64, RFC 3383, September 2002.

   [X.500]    ITU-T Rec.  X.500, "The Directory: Overview of Concepts,
              Models and Service", 1993.

   [ASSIGN]   OpenLDAP Foundation, "OpenLDAP OID Delegations",
              http://www.openldap.org/foundation/oid-delegate.txt.

   [PRIVATE]  IANA, "Private Enterprise Numbers",
              http://www.iana.org/assignments/enterprise-numbers.

# 9. Author's Address(略)

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org




Zeilenga                    Standards Track                     [Page 4]

RFC 3673           LDAPv3: All Operational Attributes      December 2003


# 10. Full Copyright Statement(略)

   Copyright (C) The Internet Society (2003).  All Rights Reserved.

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
   revoked by the Internet Society or its successors or assignees.

   This document and the information contained herein is provided on an
   "AS IS" basis and THE INTERNET SOCIETY AND THE INTERNET ENGINEERING
   TASK FORCE DISCLAIMS ALL WARRANTIES, EXPRESS OR IMPLIED, INCLUDING
   BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF THE INFORMATION
   HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED WARRANTIES OF
   MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.

# Acknowledgement(略)

   Funding for the RFC Editor function is currently provided by the
   Internet Society.



















Zeilenga                    Standards Track                     [Page 5]

