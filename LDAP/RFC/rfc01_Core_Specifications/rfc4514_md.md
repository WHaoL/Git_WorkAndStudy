





Network Working Group                                   K. Zeilenga, Ed.
Request for Comments: 4514                           OpenLDAP Foundation
Obsoletes: 2253                                                June 2006
Category: Standards Track


# Lightweight Directory Access Protocol (LDAP): String Representation of Distinguished Names(DN的字符串表示)

## Status of This Memo(略)

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.

## Copyright Notice

   Copyright (C) The Internet Society (2006).

# Abstract(摘要)

The X.500 Directory uses distinguished names (DNs) as primary keys to entries in the directory.  This document defines the string representation used in the Lightweight Directory Access Protocol (LDAP) to transfer distinguished names.  The string representation is designed to give a clean representation of commonly used distinguished names, while being able to represent any distinguished name.
X.500目录使用 专有名称(DN) 作为目录中条目的主键。
本文档定义了 轻量级目录访问协议(LDAP) 中用于传输 专有名称的 字符串表示形式。
字符串表示旨在提供常用可分辨名称的清晰表示，同时能够表示任何可分辨名称。



# 1.  Background and Intended Usage

In X.500-based directory systems [X.500], including those accessed using the Lightweight Directory Access Protocol (LDAP) [RFC4510], distinguished names (DNs) are used to unambiguously refer to directory entries [X.501][RFC4512].
在基于X.500的目录系统[X.500]中，
包括使用轻量级目录访问协议(LDAP)[RFC4510]访问的目录系统，
专有名称 (DN) 用于明确地引用目录条目 [X.501][RFC4512] ]。

The structure of a DN [X.501] is described in terms of ASN.1 [X.680]. In the X.500 Directory Access Protocol [X.511] (and other ITU-defined directory protocols), DNs are encoded using the Basic Encoding Rules (BER) [X.690].  In LDAP, DNs are represented in the string form described in this document.
DN[X.501]的结构  根据 ASN.1[X.680] 进行描述。
在X.500目录访问协议[X.511]（和其他ITU定义的目录协议）中，DN 使用 基本编码规则(BER)[X.690] 进行编码。
在LDAP中，DN 以  本文档中描述的字符串形式 表示。

It is important to have a common format to be able to unambiguously represent a distinguished name.  The primary goal of this specification is ease of encoding and decoding.  A secondary goal is to have names that are human readable.  It is not expected that LDAP implementations with a human user interface would display these strings directly to the user, but that they would most likely be performing translations (such as expressing attribute type names in the local national language).
重要的是 有一个通用格式 能够明确地表示一个专有名称。
本规范的主要目标是：易于编码和解码。
第二个目标是：拥有人类可读的名称。
带有人工用户界面的LDAP实现 不会直接向用户显示这些字符串，但它们很可能会执行翻译（例如用当地国家语言表达属性类型名称）。

This document defines the string representation of Distinguished Names used in LDAP [RFC4511][RFC4517].  Section 2 details the RECOMMENDED algorithm for converting a DN from its ASN.1 structured representation to a string.  Section 3 details how to convert a DN from a string to an ASN.1 structured representation.
本文档定义了 LDAP [RFC4511][RFC4517] 中使用的专有名称的字符串表示。
第 2 节详细介绍了  RECOMMENDED算法： 将DN 从其 ASN.1结构化表示 转换为字符串。
第 3 节详细介绍了：如何将DN 从字符串 转换为 ASN.1结构化表示。

While other documents may define other algorithms for converting a DN from its ASN.1 structured representation to a string, all algorithms MUST produce strings that adhere to the requirements of Section 3.
虽然其他文档可能定义其他算法：将DN 从其ASN.1结构化表示  转换为字符串，
但所有算法都必须生成符合第 3 节要求的字符串。

This document does not define a canonical string representation for DNs.  Comparison of DNs for equality is to be performed in accordance with the distinguishedNameMatch matching rule [RFC4517].
本文档未定义 DN的 规范化字符串表示。
DN的相等性比较将根据 distinctNameMatch 匹配规则 [RFC4517] 执行。

This document is a integral part of the LDAP technical specification [RFC4510], which obsoletes the previously defined LDAP technical specification, RFC 3377, in its entirety.  This document obsoletes RFC 2253.  Changes since RFC 2253 are summarized in Appendix B.
本文档是 LDAP 技术规范 [RFC4510] 的组成部分，它完全废弃了先前定义的 LDAP技术规范 RFC 3377。
本文档废弃了 RFC 2253。
附录 B 总结了自 RFC 2253 以来的变化。

This specification assumes familiarity with X.500 [X.500] and the concept of Distinguished Name [X.501][RFC4512].
本规范假定熟悉 X.500[X.500] 和专有名称[X.501][RFC4512] 的概念。


