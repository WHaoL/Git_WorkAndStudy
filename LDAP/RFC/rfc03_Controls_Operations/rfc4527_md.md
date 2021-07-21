





Network Working Group                                        K. Zeilenga
Request for Comments: 4527                           OpenLDAP Foundation
Category: Standards Track                                      June 2006


# Lightweight Directory Access Protocol (LDAP) Read Entry Controls

## Status of This Memo(略)
   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

# Copyright Notice(略)
   Copyright (C) The Internet Society (2006).

# Abstract(摘要)
This document specifies an extension to the Lightweight Directory Access Protocol (LDAP) to allow the client to read the target entry of an update operation.  The client may request to read the entry before and/or after the modifications are applied.  These reads are done as an atomic part of the update operation.
<font color=red>本文档指定了LDAP的extension/扩展，以允许client 读取update-operation的target-entry。</font>
<font color=red>client可以在 修改/modify 之前和/或之后 请求读取条目/entry。</font>
<font color=red>这些读取/read 是作为更新操作/update-operation的原子部分完成的。</font>

```bash
Table of Contents
   1. Background and Intent of Use ....................................2
   2. Terminology .....................................................2
   3. Read Entry Controls .............................................3
      3.1. The Pre-Read Controls ......................................3
      3.2. The Post-Read Controls .....................................3
   4. Interaction with Other Controls .................................4
   5. Security Considerations .........................................4
   6. IANA Considerations .............................................5
      6.1. Object Identifier ..........................................5
      6.2. LDAP Protocol Mechanisms ...................................5
   7. Acknowledgement .................................................5
   8. References ......................................................6
      8.1. Normative References .......................................6
      8.2. Informative References .....................................7
```



# 1.  Background and Intent of Use( 背景和使用意图)

This document specifies an extension to the Lightweight Directory Access Protocol (LDAP) [RFC4510] to allow the client to read the target entry of an update operation (e.g., Add, Delete, Modify, ModifyDN).  The extension utilizes controls [RFC4511] attached to update requests to request and return copies of the target entry. One request control, called the Pre-Read request control, indicates that a copy of the entry before application of update is to be returned.  Another control, called the Post-Read request control, indicates that a copy of the entry after application of the update is to be returned.  Each request control has a corresponding response control used to return the entry.
<font color=red>本文档指定了轻量级目录访问协议 (LDAP) [RFC4510] 的扩展，以允许客户端读取更新操作 (例如, Add, Delete, Modify, ModifyDN)    的目标条目。</font>
<font color=red>该扩展/extension 利用附加到更新请求/update-request的控件/control [RFC4511] ， 来请求返回目标条目/target-entry的副本/copy。</font>
<font color=green>一种称为  预读请求控件/Pre-Read-request-control  的请求控件，指示将在  **更新之前**  返回条目的副本。</font>
<font color=green>另一个控件，称为 Post-Read-request-control，指示  **更新后**  将返回条目的副本。</font>
<font color=red>每个请求控件/request-control都有一个对应的响应控件/response-control  用于返回条目。</font>

To ensure proper isolation, the controls are processed as an atomic part of the update operation.
<font color=red>为确保适当的隔离，控件/control 作为更新操作/update-operation 的原子部分进行处理。</font>

The functionality offered by these controls is based upon similar functionality in the X.500 Directory Access Protocol (DAP) [X.511].
这些控件/control 提供的功能基于 X.500 目录访问协议 (DAP) [X.511] 中的类似功能。

The Pre-Read controls may be used to obtain replaced or deleted values of modified attributes or a copy of the entry being deleted.
<font color=red>**Pre-Read 控件，可用于获取，要执行修改操作的属性  的  (将)被替换的值或(将)被删除的值，或正在被删除的条目的副本。**</font>

The Post-Read controls may be used to obtain values of operational attributes, such as the 'entryUUID' [RFC4530] and 'modifyTimestamp' [RFC4512] attributes, updated by the server as part of the update operation.
<font color=red>**Post-Read 控件，可用于获取，operational attribute/操作属性 的值**，</font>
<font color=green>例如  'entryUUID'[RFC4530] 和'modifyTimestamp' [RFC4512] 属性，作为更新操作/update-operation的一部分由服务器更新。</font>



# 2. Terminology(术语)

Protocol elements are described using ASN.1 [X.680] with implicit tags.  The term "BER-encoded" means the element is to be encoded using the Basic Encoding Rules [X.690] under the restrictions detailed in Section 5.1 of [RFC4511].
<font color=red>协议元素/protocol-element 使用带有隐式标签/tag的 ASN.1 [X.680] 进行描述。 </font>
<font color=red>术语"BER-encoded"意味着元素将使用基本编码规则 [X.690] ，根据 [RFC4511] 的第 5.1 节中详述的限制进行编码。</font>

