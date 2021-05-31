





Network Working Group                                           S. Kille
Request for Comments: 2247                                    Isode Ltd.
Category: Standards Track                                        M. Wahl
                                                     Critical Angle Inc.
                                                             A. Grimstad
                                                                    AT&T
                                                                R. Huber
                                                                    AT&T
                                                             S. Sataluri
                                                                    AT&T
                                                            January 1998



            Using Domains in LDAP/X.500 Distinguished Names
            在 LDAP/X.500 DN中使用域名


Status of this Memo

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

Copyright Notice

   Copyright (C) The Internet Society (1998).  All Rights Reserved.

1. Abstract

   The Lightweight Directory Access Protocol (LDAP) uses X.500-
   compatible distinguished names [3] for providing unique
   identification of entries.
      轻型目录访问协议（LDAP）使用与X.500兼容的DN来提供条目的唯一标识。

   This document defines an algorithm by which a name registered with
   the Internet Domain Name Service [2] can be represented as an LDAP
   distinguished name.
      本文档定义了一种算法，通过该算法，
      可以将 在Internet域名服务[2]中注册的名称 表示为一个LDAP DN。

2. Background

   The Domain (Nameserver) System (DNS) provides a hierarchical resource
   labeling system.   A name is made up of an ordered set of components,
   each of which are short strings. An example domain name with two
   components would be "CRITICAL-ANGLE.COM".
      域（名称服务器）系统（DNS）提供了分层的资源标记系统。 
      名称由一组有序的组件组成，每个组件都是短字符串。 
            具有两个部分的示例域名为"CRITICAL-ANGLE.COM"。
#---------------------------------------------------------------------------------------





Kille, et. al.              Standards Track                     [Page 1]

RFC 2247              Using Domains in LDAP/X.500           January 1998


   LDAP-based directories provide a more general hierarchical naming
   framework. A primary difference in specification of distinguished
   names from domain names is that each component of an distinguished
   name has an explicit attribute type indication.
      基于LDAP的目录提供了更通用的层次命名框架。 
      DN与域名规范的主要区别在于，DN的每个组成部分都有明确的属性类型指示。

   X.500 does not mandate any particular naming structure.  It does
   contain suggested naming structures which are based on geographic and
   national regions, however there is not currently an established
   registration infrastructure in many regions which would be able to
   assign or ensure uniqueness of names.
      X.500不要求任何特定的命名结构。 
      它确实包含建议的命名结构，这些命名结构是基于地理和国家/地区的，
      但是目前在许多地区都没有一个能够分配或确保名称唯一性的 已建立的注册 基础结构。

   The mechanism described in this document automatically provides an
   enterprise a distinguished name for each domain name it has obtained
   for use in the Internet.  These distinguished names may be used to
   identify objects in an LDAP directory.
      本文档中描述的机制会自动为企业提供其在Internet中使用的每个域名的专有名称/DN。 
      这些DN可用于标识LDAP目录中的对象。


   An example distinguished name represented in the LDAP string format
   [3] is "DC=CRITICAL-ANGLE,DC=COM".  As with a domain name, the most
   significant component, closest to the root of the namespace, is
   written last.
      LDAP格式的字符串[3]示例，DN是“ DC = CRITICAL-ANGLE，DC = COM”。 
      与域名一样，最重要的组件是最接近根/root的组件。


   This document does not define how to represent objects which do not
   have domain names.  Nor does this document define the procedure to
   locate an enterprise's LDAP directory server, given their domain
   name.  Such procedures may be defined in future RFCs.
      本文档未定义如何表示不具有域名的对象。 
      该文档也未定义查找企业LDAP目录服务器的过程。 
      可以在将来的RFC中定义此类过程。


3. Mapping Domain Names into Distinguished Names
   将域名映射为DN

   This section defines a subset of the possible distinguished name
   structures for use in representing names allocated in the Internet
   Domain Name System.  It is possible to algorithmically transform any
   Internet domain name into a distinguished name, and to convert these
   distinguished names back into the original domain names.
      本节定义了可能的DN结构的子集，用于表示Internet域名系统中分配的名称。 
      可以通过算法将任何Internet域名转换为DN，并将这些DN转换回原始域名。


   The algorithm for transforming a domain name is to begin with an
   empty distinguished name (DN) and then attach Relative Distinguished
   Names (RDNs) for each component of the domain, most significant (e.g.
   rightmost) first. Each of these RDNs is a single
   AttributeTypeAndValue, where the type is the attribute "DC" and the
   value is an IA5 string containing the domain name component.
      用于转换域名的算法是从一个空的专有名称（DN）开始，
         然后为该域的每个组成部分附加相对专有名称（RDN），最重要（例如最右边）。 
      这些RDN中的每一个都是单个AttributeTypeAndValue，
         其中类型是属性“ DC”，值是包含域名组件的IA5字符串。


   Thus the domain name "CS.UCL.AC.UK" can be transformed into
      因此，域名“ CS.UCL.AC.UK”可以转换为

        DC=CS,DC=UCL,DC=AC,DC=UK
