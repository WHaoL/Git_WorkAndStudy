
```bash
注意： 
  先前 /LDAP/rfc-OPENLDAP_REL_ENG_2_4/目录下的文档，均已经整合到 /LDAP/RFC/目录下，并进行了良好的分类
```


# 关于LDAP的RFC文档如何阅读



## 1.首先看 `./rfc00_base/`下的文档

-------------------------------------------------------------
```
ASN.1-BER-LDAP[阅读rfc44511的必备知识]
阅读：
  ASN.1_BER_LDAP.md 
熟悉：
​   基本的ASN.1-BER基本编码规则；
​		BER的类型以及BER类型的十六进制编码；
​		BER类型 如何表示为 ASN.1 string/字符串
```



-------------------------------------------------------------
```
ABNF[阅读rfc4512的必备知识]
阅读：
  BNF.md
  rfc5234_ABNF.md
```



-------------------------------------------------------------

## 2.`./rfc01/` Core Specifications

这个文件夹下是 LDAP的核心协议：先看4511-4529 ，然后看2849-3866



RFCs Defining the LDAP Protocol and Other Core Specifications

- [RFC 2849](https://docs.ldap.com/specs/rfc2849.txt): The LDAP Data Interchange Format (LDIF) – Technical Specification

- [RFC 3296](https://docs.ldap.com/specs/rfc3296.txt): Named Subordinate References in Lightweight Directory Access Protocol (LDAP) Directories

- [RFC 3671](https://docs.ldap.com/specs/rfc3671.txt): Collective Attributes in the Lightweight Directory Access Protocol (LDAP)

- [RFC 3672](https://docs.ldap.com/specs/rfc3672.txt): Subentries in the Lightweight Directory Access Protocol (LDAP)

- [RFC 3673](https://docs.ldap.com/specs/rfc3673.txt): Lightweight Directory Access Protocol version 3 (LDAPv3): All Operational Attributes

- [RFC 3866](https://docs.ldap.com/specs/rfc3866.txt): Language Tags and Ranges in the Lightweight Directory Access Protocol (LDAP)
  Obsoletes: [RFC 2596](https://docs.ldap.com/specs/rfc2596.txt)

- [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt): Lightweight Directory Access Protocol (LDAP): The Protocol
  Obsoletes: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt), [RFC 2830](https://docs.ldap.com/specs/rfc2830.txt), [RFC 3771](https://docs.ldap.com/specs/rfc3771.txt)

- [RFC 4512](https://docs.ldap.com/specs/rfc4512.txt): Lightweight Directory Access Protocol (LDAP): Directory Information Models
  Obsoletes: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt), [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt), [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt), [RFC 3674](https://docs.ldap.com/specs/rfc3674.txt)

- [RFC 4513](https://docs.ldap.com/specs/rfc4513.txt): Lightweight Directory Access Protocol (LDAP): Authentication Methods and Security Mechanisms
  Obsoletes: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt), [RFC 2829](https://docs.ldap.com/specs/rfc2829.txt), [RFC 2830](https://docs.ldap.com/specs/rfc2830.txt)

- [RFC 4514](https://docs.ldap.com/specs/rfc4514.txt): Lightweight Directory Access Protocol (LDAP): String Representation of Distinguished Names
  Obsoletes: [RFC 2253](https://docs.ldap.com/specs/rfc2253.txt)

- [RFC 4515](https://docs.ldap.com/specs/rfc4515.txt): Lightweight Directory Access Protocol (LDAP): String Representation of Search Filters
  Obsoletes: [RFC 2254](https://docs.ldap.com/specs/rfc2254.txt)

- [RFC 4516](https://docs.ldap.com/specs/rfc4516.txt): Lightweight Directory Access Protocol (LDAP): Uniform Resource Locator
  Obsoletes: [RFC 2255](https://docs.ldap.com/specs/rfc2255.txt)

- [RFC 4518](https://docs.ldap.com/specs/rfc4518.txt): Lightweight Directory Access Protocol (LDAP): Internationalized String Preparation

- [RFC 4522](https://docs.ldap.com/specs/rfc4522.txt): Lightweight Directory Access Protocol (LDAP): The Binary Encoding Option

- [RFC 4525](https://docs.ldap.com/specs/rfc4525.txt): Lightweight Directory Access Protocol (LDAP) Modify-Increment Extension

- [RFC 4526](https://docs.ldap.com/specs/rfc4526.txt): Lightweight Directory Access Protocol (LDAP) Absolute True and False Filters

- [RFC 4529](https://docs.ldap.com/specs/rfc4529.txt): Requesting Attributes by Object Class in the Lightweight Directory Access Protocol





## 3.Interface Documents Recommendations Practices

本文件夹下是编程接口



RFCs Containing Informational Documents, Recommendations, and Best Practices

- [RFC 1823](https://docs.ldap.com/specs/rfc1823.txt): The LDAP Application Program Interface
  - LDAP应用程序编程接口

- [RFC 2377](https://docs.ldap.com/specs/rfc2377.txt): Naming Plan for Internet Directory-Enabled Applications
  Updated By: [RFC 4519](https://docs.ldap.com/specs/rfc4519.txt)

- [RFC 2820](https://docs.ldap.com/specs/rfc2820.txt): Access Control Requirements for LDAP

- [RFC 3352](https://docs.ldap.com/specs/rfc3352.txt): Connection-less Lightweight Directory Access Protocol (CLDAP) to Historic Status
  Obsoletes: [RFC 1798](https://docs.ldap.com/specs/rfc1798.txt)

- [RFC 3384](https://docs.ldap.com/specs/rfc3384.txt): Lightweight Directory Access Protocol (version 3) Replication Requirements

- [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt): Lightweight Directory Access Protocol version 2 (LDAPv2) to Historic Status
  Obsoletes: [RFC 1484](https://docs.ldap.com/specs/rfc1484.txt), [RFC 1485](https://docs.ldap.com/specs/rfc1485.txt), [RFC 1487](https://docs.ldap.com/specs/rfc1487.txt), [RFC 1777](https://docs.ldap.com/specs/rfc1777.txt), [RFC 1778](https://docs.ldap.com/specs/rfc1778.txt), [RFC 1779](https://docs.ldap.com/specs/rfc1779.txt), [RFC 1781](https://docs.ldap.com/specs/rfc1781.txt), [RFC 2559](https://docs.ldap.com/specs/rfc2559.txt)

- [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt): Lightweight Directory Access Protocol (LDAP): Technical Specification Road Map
  Obsoletes: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt), [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt), [RFC 2253](https://docs.ldap.com/specs/rfc2253.txt), [RFC 2254](https://docs.ldap.com/specs/rfc2254.txt), [RFC 2255](https://docs.ldap.com/specs/rfc2255.txt), [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt), [RFC 2829](https://docs.ldap.com/specs/rfc2829.txt), [RFC 2830](https://docs.ldap.com/specs/rfc2830.txt), [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt), [RFC 3771](https://docs.ldap.com/specs/rfc3771.txt)

- [RFC 4520](https://docs.ldap.com/specs/rfc4520.txt): Internet Assigned Numbers Authority (IANA) Considerations for the Lightweight Directory Access Protocol (LDAP)
  Obsoletes: [RFC 3383](https://docs.ldap.com/specs/rfc3383.txt)

- [RFC 4521](https://docs.ldap.com/specs/rfc4521.txt): Considerations for Lightweight Directory Access Protocol (LDAP) Extensions



## 4.Controls Operations

RFCs Defining Controls and Extended Operations

- [RFC 2589](https://docs.ldap.com/specs/rfc2589.txt): Lightweight Directory Access Protocol (v3): Extensions for Dynamic Directory Services

- [RFC 2649](https://docs.ldap.com/specs/rfc2649.txt): An LDAP Control and Schema for Holding Operation Signatures

- [RFC 2696](https://docs.ldap.com/specs/rfc2696.txt): LDAP Control Extension for Simple Paged Results Manipulation

- [RFC 2891](https://docs.ldap.com/specs/rfc2891.txt): LDAP Control Extension for Server Side Sorting of Search Results

- [RFC 3062](https://docs.ldap.com/specs/rfc3062.txt): LDAP Password Modify Extended Operation

- [RFC 3829](https://docs.ldap.com/specs/rfc3829.txt): Lightweight Directory Access Protocol (LDAP) Authorization Identity Request and Response Controls

- [RFC 3876](https://docs.ldap.com/specs/rfc3876.txt): Returning Matched Values with the Lightweight Directory Access Protocol version 3 (LDAPv3)

- [RFC 3909](https://docs.ldap.com/specs/rfc3909.txt): Lightweight Directory Access Protocol (LDAP) Cancel Operation

- [RFC 3928](https://docs.ldap.com/specs/rfc3928.txt): Lightweight Directory Access Protocol (LDAP) Client Update Protocol

- [RFC 4370](https://docs.ldap.com/specs/rfc4370.txt): Lightweight Directory Access Protocol (LDAP) Proxied Authorization Control

- [RFC 4373](https://docs.ldap.com/specs/rfc4373.txt): Lightweight Directory Access Protocol (LDAP) Bulk Update/Replication Protocol (LBURP)

- [RFC 4527](https://docs.ldap.com/specs/rfc4527.txt): Lightweight Directory Access Protocol (LDAP) Read Entry Controls

- [RFC 4528](https://docs.ldap.com/specs/rfc4528.txt): Lightweight Directory Access Protocol (LDAP) Assertion Control

- [RFC 4531](https://docs.ldap.com/specs/rfc4531.txt): Lightweight Directory Access Protocol (LDAP) Turn Operation

- [RFC 4532](https://docs.ldap.com/specs/rfc4532.txt): Lightweight Directory Access Protocol (LDAP) “Who am I?” Operation

- [RFC 4533](https://docs.ldap.com/specs/rfc4533.txt): The Lightweight Directory Access Protocol (LDAP) Content Synchronization Operation

- [RFC 5805](https://docs.ldap.com/specs/rfc5805.txt): Lightweight Directory Access Protocol (LDAP) Transactions

- [RFC 6171](https://docs.ldap.com/specs/rfc6171.txt): The Lightweight Directory Access Protocol (LDAP) Don’t Use Copy Control



## 5.Core Schema

RFCs Defining Core LDAP Schema

- [RFC 2247](https://docs.ldap.com/specs/rfc2247.txt): Using Domains in LDAP/X.500 Distinguished Names
  Updated by: [RFC 4519](https://docs.ldap.com/specs/rfc4519.txt), [RFC 4524](https://docs.ldap.com/specs/rfc4524.txt)

- [RFC 2798](https://docs.ldap.com/specs/rfc2798.txt): Definition of the inetOrgPerson LDAP Object Class
  Updated by: [RFC 3698](https://docs.ldap.com/specs/rfc3698.txt), [RFC 4519](https://docs.ldap.com/specs/rfc4519.txt), [RFC 4524](https://docs.ldap.com/specs/rfc4524.txt)

- [RFC 2926](https://docs.ldap.com/specs/rfc2926.txt): Conversion of LDAP Schemas to and from SLP Templates

- [RFC 2985](https://docs.ldap.com/specs/rfc2985.txt): PKCS #9: Selected Object Classes and Attribute Types Version 2.0

- [RFC 3045](https://docs.ldap.com/specs/rfc3045.txt): Storing Vendor Information in the LDAP root DSE

- [RFC 3112](https://docs.ldap.com/specs/rfc3112.txt): LDAP Authentication Password Schema

- [RFC 3687](https://docs.ldap.com/specs/rfc3687.txt): Lightweight Directory Access Protocol (LDAP) and X.500 Component Matching Rules

- [RFC 3698](https://docs.ldap.com/specs/rfc3698.txt): Lightweight Directory Access Protocol (LDAP) Additional Matching Rules
  Updates: [RFC 2798](https://docs.ldap.com/specs/rfc2798.txt)
  Updated by: [RFC 4517](https://docs.ldap.com/specs/rfc4517.txt)

- [RFC 4517](https://docs.ldap.com/specs/rfc4517.txt): Lightweight Directory Access Protocol (LDAP): Syntaxes and Matching Rules
  Updates: [RFC 3698](https://docs.ldap.com/specs/rfc3698.txt)
  Obsoletes: [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt), [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt)

- [RFC 4519](https://docs.ldap.com/specs/rfc4519.txt): Lightweight Directory Access Protocol (LDAP): Schema for User Applications
  Updates: [RFC 2247](https://docs.ldap.com/specs/rfc2247.txt), [RFC 2377](https://docs.ldap.com/specs/rfc2377.txt), [RFC 2798](https://docs.ldap.com/specs/rfc2798.txt)
  Obsoletes: [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt)

- [RFC 4524](https://docs.ldap.com/specs/rfc4524.txt): COSINE LDAP/X.500 Schema
  Updates: [RFC 2247](https://docs.ldap.com/specs/rfc2247.txt), [RFC 2798](https://docs.ldap.com/specs/rfc2798.txt)
  Obsoletes: [RFC 1274](https://docs.ldap.com/specs/rfc1274.txt)

- [RFC 4530](https://docs.ldap.com/specs/rfc4530.txt): Lightweight Directory Access Protocol (LDAP) entryUUID Operational Attribute

- [RFC 5020](https://docs.ldap.com/specs/rfc5020.txt): The Lightweight Directory Access Protocol (LDAP) entryDN Operational Attribute



## 6.Additional Schema

RFCs Containing Additional LDAP Schema Definitions

- [RFC 2079](https://docs.ldap.com/specs/rfc2079.txt): Definition of an X.500 Attribute Type and an Object Class to Hold Uniform Resource Identifiers (URIs)

- [RFC 2307](https://docs.ldap.com/specs/rfc2307.txt): An Approach for Using LDAP as a Network Information Service

- [RFC 2713](https://docs.ldap.com/specs/rfc2713.txt): Schema for Representing Java(tm) Objects in an LDAP Directory

- [RFC 2714](https://docs.ldap.com/specs/rfc2714.txt): Schema for Representing CORBA Objects in an LDAP Directory

- [RFC 2739](https://docs.ldap.com/specs/rfc2739.txt): Calendar Attributes for vCard and LDAP

- [RFC 3641](https://docs.ldap.com/specs/rfc3641.txt): Generic String Encoding Rules (GSER) for ASN.1 Types
  Updated by: [RFC 4792](https://docs.ldap.com/specs/rfc4792.txt)

- [RFC 3642](https://docs.ldap.com/specs/rfc3642.txt): Common Elements of Generic String Encoding Rules (GSER) Encodings

- [RFC 3703](https://docs.ldap.com/specs/rfc3703.txt): Policy Core Lightweight Directory Access Protocol (LDAP) Schema
  Updated by: [RFC 4104](https://docs.ldap.com/specs/rfc4104.txt)

- [RFC 3727](https://docs.ldap.com/specs/rfc3727.txt): ASN.1 Module Definition for the LDAP and X.500 Component Matching Rules

- [RFC 4104](https://docs.ldap.com/specs/rfc4104.txt): Policy Core Extension Lightweight Directory Access Protocol Schema (PCELS)
  Updates: [RFC 3703](https://docs.ldap.com/specs/rfc3703.txt)

- [RFC 4403](https://docs.ldap.com/specs/rfc4403.txt): Lightweight Directory Access Protocol (LDAP) Schema for Universal Description, Discovery, and Integration version 3 (UDDIv3)

- [RFC 4523](https://docs.ldap.com/specs/rfc4523.txt): Lightweight Directory Access Protocol (LDAP) Schema Definitions for X.509 Certificates
  Obsoletes: [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt), [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt), [RFC 2587](https://docs.ldap.com/specs/rfc2587.txt)

- [RFC 4792](https://docs.ldap.com/specs/rfc4792.txt): Encoding Instructions for the Generic String Encoding Rules (GSER)
  Updates: [RFC 3641](https://docs.ldap.com/specs/rfc3641.txt)

- [RFC 4876](https://docs.ldap.com/specs/rfc4876.txt): A Configuration Profile Schema for Lightweight Directory Access Protocol (LDAP)-Based Agents

- [RFC 5803](https://docs.ldap.com/specs/rfc5803.txt): Lightweight Directory Access Protocol (LDAP) Schema for Storing Salted Challenge Response Authentication Mechanism (SCRAM) Secrets

- [RFC 7612](https://docs.ldap.com/specs/rfc7612.txt): Lightweight Directory Access Protocol (LDAP) Schema for Printer Services
  Obsoletes: [RFC 3712](https://docs.ldap.com/specs/rfc3712.txt)

- [RFC 8284](https://docs.ldap.com/specs/rfc8284.txt): Lightweight Directory Access Protocol (LDAP) Schema for Supporting the Extensible Messaging and Presence Protocol (XMPP) in White Pages



## 7.Other Specifications

RFCs Containing Other Specifications Commonly Used in Conjunction with LDAP

- [RFC 1321](https://docs.ldap.com/specs/rfc1321.txt): The MD5 Message-Digest Algorithm
  Updated by: [RFC 6151](https://docs.ldap.com/specs/rfc6151.txt)

- [RFC 1964](https://docs.ldap.com/specs/rfc1964.txt): The Kerberos Version 5 GSS-API Mechanism

- [RFC 2104](https://docs.ldap.com/specs/rfc2104.txt): HMAC: Keyed-Hashing for Message Authentication
  Updated by: [RFC 6151](https://docs.ldap.com/specs/rfc6151.txt)

- [RFC 2605](https://docs.ldap.com/specs/rfc2605.txt): Directory Server Monitoring MIB
  Obsoletes: [RFC 1567](https://docs.ldap.com/specs/rfc1567.txt)

- [RFC 2743](https://docs.ldap.com/specs/rfc2743.txt): Generic Security Service API Version 2, Update 1
  Obsoletes: [RFC 2078](https://docs.ldap.com/specs/rfc2078.txt)

- [RFC 2744](https://docs.ldap.com/specs/rfc2744.txt): Generic Security Service API Version 2 : C-bindings
  Obsoletes: [RFC 1509](https://docs.ldap.com/specs/rfc1509.txt)

- [RFC 2782](https://docs.ldap.com/specs/rfc2782.txt): A DNS RR for specifying the location of services (DNS SRV)

- [RFC 2808](https://docs.ldap.com/specs/rfc2808.txt): The SecurID(r) SASL Mechanism

- [RFC 2831](https://docs.ldap.com/specs/rfc2831.txt): Using Digest Authentication as a SASL Mechanism
  Obsoleted by: [RFC 6331](https://docs.ldap.com/specs/rfc6331.txt)

- [RFC 2986](https://docs.ldap.com/specs/rfc2986.txt): PKCS #10: Certificate Request Syntax Specification Version 1.7

- [RFC 3174](https://docs.ldap.com/specs/rfc3174.txt): US Secure Hash Algorithm 1 (SHA1)
  Updated by: [RFC 4634](https://docs.ldap.com/specs/rfc4634.txt), [RFC 6234](https://docs.ldap.com/specs/rfc6234.txt)

- [RFC 3454](https://docs.ldap.com/specs/rfc3454.txt): Preparation of Internationalized Strings (“stringprep”)

- [RFC 4013](https://docs.ldap.com/specs/rfc4013.txt): SASLprep: Stringprep Profile for User Names and Passwords

- [RFC 4121](https://docs.ldap.com/specs/rfc4121.txt): The Kerberos Version 5 Generic Security Service Application Program Interface (GSS-API) Mechanism: Version 2
  Updates: [RFC 1964](https://docs.ldap.com/specs/rfc1964.txt)

- [RFC 4122](https://docs.ldap.com/specs/rfc4122.txt): A Universally Unique IDentifier (UUID) URN Resource

- [RFC 4226](https://docs.ldap.com/specs/rfc4226.txt): HOTP: An HMAC-Based One-Time Password Algorithm

- [RFC 4422](https://docs.ldap.com/specs/rfc4422.txt): Simple Authentication and Security Layer (SASL)
  Obsoletes: [RFC 2222](https://docs.ldap.com/specs/rfc2222.txt)

- [RFC 4505](https://docs.ldap.com/specs/rfc4505.txt): Anonymous Simple Authentication and Security Layer (SASL) Mechanism
  Obsoletes: [RFC 2245](https://docs.ldap.com/specs/rfc2245.txt)

- [RFC 4616](https://docs.ldap.com/specs/rfc4616.txt): The PLAIN Simple Authentication and Security Layer (SASL) Mechanism
  Obsoletes: [RFC 2595](https://docs.ldap.com/specs/rfc2595.txt)

- [RFC 4648](https://docs.ldap.com/specs/rfc4648.txt): The Base16, Base32, and Base64 Data Encodings

- [RFC 4752](https://docs.ldap.com/specs/rfc4752.txt): The Kerberos V5 (“GSSAPI”) Simple Authentication and Security Layer (SASL) Mechanism
  Obsoletes: [RFC 2222](https://docs.ldap.com/specs/rfc2222.txt)

- [RFC 5280](https://docs.ldap.com/specs/rfc5280.txt): Internet X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL) Profile

- [RFC 5802](https://docs.ldap.com/specs/rfc5802.txt): Salted Challenge Response Authentication Mechanism (SCRAM) SASL and GSS-API Mechanisms

- [RFC 5958](https://docs.ldap.com/specs/rfc5958.txt): Asymmetric Key Packages (PKCS #8)

- [RFC 6151](https://docs.ldap.com/specs/rfc6151.txt): Updated Security Considerations for the MD5 Message-Digest and the HMAC-MD5 Algorithms
  Updates: [RFC 1321](https://docs.ldap.com/specs/rfc1321.txt), [RFC 2104](https://docs.ldap.com/specs/rfc2104.txt)

- [RFC 6234](https://docs.ldap.com/specs/rfc6234.txt): US Secure Hash Algorithms (SHA and SHA-based HMAC and HKDF)
  Updates: [RFC 3174](https://docs.ldap.com/specs/rfc3174.txt)
  Obsoletes: [RFC 4634](https://docs.ldap.com/specs/rfc4634.txt)

- [RFC 6238](https://docs.ldap.com/specs/rfc6238.txt): TOTP: Time-Based One-Time Password Algorithm

- [RFC 6331](https://docs.ldap.com/specs/rfc6331.txt): Moving DIGEST-MD5 to Historic
  Obsoletes: [RFC 2831](https://docs.ldap.com/specs/rfc2831.txt)

- [RFC 6595](https://docs.ldap.com/specs/rfc6595.txt): A Simple Authentication and Security Layer (SASL) and GSS-API Mechanism for the Security Assertion Markup Language (SAML)

- [RFC 7292](https://docs.ldap.com/specs/rfc7292.txt): PKCS #12: Personal Information Exchange Syntax v1.1

- [RFC 7628](https://docs.ldap.com/specs/rfc7628.txt): A Set of Simple Authentication and Security Later (SASL) Mechanisms for OAuth

- [RFC 7677](https://docs.ldap.com/specs/rfc7677.txt): SCRAM-SHA-256 and SCRAM-SHA-256-PLUS Simple Authentication And Security Layer (SASL) Mechanisms

- [RFC 8017](https://docs.ldap.com/specs/rfc8017.txt): PKCS #1: RSA Cryptography Specifications Version 2.2

- [RFC 8353](https://docs.ldap.com/specs/rfc8353.txt): Generic Security Service API Version 2: Java Bindings Update
  Updates: [RFC 5653](https://docs.ldap.com/specs/rfc5653.txt)



## 8.Obsolete

Obsolete RFCs Provided for Informational Purposes

- [RFC 1274](https://docs.ldap.com/specs/rfc1274.txt): The COSINE and Internet X.500 Schema
  Obsoleted by: [RFC 4524](https://docs.ldap.com/specs/rfc4524.txt)

- [RFC 1484](https://docs.ldap.com/specs/rfc1484.txt): Using the OSI Directory to achieve User Friendly Naming
  Obsoleted by: [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1485](https://docs.ldap.com/specs/rfc1485.txt): A String Representation of Distinguished Names
  Obsoleted by: [RFC 1779](https://docs.ldap.com/specs/rfc1779.txt), [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1487](https://docs.ldap.com/specs/rfc1487.txt): X.500 Lightweight Directory Access Protocol
  Obsoleted by: [RFC 1777](https://docs.ldap.com/specs/rfc1777.txt), [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1488](https://docs.ldap.com/specs/rfc1488.txt): The X.500 String Representation of Standard Attribute Syntaxes
  Obsoleted by: [RFC 1778](https://docs.ldap.com/specs/rfc1778.txt)

- [RFC 1558](https://docs.ldap.com/specs/rfc1558.txt): A String Representation of LDAP Search Filters
  Obsoleted by: [RFC 1960](https://docs.ldap.com/specs/rfc1960.txt)

- [RFC 1567](https://docs.ldap.com/specs/rfc1567.txt): X.500 Directory Monitoring MIB
  Obsoleted by: [RFC 2605](https://docs.ldap.com/specs/rfc2605.txt)

- [RFC 1777](https://docs.ldap.com/specs/rfc1777.txt): Lightweight Directory Access Protocol
  Obsoletes: [RFC 1487](https://docs.ldap.com/specs/rfc1487.txt)
  Obsoleted by: [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1778](https://docs.ldap.com/specs/rfc1778.txt): The String Representation of Standard Attribute Syntaxes
  Obsoletes: [RFC 1488](https://docs.ldap.com/specs/rfc1488.txt)
  Updated by: [RFC 2559](https://docs.ldap.com/specs/rfc2559.txt)
  Obsoleted by: [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1779](https://docs.ldap.com/specs/rfc1779.txt): A String Representation of Distinguished Names
  Obsoleted by: [RFC 2253](https://docs.ldap.com/specs/rfc2253.txt), [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 1798](https://docs.ldap.com/specs/rfc1798.txt): Connection-less Lightweight X.500 Directory Access Protocol
  Obsoleted by: [RFC 3352](https://docs.ldap.com/specs/rfc3352.txt)

- [RFC 1959](https://docs.ldap.com/specs/rfc1959.txt): An LDAP URL Format
  Obsoleted by: [RFC 2255](https://docs.ldap.com/specs/rfc2255.txt)

- [RFC 1960](https://docs.ldap.com/specs/rfc1960.txt): A String Representation of LDAP Search Filters
  Obsoletes: [RFC 1558](https://docs.ldap.com/specs/rfc1558.txt)
  Obsoleted by: [RFC 2254](https://docs.ldap.com/specs/rfc2254.txt)

- [RFC 2222](https://docs.ldap.com/specs/rfc2222.txt): Simple Authentication and Security Layer (SASL)
  Obsoleted by: [RFC 4422](https://docs.ldap.com/specs/rfc4422.txt), [RFC 4752](https://docs.ldap.com/specs/rfc4752.txt)

- [RFC 2245](https://docs.ldap.com/specs/rfc2245.txt): Anonymous SASL Mechanism
  Obsoleted by: [RFC 4505](https://docs.ldap.com/specs/rfc4505.txt)

- [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt): Lightweight Directory Access Protocol (v3)
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt), [RFC 3771](https://docs.ldap.com/specs/rfc3771.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt), [RFC 4512](https://docs.ldap.com/specs/rfc4512.txt), [RFC 4513](https://docs.ldap.com/specs/rfc4513.txt)

- [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt): Lightweight Directory Access Protocol (v3): Attribute Syntax Definitions
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4512](https://docs.ldap.com/specs/rfc4512.txt), [RFC 4517](https://docs.ldap.com/specs/rfc4517.txt), [RFC 4523](https://docs.ldap.com/specs/rfc4523.txt)

- [RFC 2253](https://docs.ldap.com/specs/rfc2253.txt): Lightweight Directory Access Protocol (v3): UTF-8 String Representation of Distinguished Names
  Obsoletes: [RFC 1779](https://docs.ldap.com/specs/rfc1779.txt)
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4514](https://docs.ldap.com/specs/rfc4514.txt)

- [RFC 2254](https://docs.ldap.com/specs/rfc2254.txt): The String Representation of LDAP Search Filters
  Obsoletes: [RFC 1960](https://docs.ldap.com/specs/rfc1960.txt)
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4515](https://docs.ldap.com/specs/rfc4515.txt)

- [RFC 2255](https://docs.ldap.com/specs/rfc2255.txt): The LDAP URL Format
  Obsoletes: [RFC 1959](https://docs.ldap.com/specs/rfc1959.txt)
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4516](https://docs.ldap.com/specs/rfc4516.txt)

- [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt): A Summary of the X.500(96) User Schema for use with LDAPv3
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4512](https://docs.ldap.com/specs/rfc4512.txt), [RFC 4517](https://docs.ldap.com/specs/rfc4517.txt), [RFC 4519](https://docs.ldap.com/specs/rfc4519.txt), [RFC 4523](https://docs.ldap.com/specs/rfc4523.txt)

- [RFC 2559](https://docs.ldap.com/specs/rfc2559.txt): Internet X.590 Public Key Infrastructure Operational Protocols – LDAPv2
  Updates: [RFC 1778](https://docs.ldap.com/specs/rfc1778.txt)
  Obsoleted by: [RFC 3494](https://docs.ldap.com/specs/rfc3494.txt)

- [RFC 2587](https://docs.ldap.com/specs/rfc2587.txt): Internet X.590 Public Key Infrastructure LDAPv2 Schema
  Obsoleted by: [RFC 4523](https://docs.ldap.com/specs/rfc4523.txt)

- [RFC 2596](https://docs.ldap.com/specs/rfc2596.txt): Use of Language Codes in LDAP
  Obsoleted by: [RFC 3866](https://docs.ldap.com/specs/rfc3866.txt)

- [RFC 2829](https://docs.ldap.com/specs/rfc2829.txt): Authentication Methods for LDAP
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4513](https://docs.ldap.com/specs/rfc4513.txt)

- [RFC 2830](https://docs.ldap.com/specs/rfc2830.txt): Lightweight Directory Access Protocol (v3): Extension for Transport Layer Security
  Updated by: [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt), [RFC 4513](https://docs.ldap.com/specs/rfc4513.txt)

- [RFC 3377](https://docs.ldap.com/specs/rfc3377.txt): Lightweight Directory Access Protocol (v3): Technical Specification
  Updates: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt), [RFC 2252](https://docs.ldap.com/specs/rfc2252.txt), [RFC 2253](https://docs.ldap.com/specs/rfc2253.txt), [RFC 2254](https://docs.ldap.com/specs/rfc2254.txt), [RFC 2255](https://docs.ldap.com/specs/rfc2255.txt), [RFC 2256](https://docs.ldap.com/specs/rfc2256.txt), [RFC 2829](https://docs.ldap.com/specs/rfc2829.txt), [RFC 2830](https://docs.ldap.com/specs/rfc2830.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt)

- [RFC 3383](https://docs.ldap.com/specs/rfc3383.txt): Internet Assigned Numbers Authority (IANA) Considerations for the Lightweight Directory Access Protocol (LDAP)
  Obsoleted by: [RFC 4520](https://docs.ldap.com/specs/rfc4520.txt)

- [RFC 3674](https://docs.ldap.com/specs/rfc3674.txt): Feature Discovery in Lightweight Directory Access Protocol (LDAP)
  Obsoleted by: [RFC 4512](https://docs.ldap.com/specs/rfc4512.txt)

- [RFC 3712](https://docs.ldap.com/specs/rfc3712.txt): Lightweight Directory Access Protocol (LDAP): Schema for Printer Services
  Obsoleted by: [RFC 7612](https://docs.ldap.com/specs/rfc7612.txt)

- [RFC 3771](https://docs.ldap.com/specs/rfc3771.txt): The Lightweight Directory Access Protocol (LDAP) Intermediate Response Message
  Updates: [RFC 2251](https://docs.ldap.com/specs/rfc2251.txt)
  Obsoleted by: [RFC 4510](https://docs.ldap.com/specs/rfc4510.txt), [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt)

- [RFC 4634](https://docs.ldap.com/specs/rfc4634.txt): US Secure Hash Algorithms (SHA and HMAC-SHA)
  Updates: [RFC 3174](https://docs.ldap.com/specs/rfc3174.txt)
  Obsoleted by: [RFC 6234](https://docs.ldap.com/specs/rfc6234.txt)



## 9.`./rfc_2_4_44/`

是openldap-2.4源码包 附带的 rfc TXT文档：

https://github.com/openldap/openldap/tree/master/doc/rfc 

https://github.com/openldap/openldap/tree/OPENLDAP_REL_ENG_2_4_44/doc/rfc 





## 参考

[LDAP-Related RFCs](https://ldap.com/ldap-related-rfcs/) 