DN stands for Distinguished Name.
DSA stands for Directory System Agent (i.e., a directory server).
DSE stands for DSA-specific Entry.
<font color=green>DN   代表  专有名称。</font>
<font color=green>DSA 代表  目录系统代理（即**目录服务器**）。</font>
<font color=green>DSE 代表  特定于DSA(目录服务器)的条目。</font>

In this document, the key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" are to be interpreted as described in BCP 14 [RFC2119].
在本文档中，关键词"MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" 将按照 BCP 14 [RFC2119] 中的描述进行解释。



# 3.  Read Entry Controls

## 3.1.  The Pre-Read Controls

The Pre-Read request and response controls are identified by the 1.3.6.1.1.13.1 object identifier.  Servers implementing these controls SHOULD publish 1.3.6.1.1.13.1 as a value of the 'supportedControl' [RFC4512] in their root DSE.
<font color=red>Pre-Read 请求和响应控件由 1.3.6.1.1.13.1 对象标识符/OID 标识。</font>
<font color=green>实现这些控件的服务器，应该在它们的根DSE 中发布 1.3.6.1.1.13.1 作为'supportedControl'[RFC4512] 的值。</font>

The Pre-Read request control is a LDAP Control [RFC4511] whose controlType is 1.3.6.1.1.13.1 and whose controlValue is a BER-encoded AttributeSelection [RFC4511], as extended by [RFC3673].  The criticality may be TRUE or FALSE.  This control is appropriate for the modifyRequest, delRequest, and modDNRequest LDAP messages.
<font color=red>Pre-Read 请求控件是一个 LDAP控件 [RFC4511]，</font>
      <font color=green>其 controlType 是 1.3.6.1.1.13.1，</font>
      <font color=green>其 controlValue 是一个 BER 编码的 AttributeSelection [RFC4511]，由 [RFC3673] 扩展。</font>
      <font color=green>criticality/关键性，可以是 TRUE 或 FALSE。</font>
<font color=red>此控件适用于 modifyRequest、delRequest 和 modDNRequest LDAP-message。</font>

The corresponding response control is a LDAP Control whose controlType is 1.3.6.1.1.13.1 and whose the controlValue, an OCTET STRING, contains a BER-encoded SearchResultEntry.  The criticality may be TRUE or FALSE.  This control is appropriate for the modifyResponse, delResponse, and modDNResponse LDAP messages with a resultCode of success (0).
<font color=red>相应的响应控制是一个 LDAP控件，</font>
      <font color=green>其 controlType 为 1.3.6.1.1.13.1，</font>
      <font color=green>其 controlValue，一个 OCTET STRING，包含一个 BER 编码的 SearchResultEntry。</font>
      <font color=green>criticality/关键性，可以是 TRUE 或 FALSE。</font>
<font color=red>此控件，适用于resultCode为success (0)的 modifyResponse、delResponse 和 modDNResponse LDAP-message。</font>

When the request control is attached to an appropriate update LDAP request, the control requests the return of a copy of the target entry prior to the application of the update.  The AttributeSelection indicates, as discussed in [RFC4511][RFC3673], which attributes are requested to appear in the copy.  The server is to return a SearchResultEntry containing, subject to access controls and other constraints, values of the requested attributes.
<font color=red>当该请求控件/request-control，附加到适当的 更新LDAP的请求时，该控件会在 **更新之前** 请求返回目标条目的副本。 </font>
<font color=green>AttributeSelection 指示，如[RFC4511] [RFC3673]中所讨论的，哪些属性被请求出现在副本中。</font>
<font color=green>服务器将返回一个  包含所请求属性值的SearchResultEntry，(但)受访问控制和其他约束的约束。</font>

The normal processing of the update operation and the processing of this control MUST be performed as one atomic action isolated from other update operations.
<font color=red>更新操作的正常处理 和 此控件的处理，必须作为与其他更新操作隔离的一个原子操作来执行。</font>

If the update operation fails (in either normal or control processing), no Pre-Read response control is provided.
<font color=red>如果更新操作失败(正常处理 或 控件处理)，则不提供Pre-Read response control/响应控件。</font>



## 3.2.  The Post-Read Controls