#---------------------------------------------------------------------------------------







Kille, et. al.              Standards Track                     [Page 2]

RFC 2247              Using Domains in LDAP/X.500           January 1998


   Distinguished names in which there are one or more RDNs, all
   containing only the attribute type DC, can be mapped back into domain
   names. Note that this document does not define a domain name
   equivalence for any other distinguished names.
      可以将一个或多个RDN（仅包含attribute type DC）的DN映射回域名。 
      请注意，本文档未定义任何其他DN的域名等效性。
      
4. Attribute Type Definition

   The DC (short for domainComponent) attribute type is defined as
   follows:
      DC（domainComponent的缩写）属性类型(attribute type)定义如下：

    ( 0.9.2342.19200300.100.1.25 NAME 'dc' EQUALITY caseIgnoreIA5Match
     SUBSTR caseIgnoreIA5SubstringsMatch
     SYNTAX 1.3.6.1.4.1.1466.115.121.1.26 SINGLE-VALUE )

   The value of this attribute is a string holding one component of a
   domain name.  The encoding of IA5String for use in LDAP is simply the
   characters of the string itself.  The equality matching rule is case
   insensitive, as is today's DNS.
      此属性的值是一个字符串，其中包含域名的一个组成部分。 
      LDAP中使用的IA5String的编码只是字符串本身的字符。 
      相等匹配规则与今天的DNS一样，不区分大小写。


5. Object Class Definitions

   An object with a name derived from its domain name using the
   algorithm of section 3 is represented as an entry in the directory.
   The "DC" attribute is present in the entry and used as the RDN.
      使用第3节的算法从其域名得出DN 的对象 表示为目录中的条目。 
      “ DC”属性存在于条目中，并用作RDN。


   An attribute can only be present in an entry held by an LDAP server
   when that attribute is permitted by the entry's object class.
      仅当entry的object class类允许该attribute时，
      该attribute才能出现在LDAP服务器所拥有的entry中。

   This section defines two object classes.  The first, dcObject, is
   intended to be used in entries for which there is an appropriate
   structural object class.  For example, if the domain represents a
   particular organization, the entry would have as its structural
   object class 'organization', and the 'dcObject' class would be an
   auxiliary class.  The second, domain, is a structural object class
   used for entries in which no other information is being stored. The
   domain object class is typically used for entries that are
   placeholders or whose domains do not correspond to real-world
   entities.
      本节定义两个object classes。 
      第一个'dcObject'用在 一个已经拥有适当 结构对象类(structural object class) 的条目 身上。 
         例如，如果某个域/domain代表一个特定的组织/公司/organization，
         则该条目将会拥有'organization[Unit]'作为它的 结构对象类(structural object class)，
         而“ dcObject”类为辅助类。 
      第二个，'domain' 是一个结构对象类(structural object class), 是用在 不存储其他信息的条目身上。 
         域对象类(domain object class) 
         通常用于 占位符或其域不对应于真实世界实体 的条目。
      
5.1. The dcObject object class

   The dcObject object class permits the dc attribute to be present in
   an entry.  This object class is defined as auxiliary, as it would
   typically be used in conjunction with an existing structural object
   class, such as organization, organizationalUnit or locality.
      dcObject object class 允许 dc attribute 出现在条目中。 
         该对象类被定义为辅助对象，
         因为它通常与现有的结构对象类(structural object class)
         （例如'organization'，'organizationalUnit'或 地方性）
         结合使用。
      
   The following object class, along with the dc attribute, can be added
   to any entry.
      以下object class以及dc attribute，可以被添加到任何条目中。
#---------------------------------------------------------------------------------------



Kille, et. al.              Standards Track                     [Page 3]

RFC 2247              Using Domains in LDAP/X.500           January 1998


   ( 1.3.6.1.4.1.1466.344 NAME 'dcObject' SUP top AUXILIARY MUST dc )

   An example entry would be:

   dn: dc=critical-angle,dc=com
   objectClass: top
   objectClass: organization
   objectClass: dcObject
   dc: critical-angle
   o: Critical Angle Inc.