## 1.1.  Conventions(略)

   The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].

   Character names in this document use the notation for code points and names from the Unicode Standard [Unicode].  For example, the letter "a" may be represented as either <U+0061> or <LATIN SMALL LETTER A>.

   Note: a glossary of terms used in Unicode can be found in [Glossary]. Information on the Unicode character encoding model can be found in [CharModel].



# 2.  Converting DistinguishedName from ASN.1 to a String(将DN从ASN.1转换为string)

X.501 [X.501] defines the ASN.1 [X.680] structure of distinguished name.  The following is a variant provided for discussion purposes.
X.501[X.501] 定义了 可分辨名称(DN)的 ASN.1[X.680]结构。以下是为讨论目的而提供的变体。

```
      DistinguishedName ::= RDNSequence

      RDNSequence ::= SEQUENCE OF RelativeDistinguishedName

      RelativeDistinguishedName ::= SET SIZE (1..MAX) OF
          AttributeTypeAndValue

      AttributeTypeAndValue ::= SEQUENCE {
          type  AttributeType,
          value AttributeValue }
```
This section defines the RECOMMENDED algorithm for converting a distinguished name from an ASN.1-structured representation to a UTF-8 [RFC3629] encoded Unicode [Unicode] character string representation. Other documents may describe other algorithms for converting a distinguished name to a string, but only strings that conform to the grammar defined in Section 3 SHALL be produced by LDAP   implementations.
本节定义了RECOMMENDED算法，用于将可分辨名称 从ASN.1结构化表示 转换为 UTF-8[RFC3629]编码的Unicode[Unicode]字符串表示。
其他文档可能会描述 将专有名称转换为字符串 的其他算法，
但只有符合第 3 节中定义的语法的字符串 才能由LDAP实现生成。

总结：RECOMMENDED算法，用于将可分辨名称 从ASN.1结构化表示 转换为 字符串表示。



## 2.1.  Converting the RDNSequence(转换RDN序列)

If the RDNSequence is an empty sequence, the result is the empty or zero-length string.
如果RDNSequence是空序列，则结果是 空字符串或零长度字符串。

Otherwise, the output consists of the string encodings of each RelativeDistinguishedName in the RDNSequence (according to Section 2.2), starting with the last element of the sequence and moving backwards toward the first.
否则，输出由  RDNSequence中每个 RelativeDistinguishedName的字符串编码 组成(根据第2.2节)，从序列的最后一个元素开始，向后移动到第一个元素。

The encodings of adjoining RelativeDistinguishedNames are separated by a comma (',' U+002C) character.
相邻的 RelativeDistinguishedNames 的编码由逗号(',' U+002C)字符分隔。

总结：
   将RDNSequence转换为string时，即为 将RDNSequence中的 每个RelativeDistinguishedName的字符串编码 输出；
   相邻的RelativeDistinguishedNames，使用','分隔。



## 2.2.  Converting RelativeDistinguishedName

When converting from an ASN.1 RelativeDistinguishedName to a string, the output consists of the string encodings of each AttributeTypeAndValue (according to Section 2.3), in any order.
当从 ASN.1 RelativeDistinguishedName 转换为字符串时，输出由每个 AttributeTypeAndValue的字符串编码组成（根据第 2.3 节），按任何顺序排列。

Where there is a multi-valued RDN, the outputs from adjoining AttributeTypeAndValues are separated by a plus sign ('+' U+002B) character.
在存在多值 RDN 的情况下，相邻 AttributeTypeAndValues 的输出由加号 ('+' U+002B) 字符分隔。

总结：
   将ASN.1形式的RelativeDistinguishedName转换为string时，即为 输出每个AttributeTypeAndValue的字符串编码；
   RDN是多值时，AttributeTypeAndValues之间使用'+'分隔。



## 2.3.  Converting AttributeTypeAndValue

The AttributeTypeAndValue is encoded as the string representation of the AttributeType, followed by an equals sign ('=' U+003D) character, followed by the string representation of the AttributeValue.  The encoding of the AttributeValue is given in Section 2.4.
AttributeTypeAndValue被编码为：
AttributeType的字符串表示形式，后跟等号('=' U+003D)字符，然后是 AttributeValue的字符串表示形式。
AttributeValue 的编码在第 2.4 节中给出。

If the AttributeType is defined to have a short name (descriptor) [RFC4512] and that short name is known to be registered [REGISTRY] [RFC4520] as identifying the AttributeType, that short name, a <descr>, is used.  Otherwise the AttributeType is encoded as the dotted-decimal encoding, a <numericoid>, of its OBJECT IDENTIFIER. The <descr> and <numericoid> are defined in [RFC4512].
如果 AttributeType 定义为具有短名称（描述符）[RFC4512]，并且已知 该短名称已注册[REGISTRY] [RFC4520]作为标识 AttributeType，则使用该短名称，<descr>。
否则，AttributeType 被编码为它的 OBJECT IDENTIFIER 的点分十进制编码，一个 <numericoid>。
<descr> 和 <numericoid> 在 [RFC4512] 中定义。