The Post-Read request and response controls are identified by the 1.3.6.1.1.13.2 object identifier.  Servers implementing these controls SHOULD publish 1.3.6.1.1.13.2 as a value of the 'supportedControl' [RFC4512] in their root DSE.
<font color=red>Post-Read request control/请求控件和response control/响应控件，由 1.3.6.1.1.13.2标识。</font>
<font color=red>实现这些控件的服务器，应该在它们的根DSE 中发布1.3.6.1.1.13.2作为'supportedControl'[RFC4512] 的值。</font>

The Post-Read request control is a LDAP Control [RFC4511] whose controlType is 1.3.6.1.1.13.2 and whose controlValue, an OCTET STRING, contains a BER-encoded AttributeSelection [RFC4511], as extended by [RFC3673].  The criticality may be TRUE or FALSE.  This control is appropriate for the addRequest, modifyRequest, and modDNRequest LDAP messages.
<font color=red>Post-Read 请求控件是一个 LDAP控件 [RFC4511]，</font>
      <font color=green>它的 controlType 是 1.3.6.1.1.13.2，</font>
      <font color=green>它的 controlValue，一个 OCTET STRING，包含一个 BER 编码的 AttributeSelection [RFC4511]，由 [RFC3673] 扩展。</font>
      <font color=green>criticality/关键性，可以是 TRUE 或 FALSE。</font>
<font color=red>此控件适用于 addRequest、modifyRequest 和 modDNRequest LDAP-messages。</font>

The corresponding response control is a LDAP Control whose controlType is 1.3.6.1.1.13.2 and whose controlValue is a BER-encoded SearchResultEntry.  The criticality may be TRUE or FALSE.  This control is appropriate for the addResponse, modifyResponse, and modDNResponse LDAP messages with a resultCode of success (0).
<font color=red>对应的响应控件是一个 LDAP 控件，</font>
      <font color=green>它的 controlType 是 1.3.6.1.1.13.2，</font>
      <font color=green>它的 controlValue 是一个 BER 编码的 SearchResultEntry。</font>
      <font color=green>criticality/关键性 ，可以是 TRUE 或 FALSE。</font>
<font color=red>此控件，适用于 resultCode 为success (0) 的 addResponse、modifyResponse 和 modDNResponse LDAP-messages。</font>

When the request control is attached to an appropriate update LDAP request, the control requests the return of a copy of the target entry after the application of the update.  The AttributeSelection indicates, as discussed in [RFC4511][RFC3673], which attributes are requested to appear in the copy.  The server is to return a SearchResultEntry containing, subject to access controls and other constraints, values of the requested attributes.
<font color=red>当该请求控件/request-control 附加到适当的更新LDAP的请求时，该控件 会在应用**更新后**请求返回目标条目的副本。 </font>
<font color=green>AttributeSelection 指示，如[RFC4511] [RFC3673]中所讨论的，哪些属性被请求出现在副本中。</font>
<font color=green>服务器将返回一个  包含所请求属性值的SearchResultEntry，(但)受访问控制和其他约束的约束。</font>

The normal processing of the update operation and the processing of this control MUST be performed as one atomic action isolated from other update operations.
<font color=red>更新操作的正常处理和此控件的处理，必须作为 与其他更新操作隔离的一个原子操作来执行。</font>

If the update operation fails (in either normal or control processing), no Post-Read response control is provided.
<font color=red>如果更新操作失败(正常处理 或 控件处理)，则不提供 Post-Read response control/响应控件。</font>



# 4.  Interaction with Other Controls(和其他控件交互)

The Pre-Read and Post-Read controls may be combined with each other and/or with a variety of other controls.  When combined with the assertion control [RFC4528] and/or the manageDsaIT control [RFC3296], the semantics of each control included in the combination applies. The Pre-Read and Post-Read controls may be combined with other controls as detailed in other technical specifications.
<font color=red>Pre-Read 和 Post-Read 控件可以相互组合和/或与各种其他控件组合。</font>
<font color=red>当与  assertion control/断言控件[RFC4528]  和/或  manageDsaIT控 [RFC3296]  组合时，组合中包含的每个控件的语义都适用。 </font>
<font color=red>Pre-Read和Post-Read控件，可以与其他技术规范中详述的其他控件组合。</font>



# 5.  Security Considerations(略)

The controls defined in this document extend update operations to support read capabilities.  Servers MUST ensure that the client is authorized for reading of the information provided in this control and that the client is authorized to perform the requested directory update.
本文档中定义的控件，扩展了更新操作以支持读取功能。
服务器必须确保客户端有权读取此控件中提供的信息，并且客户端有权执行请求的目录更新。