5.2. The domain object class

   If the entry does not correspond to an organization, organizational
   unit or other type of object for which an object class has been
   defined, then the "domain" object class can be used.  The "domain"
   object class requires that the "DC" attribute be present, and permits
   several other attributes to be present in the entry.
      如果该条目不对应于 为其定义了对象类别 的'organization'，'organizationalunit'或其他类型的 对象，
         则可以使用“domain”object class。 
      “domain”对象类要求存在“ DC”属性，并允许在条目中存在其他几个属性。
      
   The entry will have as its structural object class the "domain"
   object class.
      拥有domain的条目，将会将domain作为它的 结构对象类

( 0.9.2342.19200300.100.4.13 NAME 'domain' SUP top STRUCTURAL
 MUST dc
 MAY ( userPassword $ searchGuide $ seeAlso $ businessCategory $
 x121Address $ registeredAddress $ destinationIndicator $
 preferredDeliveryMethod $ telexNumber $ teletexTerminalIdentifier $
 telephoneNumber $ internationaliSDNNumber $ facsimileTelephoneNumber $
 street $ postOfficeBox $ postalCode $ postalAddress $
 physicalDeliveryOfficeName $ st $ l $ description $ o $
 associatedName ) )

   The optional attributes of the domain class are used for describing
   the object represented by this domain, and may also be useful when
   searching.  These attributes are already defined for use with LDAP
   [4].
      'domain'的可选属性用于描述此域表示的对象，并且在搜索时也可能有用。 
      这些属性已经定义 可用于LDAP [4]。

   An example entry would be:

   dn: dc=tcp,dc=critical-angle,dc=com
   objectClass: top
   objectClass: domain
   dc: tcp
   description: a placeholder entry used with SRV records

   The DC attribute is used for naming entries of the domain class, and
   this can be represented in X.500 servers by the following name form
   rule.
      DC属性用于命名域类的条目，并且可以通过以下名称形式规则在X.500服务器中表示该属性。
      
#---------------------------------------------------------------------------------------



Kille, et. al.              Standards Track                     [Page 4]

RFC 2247              Using Domains in LDAP/X.500           January 1998


    ( 1.3.6.1.4.1.1466.345 NAME 'domainNameForm' OC domain MUST ( dc ) )

6. References

   [1] The Directory: Selected Attribute Types. ITU-T Recommendation
       X.520, 1993.

   [2] Mockapetris, P., " Domain Names - Concepts and Facilities,"
       STD 13, RFC 1034, November 1987.

   [3] Kille, S., and M. Wahl, " Lightweight Directory Access Protocol
       (v3): UTF-8 String Representation of Distinguished Names", RFC
       2253, December 1997.

   [4] Wahl, M., "A Summary of the X.500(96) User Schema for use with
       LDAP", RFC 2256, December 1997.

7. Security Considerations

   This memo describes how attributes of objects may be discovered and
   retrieved.  Servers should ensure that an appropriate security policy
   is maintained.

   An enterprise is not restricted in the information which it may store
   in DNS or LDAP servers.  A client which contacts an untrusted server
   may have incorrect or misleading information returned (e.g. an
   organization's server may claim to hold naming contexts representing
   domain names which have not been delegated to that organization).

8. Authors' Addresses

   Steve Kille
   Isode Ltd.
   The Dome
   The Square
   Richmond, Surrey
   TW9 1DT
   England

   Phone:  +44-181-332-9091
   EMail:  S.Kille@ISODE.COM
#---------------------------------------------------------------------------------------










Kille, et. al.              Standards Track                     [Page 5]

RFC 2247              Using Domains in LDAP/X.500           January 1998


   Mark Wahl
   Critical Angle Inc.
   4815 W. Braker Lane #502-385
   Austin, TX 78759
   USA

   Phone:  (1) 512 372 3160
   EMail:  M.Wahl@critical-angle.com


   Al Grimstad
   AT&T
   Room 1C-429, 101 Crawfords Corner Road
   Holmdel, NJ 07733-3030
   USA

   EMail: alg@att.com


   Rick Huber
   AT&T
   Room 1B-433, 101 Crawfords Corner Road
   Holmdel, NJ 07733-3030
   USA

   EMail: rvh@att.com


   Sri Sataluri
   AT&T
   Room 4G-202, 101 Crawfords Corner Road
   Holmdel, NJ 07733-3030
   USA

   EMail: sri@att.com
#---------------------------------------------------------------------------------------
















Kille, et. al.              Standards Track                     [Page 6]

RFC 2247              Using Domains in LDAP/X.500           January 1998


9.  Full Copyright Statement

   Copyright (C) The Internet Society (1998).  All Rights Reserved.

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
#---------------------------------------------------------------------------------------
























Kille, et. al.              Standards Track                     [Page 7]

#---------------------------------------------------------------------------------------