Implementations are not expected to dynamically update their knowledge of registered short names.  However, implementations SHOULD provide a mechanism to allow their knowledge of registered short names to be updated.
实现不会动态更新他们对注册短名称的了解。
但是，实现应该提供一种机制来允许更新他们对注册短名称的了解。

总结：
   AttributeTypeAndValue的字符串表示即为：AttributeType的字符串表示， 后跟'=', 后跟 AttributeValue的字符串表示。
   如果AttributeType有短名称，那么使用该短名称；否则 被编码为它的 OID。



## 2.4.  Converting an AttributeValue from ASN.1 to a String

If the AttributeType is of the dotted-decimal form, the AttributeValue is represented by an number sign ('#' U+0023) character followed by the hexadecimal encoding of each of the octets of the BER encoding of the X.500 AttributeValue.  This form is also used when the syntax of the AttributeValue does not have an LDAP-specific ([RFC4517], Section 3.1) string encoding defined for it, or the LDAP-specific string encoding is not restricted to UTF-8-encoded Unicode characters.  This form may also be used in other cases, such as when a reversible string representation is desired (see Section 5.2).
如果AttributeType是点分十进制形式，
 则AttributeValue由数字符号('#' U+0023)字符 后跟X.500 AttributeValue的BER编码的 每个八位字节的十六进制编码表示。
 当AttributeValue的语法 没有为其定义的特定于LDAP([RFC4517]，第3.1节)的字符串编码，或者特定于LDAP的字符串编码不限于UTF-8编码的Unicode字符时，也会使用这种形式. 这种形式也可用于其他情况，例如需要可逆字符串表示时（参见第 5.2 节）。

Otherwise, if the AttributeValue is of a syntax that has a LDAP-specific string encoding, the value is converted first to a UTF-8-encoded Unicode string according to its syntax specification (see [RFC4517], Section 3.3, for examples).  If that UTF-8-encoded Unicode string does not have any of the following characters that need escaping, then that string can be used as the string representation of the value.
否则，如果AttributeValue的语法具有 LDAP特定的字符串编码，则该值首先根据其语法规范转换为 UTF-8编码的Unicode字符串（示例参见[RFC4517]，第3.3节）。
如果该 UTF-8编码的Unicode字符串没有以下任何需要转义的字符，则该字符串可用作该值的字符串表示形式。

 - a space (' ' U+0020) or number sign ('#' U+0023) occurring at the beginning of the string;
 出现在字符串开头的 空格(' ' U+0020)  或 数字符号('#' U+0023)；
    
 - a space (' ' U+0020) character occurring at the end of the string;
 出现在字符串末尾的 空格(' ' U+0020) 字符；

 - one of the characters '"', '+', ',', ';', '<', '>',  or '\' (U+0022, U+002B, U+002C, U+003B, U+003C, U+003E, or U+005C, respectively);
 字符'"', '+', ',', ';', '<', '>', 或 '\'(分别为U+0022, U+002B, U+002C, U+003B, U+003C, U+003E, or U+005C);
    
 - the null (U+0000) character.
 空(U+0000)字符。

Other characters may be escaped.
其他字符可能会被转义。

Each octet of the character to be escaped is replaced by a backslash and two hex digits, which form a single octet in the code of the character.  Alternatively, if and only if the character to be escaped is one of
要转义的字符的每个八位字节 都被一个反斜杠和两个十六进制数字替换，它们在字符的代码/编码中形成了一个八位字节。
或者，当且仅当要转义的字符是以下字符之一