Security considerations for the update operations [RFC4511] extended by this control, as well as general LDAP security considerations [RFC4510], generally apply to implementation and use of this extension
此控制扩展的更新操作的安全考虑 [RFC4511]，以及一般 LDAP 安全考虑 [RFC4510]，通常适用于此扩展的实现和使用


# 6.  IANA Considerations(分配的OID)

Registration of the following protocol values [RFC4520] have been completed by the IANA.
IANA 已完成以下协议值 [RFC4520] 的注册。

## 6.1.  Object Identifier

The IANA has registered an LDAP Object Identifier to identify LDAP protocol elements defined in this document.
IANA 注册了一个LDAP OID，来标识本文档中定义的 LDAP 协议元素。

```
       Subject: Request for LDAP Object Identifier Registration
       Person & email address to contact for further information:
            Kurt Zeilenga <kurt@OpenLDAP.org>
       Specification: RFC 4527
       Author/Change Controller: IESG
       Comments: Identifies the LDAP Read Entry Controls
```



## 6.2.  LDAP Protocol Mechanisms

The IANA has registered the LDAP Protocol Mechanism described in this document.
IANA 已注册本文档中描述的 LDAP 协议机制。

```
       Subject: Request for LDAP Protocol Mechanism Registration
       Object Identifier: 1.3.6.1.1.13.1
       Description: LDAP Pre-read Control
       Person & email address to contact for further information:
            Kurt Zeilenga <kurt@openldap.org>
       Usage: Control
       Specification: RFC 4527
       Author/Change Controller: IESG
       Comments: none

       Subject: Request for LDAP Protocol Mechanism Registration
       Object Identifier: 1.3.6.1.1.13.2
       Description: LDAP Post-read Control
       Person & email address to contact for further information:
            Kurt Zeilenga <kurt@openldap.org>
       Usage: Control
       Specification: RFC 4527
       Author/Change Controller: IESG
       Comments: none
```
# 7.  Acknowledgement(略)

The LDAP Pre-Read and Post-Read controls are modeled after similar capabilities offered in the DAP [X.511].
LDAP Pre-Read 和 Post-Read 控件模仿 DAP [X.511] 中提供的类似功能。


# 8.  References(略)

## 8.1.  Normative References

   [RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate
                 Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC3296]     Zeilenga, K., "Named Subordinate References in
                 Lightweight Directory Access Protocol (LDAP)
                 Directories", RFC 3296, July 2002.

   [RFC3673]     Zeilenga, K., "Lightweight Directory Access Protocol
                 version 3 (LDAPv3): All Operational Attributes", RFC
                 3673, December 2003.

   [RFC4510]     Zeilenga, K., Ed, "Lightweight Directory Access
                 Protocol (LDAP): Technical Specification Road Map", RFC
                 4510, June 2006.

   [RFC4511]     Sermersheim, J., Ed., "Lightweight Directory Access
                 Protocol (LDAP): The Protocol", RFC 4511, June 2006.

   [RFC4512]     Zeilenga, K., "Lightweight Directory Access Protocol
                 (LDAP): Directory Information Models", RFC 4512, June
                 2006.

   [RFC4528]     Zeilenga, K., "Lightweight Directory Access Protocol
                 (LDAP) Assertion Control", RFC 4528, June 2006.

   [X.680]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "Abstract
                 Syntax Notation One (ASN.1) - Specification of Basic
                 Notation", X.680(1997) (also ISO/IEC 8824-1:1998).

   [X.690]       International Telecommunication Union -
                 Telecommunication Standardization Sector,
                 "Specification of ASN.1 encoding rules: Basic Encoding
                 Rules (BER), Canonical Encoding Rules (CER), and
                 Distinguished Encoding Rules (DER)", X.690(1997) (also
                 ISO/IEC 8825-1:1998).











Zeilenga                    Standards Track                     [Page 6]

RFC 4527                LDAP Read Entry Controls               June 2006


## 8.2.  Informative References

   [RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority
                 (IANA) Considerations for the Lightweight Directory
                 Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

   [RFC4530]     Zeilenga, K., "Lightweight Directory Access Protocol
                 (LDAP) EntryUUID Operational Attribute", RFC 4530, June
                 2006.

   [X.511]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory: Abstract Service Definition", X.511(1993)
                 (also ISO/IEC 9594-3:1993).

# Author's Address(略)

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org






























Zeilenga                    Standards Track                     [Page 7]

RFC 4527                LDAP Read Entry Controls               June 2006


# Full Copyright Statement(略)

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

# Intellectual Property(略)

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

# Acknowledgement(略)

   Funding for the RFC Editor function is provided by the IETF Administrative Support Activity (IASA).







Zeilenga                    Standards Track                     [Page 8]