```
      ' ', '"', '#', '+', ',', ';', '<', '=', '>', or '\'
      (U+0020, U+0022, U+0023, U+002B, U+002C, U+003B,
       U+003C, U+003D, U+003E, U+005C, respectively)
```
it can be prefixed by a backslash ('\' U+005C).
它可以以 反斜杠('\' U+005C) 为前缀。

Examples of the escaping mechanism are shown in Section 4.
第 4 节显示了转义机制的示例。



# 3.  Parsing a String Back to a Distinguished Name(将string解析回DN)

The string representation of Distinguished Names is restricted to UTF-8 [RFC3629] encoded Unicode [Unicode] characters.  The structure of this string representation is specified using the following Augmented BNF [RFC4234] grammar:
专有名称(DN)的字符串表示仅限于 UTF-8[RFC3629]编码的Unicode[Unicode]字符。
此字符串表示的结构使用以下增强 BNF [RFC4234] 语法指定：

```ABNF
      distinguishedName = [ relativeDistinguishedName
          *( COMMA relativeDistinguishedName ) ]
      relativeDistinguishedName = attributeTypeAndValue
          *( PLUS attributeTypeAndValue )
      attributeTypeAndValue = attributeType EQUALS attributeValue
      attributeType = descr / numericoid
      attributeValue = string / hexstring

      ; The following characters are to be escaped when they appear
      ; in the value to be encoded: ESC, one of <escaped>, leading
      ; SHARP or SPACE, trailing SPACE, and NULL.
      ; 当以下字符出现在要编码的值中时，需要转义: '\'、<转义>之一、开头是#或空格、结尾是空格、和NULL。
      string =   [ ( leadchar / pair ) [ *( stringchar / pair )
         ( trailchar / pair ) ] ]

      leadchar = LUTF1 / UTFMB
      LUTF1 = %x01-1F / %x21 / %x24-2A / %x2D-3A /
         %x3D / %x3F-5B / %x5D-7F

      trailchar  = TUTF1 / UTFMB
      TUTF1 = %x01-1F / %x21 / %x23-2A / %x2D-3A /
         %x3D / %x3F-5B / %x5D-7F

      stringchar = SUTF1 / UTFMB
      SUTF1 = %x01-21 / %x23-2A / %x2D-3A /
         %x3D / %x3F-5B / %x5D-7F

      pair = ESC ( ESC\ / special / hexpair )
      special = escaped / SPACE' ' / SHARP# / EQUALS=
      escaped = DQUOTE" / PLUS+ / COMMA, / SEMI; / LANGLE< / RANGLE>
      hexstring = SHARP# 1*hexpair
      hexpair = HEX HEX("0"-"9" / "A"-"F" / "a"-"f")
```
```text
总结： 
   DN的字符串表示，仅限于UTF8编码的Unicode字符
   DN = RDN [ ',' RDN ] ...
   RDN = attributeTypeAndValue [ '+' attributeTypeAndValue ] ...
   attributeTypeAndValue = attributeType '=' attributeValue
   attributeType = descr(短名称) / numericoid(点分十进制OID)
   attributeValue = string(字符串) / hexstring()
      如果attributeType是 点分十进制，
         那么AttributeValue= '#' 后跟 AttributeValue的BER编码的16进制表示
```
where the productions <descr>, <numericoid>, <COMMA>, <DQUOTE>, <EQUALS>, <ESC>, <HEX>, <LANGLE>, <NULL>, <PLUS>, <RANGLE>, <SEMI>, <SPACE>, <SHARP>, and <UTFMB> are defined in [RFC4512].
...在 [RFC4512] 中定义。
COMMA是','

Each <attributeType>, either a <descr> or a <numericoid>, refers to an attribute type of an attribute value assertion (AVA).  The <attributeType> is followed by an <EQUALS> and an <attributeValue>. The <attributeValue> is either in <string> or <hexstring> form.
每个<attributeType>，无论是<descr> 还是<numericoid>，都指代一个属性值断言(AVA)的属性类型。
<attributeType> 后跟一个 <EQUALS> 和一个 <attributeValue>。
<attributeValue> 采用 <string> 或 <hexstring> 形式。

If in <string> form, a LDAP string representation asserted value can be obtained by replacing (left to right, non-recursively) each <pair> appearing in the <string> as follows:
如果采用 <string> 形式，可以通过替换(从左到右，非递归)出现在<string>中的每个<pair> 来获得LDAP字符串表示断言值，
如下所示：
```
      replace <ESC><ESC> with <ESC>;
      replace <ESC><special> with <special>;
      replace <ESC><hexpair> with the octet indicated by the <hexpair>.
```
If in <hexstring> form, a BER representation can be obtained from converting each <hexpair> of the <hexstring> to the octet indicated by the <hexpair>.
如果采用 <hexstring> 形式，则可以通过将 <hexstring> 的每个 <hexpair> 转换为 <hexpair> 指示的八位字节来获得 BER 表示。

There is one or more attribute value assertions, separated by <PLUS>, for a relative distinguished name.
对于相对专有名称，有一个或多个属性值断言，由 <PLUS> 分隔。

There is zero or more relative distinguished names, separated by <COMMA>, for a distinguished name.
对于一个专有名称，有零个或多个相对专有名称，由 <COMMA> 分隔。

Implementations MUST recognize AttributeType name strings (descriptors) listed in the following table, but MAY recognize other name strings.
实现必须识别  下表中列出的 AttributeType名称字符串（描述符）(即 短名称)，但可以识别其他名称字符串。
```
      String  X.500 AttributeType
      ------  --------------------------------------------
      CN      commonName (2.5.4.3)
      L       localityName (2.5.4.7)
      ST      stateOrProvinceName (2.5.4.8)
      O       organizationName (2.5.4.10)
      OU      organizationalUnitName (2.5.4.11)
      C       countryName (2.5.4.6)
      STREET  streetAddress (2.5.4.9)
      DC      domainComponent (0.9.2342.19200300.100.1.25)
      UID     userId (0.9.2342.19200300.100.1.1)
```
These attribute types are described in [RFC4519].
这些属性类型在 [RFC4519] 中描述。

Implementations MAY recognize other DN string representations. However, as there is no requirement that alternative DN string representations be recognized (and, if so, how), implementations SHOULD only generate DN strings in accordance with Section 2 of this document.
实现可以识别 其他DN字符串表示。
然而，不要求识别 替代的 DN字符串表示（以及，如果是，如何识别），
实现应该只根据本文档的第2节 生成 DN字符串。



# 4.  Examples(例子)

This notation is designed to be convenient for common forms of name. This section gives a few examples of distinguished names written using this notation.  First is a name containing three relative distinguished names (RDNs):
这种表示法 旨在 方便名称的常见形式。
本节给出了一些使用这种表示法编写的专有名称示例。

第一个是包含三个相对可分辨名称 (RDN) 的名称：
```
      UID=jsmith,DC=example,DC=net
```

Here is an example of a name containing three RDNs, in which the first RDN is multi-valued:
下面是一个包含三个 RDN 的名称示例，其中第一个 RDN 是多值的：
```
      OU=Sales+CN=J.  Smith,DC=example,DC=net
```

This example shows the method of escaping of a special characters appearing in a common name:
此示例显示了对常见名称中出现的特殊字符进行转义的方法：
```
      CN=James \"Jim\" Smith\, III,DC=example,DC=net
```

The following shows the method for encoding a value that contains a carriage return character:
下面显示了对 包含回车符的值 进行编码的方法：
```
      CN=Before\0dAfter,DC=example,DC=net
```

In this RDN example, the type in the RDN is unrecognized, and the value is the BER encoding of an OCTET STRING containing two octets, 0x48 and 0x69.
在此 RDN 示例中，RDN中的类型无法识别，值是包含两个八位字节 0x48 和 0x69 的八位字节串的 BER编码。
```
      1.3.6.1.4.1.1466.0=#04024869
```

Finally, this example shows an RDN whose commonName value consists of 5 letters:
最后，此示例显示了一个 RDN，其 commonName 值由 5 个字母组成：
```
      Unicode Character                Code       UTF-8   Escaped
      -------------------------------  ------     ------  --------
      LATIN CAPITAL LETTER L           U+004C     0x4C    L
      LATIN SMALL LETTER U             U+0075     0x75    u
      LATIN SMALL LETTER C WITH CARON  U+010D     0xC48D  \C4\8D
      LATIN SMALL LETTER I             U+0069     0x69    i
      LATIN SMALL LETTER C WITH ACUTE  U+0107     0xC487  \C4\87
```

This could be encoded in printable ASCII [ASCII] (useful for debugging purposes) as:
这可以用可打印的 ASCII [ASCII]（用于调试目的）编码为：
```
      CN=Lu\C4\8Di\C4\87
```



# 5.  Security Considerations安全注意事项

The following security considerations are specific to the handling of distinguished names.  LDAP security considerations are discussed in [RFC4511] and other documents comprising the LDAP Technical Specification [RFC4510].
以下安全注意事项特定于可分辨名称的处理。
LDAP 安全考虑在 [RFC4511] 和包含 LDAP 技术规范 [RFC4510] 的其他文档中讨论。


## 5.1.  Disclosure披露

Distinguished Names typically consist of descriptive information about the entries they name, which can be people, organizations, devices, or other real-world objects.  This frequently includes some of the following kinds of information:
专有名称通常由 条目的描述性信息组成，这些条目可以是人、组织、设备或其他现实世界的对象。
这通常包括以下一些类型的信息：

 - the common name of the object (i.e., a person's full name)
 对象的通用名称（即一个人的全名）
 - an email or TCP/IP address
 电子邮件或 TCP/IP地址
 - its physical location (country, locality, city, street address)
 它的实际位置（国家、地区、城市、街道地址）
 - organizational attributes (such as department name or affiliation)
 组织属性（例如部门名称或隶属关系）

In some cases, such information can be considered sensitive.  In many countries, privacy laws exist that prohibit disclosure of certain kinds of descriptive information (e.g., email addresses).  Hence, server implementers are encouraged to support Directory Information Tree (DIT) structural rules and name forms [RFC4512], as these provide a mechanism for administrators to select appropriate naming attributes for entries.  Administrators are encouraged to use mechanisms, access controls, and other administrative controls that may be available to restrict use of attributes containing sensitive information in naming of entries.   Additionally, use of authentication and data security services in LDAP [RFC4513][RFC4511] should be considered.
在某些情况下，此类信息可被视为敏感信息。
在许多国家/地区，存在禁止披露某些类型的描述性信息（例如，电子邮件地址）的隐私法。
因此，鼓励服务器实现者支持目录信息树(DIT)结构规则和名称形式[RFC4512]，因为它们为管理员提供了一种 为条目选择适当的命名属性 的机制。
鼓励管理员使用机制、访问控制和其他可能可用的管理控制 来限制在条目命名中使用包含敏感信息的属性。
此外，还应考虑在 LDAP [RFC4513] [RFC4511] 中使用身份验证和数据安全服务。



## 5.2.  Use of Distinguished Names in Security Applications 在安全应用程序中使用DN

The transformations of an AttributeValue value from its X.501 form to an LDAP string representation are not always reversible back to the same BER (Basic Encoding Rules) or DER (Distinguished Encoding Rules) form.  An example of a situation that requires the DER form of a distinguished name is the verification of an X.509 certificate.
将AttributeValue的值 从其X.501形式 转到 LDAP字符串表示， 并不总能够 可逆的 转换回相同的 BER(基本编码规则)或 DER(可分辨编码规则)形式。
需要可分辨名称的 DER形式 的情况 的一个示例是 X.509证书的验证。

For example, a distinguished name consisting of one RDN with one AVA, in which the type is commonName and the value is of the TeletexString choice with the letters 'Sam', would be represented in LDAP as the string <CN=Sam>.  Another distinguished name in which the value is still 'Sam', but is of the PrintableString choice, would have the same representation <CN=Sam>.
例如，一个由一个 RDN 和一个 AVA 组成的专有名称，其中类型是 commonName，值是带有字母“Sam”的 TeletexString选项，在 LDAP 中将表示为字符串 <CN=Sam>。
另一个值仍为“Sam”但属于 PrintableString选项 ，将具有相同的表示形式 <CN=Sam>。

Applications that require the reconstruction of the DER form of the value SHOULD NOT use the string representation of attribute syntaxes when converting a distinguished name to the LDAP format.  Instead, they SHOULD use the hexadecimal form prefixed by the number sign ('#' U+0023) as described in the first paragraph of Section 2.4.
在将专有名称转换为 LDAP格式时，需要重构 值的DER形式 的应用程序 不应使用属性语法的字符串表示。
相反，它们应该使用以数字符号 ('#' U+0023) 为前缀的十六进制形式，如第 2.4 节的第一段中所述。



# 6.  Acknowledgements(略)

This document is an update to RFC 2253, by Mark Wahl, Tim Howes, and Steve Kille.  RFC 2253 was a product of the IETF ASID Working Group.
本文档是对 RFC 2253 的更新，作者是 Mark Wahl、Tim Howes 和 Steve Kille。RFC 2253 是 IETF ASID 工作组的产品。

This document is a product of the IETF LDAPBIS Working Group.
本文档是 IETF LDAPBIS 工作组的产品。



# 7.  References(略)

7.1.  Normative References

   [REGISTRY]    IANA, Object Identifier Descriptors Registry,
                 <http://www.iana.org/assignments/ldap-parameters>.

   [Unicode]     The Unicode Consortium, "The Unicode Standard, Version
                 3.2.0" is defined by "The Unicode Standard, Version
                 3.0" (Reading, MA, Addison-Wesley, 2000.  ISBN 0-201-
                 61633-5), as amended by the "Unicode Standard Annex
                 #27: Unicode 3.1"
                 (http://www.unicode.org/reports/tr27/) and by the
                 "Unicode Standard Annex #28: Unicode 3.2"
                 (http://www.unicode.org/reports/tr28/).

   [X.501]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Models," X.501(1993) (also ISO/IEC 9594-
                 2:1994).

   [X.680]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "Abstract
                 Syntax Notation One (ASN.1) - Specification of Basic
                 Notation", X.680(1997) (also ISO/IEC 8824-1:1998).

   [RFC2119]     Bradner, S., "Key words for use in RFCs to Indicate
                 Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC3629]     Yergeau, F., "UTF-8, a transformation format of ISO
                 10646", STD 63, RFC 3629, November 2003.

   [RFC4234]     Crocker, D. and P. Overell, "Augmented BNF for Syntax
                 Specifications: ABNF", RFC 4234, October 2005.

   [RFC4510]     Zeilenga, K., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Technical Specification Road Map", RFC
                 4510, June 2006.

   [RFC4511]     Sermersheim, J., Ed., "Lightweight Directory Access
                 Protocol (LDAP): The Protocol", RFC 4511, June 2006.

   [RFC4512]     Zeilenga, K., "Lightweight Directory Access Protocol
                 (LDAP): Directory Information Models", RFC 4512, June
                 2006.

   [RFC4513]     Harrison, R., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Authentication Methods and Security
                 Mechanisms", RFC 4513, June 2006.

   [RFC4517]     Legg, S., Ed., "Lightweight Directory Access Protocol
                 (LDAP): Syntaxes and Matching Rules", RFC 4517, June
                 2006.

   [RFC4519]     Sciberras, A., Ed., "Lightweight Directory Access
                 Protocol (LDAP): Schema for User Applications", RFC
                 4519, June 2006.

   [RFC4520]     Zeilenga, K., "Internet Assigned Numbers Authority
                 (IANA) Considerations for the Lightweight Directory
                 Access Protocol (LDAP)", BCP 64, RFC 4520, June 2006.

7.2.  Informative References

   [ASCII]       Coded Character Set--7-bit American Standard Code for
                 Information Interchange, ANSI X3.4-1986.

   [CharModel]   Whistler, K. and M. Davis, "Unicode Technical Report
                 #17, Character Encoding Model", UTR17,
                 <http://www.unicode.org/unicode/reports/tr17/>, August
                 2000.

   [Glossary]    The Unicode Consortium, "Unicode Glossary",
                 <http://www.unicode.org/glossary/>.

   [X.500]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory -- Overview of concepts, models and
                 services," X.500(1993) (also ISO/IEC 9594-1:1994).

   [X.511]       International Telecommunication Union -
                 Telecommunication Standardization Sector, "The
                 Directory: Abstract Service Definition", X.511(1993)
                 (also ISO/IEC 9594-3:1993).

   [X.690]       International Telecommunication Union -
                 Telecommunication Standardization Sector,
                 "Specification of ASN.1 encoding rules: Basic Encoding
                 Rules (BER), Canonical Encoding Rules (CER), and
                 Distinguished Encoding Rules (DER)", X.690(1997) (also
                 ISO/IEC 8825-1:1998).

   [RFC2849]     Good, G., "The LDAP Data Interchange Format (LDIF) -
                 Technical Specification", RFC 2849, June 2000.



# Appendix A.  Presentation Issues

This appendix is provided for informational purposes only; it is not a normative part of this specification.
本附录仅供参考；它不是本规范的规范部分。

The string representation described in this document is not intended to be presented to humans without translation.  However, at times it may be desirable to present non-translated DN strings to users.  This section discusses presentation issues associated with non-translated DN strings.  Issues with presentation of translated DN strings are not discussed in this appendix.  Transcoding issues are also not discussed in this appendix.
本文档中描述的字符串表示 不打算在没有翻译的情况下呈现给人类。
但是，有时可能需要向用户显示未翻译的 DN 字符串。
本节讨论与 非/未翻译DN字符串相关的表示问题。
本节不讨论 翻译DN字符串表示 相关的问题。
本附录也不讨论转码问题。

This appendix provides guidance for applications presenting DN strings to users.  This section is not comprehensive; it does not discuss all presentation issues that implementers may face.
本附录为 向用户呈现 DN 字符串的应用程序提供指导。
本节不全面；它没有讨论实施者可能面临的所有演示问题。

Not all user interfaces are capable of displaying the full set of Unicode characters.  Some Unicode characters are not displayable.
并非所有用户界面都能够显示完整的 Unicode 字符集。
某些 Unicode 字符无法显示。

It is recommended that human interfaces use the optional hex pair escaping mechanism (Section 2.3) to produce a string representation suitable for display to the user.  For example, an application can generate a DN string for display that escapes all non-printable characters appearing in the AttributeValue's string representation (as demonstrated in the final example of Section 4).
建议人机界面使用可选的十六进制对转义机制（第 2.3 节）来生成适合显示给用户的字符串表示。
例如，应用程序可以生成用于显示的 DN 字符串，该字符串转义出现在 AttributeValue 的字符串表示中的所有不可打印字符（如第 4 节的最后一个示例所示）。

When a DN string is displayed in free-form text, it is often necessary to distinguish the DN string from surrounding text.  While this is often done with whitespace (as demonstrated in Section 4), it is noted that DN strings may end with whitespace.  Careful readers of Section 3 will note that the characters '<' (U+003C) and '>' (U+003E) may only appear in the DN string if escaped.  These characters are intended to be used in free-form text to distinguish a DN string from surrounding text.  For example, <CN=Sam\ > distinguishes the string representation of the DN composed of one RDN consisting of the AVA (the commonName (CN) value 'Sam ') from the surrounding text.  It should be noted to the user that the wrapping '<' and '>' characters are not part of the DN string.
当以自由格式文本显示 DN 字符串时，通常需要将 DN 字符串与周围的文本区分开来。
虽然这通常是用空格完成的（如第 4 节所示），但需要注意的是 DN 字符串可能以空格结尾。
仔细阅读第 3 节的读者会注意到，字符 '<' (U+003C) 和 '>' (U+003E) 可能仅在转义后出现在 DN 字符串中。
这些字符旨在用于自由格式文本，以将 DN 字符串与周围的文本区分开来。
例如，<CN=Sam\ > 区分由一个 RDN 组成的 DN 的字符串表示形式，该 RDN 由 AVA（commonName (CN) 值“Sam”）与周围的文本组成。用户应该注意的是，环绕的 '<' 和 '>' 字符不是 DN 字符串的一部分。

DN strings can be quite long.  It is often desirable to line-wrap overly long DN strings in presentations.  Line wrapping should be done by inserting whitespace after the RDN separator character or, if necessary, after the AVA separator character.  It should be noted to the user that the inserted whitespace is not part of the DN string and is to be removed before use in LDAP.  For example, the following DN string is long:
DN 字符串可能很长。
通常需要在演示文稿中换行过长的 DN 字符串。
换行应该通过在 RDN 分隔符之后插入空格来完成，或者，如有必要，在 AVA 分隔符之后插入空格。
应向用户注意，插入的空格不是 DN 字符串的一部分，在 LDAP 中使用之前将被删除。
例如，以下 DN 字符串很长：
```
         CN=Kurt D.  Zeilenga,OU=Engineering,L=Redwood Shores,
         O=OpenLDAP Foundation,ST=California,C=US
```
So it has been line-wrapped for readability.  The extra whitespace is to be removed before the DN string is used in LDAP.
所以为了可读性，它被换行了。
在 LDAP 中使用 DN 字符串之前，将删除多余的空格。

Inserting whitespace is not advised because it may not be obvious to the user which whitespace is part of the DN string and which whitespace was added for readability.
不建议插入空格，因为用户可能不清楚哪些空格是 DN 字符串的一部分，哪些空格是为了可读性而添加的。

Another alternative is to use the LDAP Data Interchange Format (LDIF) [RFC2849].  For example:
另一种替代方法是使用 LDAP 数据交换格式 (LDIF) [RFC2849]。例如：
```ldif
         # This entry has a long DN...
         dn: CN=Kurt D.  Zeilenga,OU=Engineering,L=Redwood Shores,
          O=OpenLDAP Foundation,ST=California,C=US
         CN: Kurt D.  Zeilenga
         SN: Zeilenga
         objectClass: person
```



# Appendix B.  Changes Made since RFC 2253(略)

   This appendix is provided for informational purposes only, it is not a normative part of this specification.

   The following substantive changes were made to RFC 2253:

      - Removed IESG Note.  The IESG Note has been addressed.
      - Replaced all references to ISO 10646-1 with [Unicode].
      - Clarified (in Section 1) that this document does not define a
        canonical string representation.
      - Clarified that Section 2 describes the RECOMMENDED encoding
        algorithm and that alternative algorithms are allowed.  Some
        encoding options described in RFC 2253 are now treated as
        alternative algorithms in this specification.
      - Revised specification (in Section 2) to allow short names of any
        registered attribute type to appear in string representations of
        DNs instead of being restricted to a "published table".  Removed
        "as an example" language.  Added statement (in Section 3)
        allowing recognition of additional names but require recognition
        of those names in the published table.  The table now appears in
        Section 3.
      - Removed specification of additional requirements for LDAPv2
        implementations which also support LDAPv3 (RFC 2253, Section 4)
        as LDAPv2 is now Historic.
      - Allowed recognition of alternative string representations.
      - Updated Section 2.4 to allow hex pair escaping of all characters and clarified escaping for when multiple octet UTF-8 encodings are present.  Indicated that null (U+0000) character is to be escaped.  Indicated that equals sign ('=' U+003D) character may be escaped as '\='.
      - Rewrote Section 3 to use ABNF as defined in RFC 4234.
      - Updated the Section 3 ABNF.  Changes include:
        + allowed AttributeType short names of length 1 (e.g., 'L'),
        + used more restrictive <oid> production in AttributeTypes,
        + did not require escaping of equals sign ('=' U+003D) characters,不需要转义等号 ('=' U+003D) 字符，
        + did not require escaping of non-leading number sign ('#' U+0023) characters,不需要转义非前导数字符号 ('#' U+0023) 字符，
        + allowed space (' ' U+0020) to be escaped as '\ ',允许空格 (' ' U+0020) 转义为 '\ '，
        + required hex escaping of null (U+0000) characters, and需要对空 (U+0000) 字符进行十六进制转义，以及
        + removed LDAPv2-only constructs. 删除了 LDAPv2-only 结构。
      - Updated Section 3 to describe how to parse elements of the grammar.
      - Rewrote examples.
      - Added reference to documentations containing general LDAP security considerations.
      - Added discussion of presentation issues (Appendix A).
      - Added this appendix.

   In addition, numerous editorial changes were made.

# Editor's Address(略)

   Kurt D.  Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org





















Zeilenga                    Standards Track                    [Page 14]

RFC 4514               LDAP: Distinguished Names               June 2006


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

   Funding for the RFC Editor function is provided by the IETF
   Administrative Support Activity (IASA).







Zeilenga                    Standards Track                    [Page 15]

