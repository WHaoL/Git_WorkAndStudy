





Network Working Group                                          M. Smith
Request for Comments: 2079                      Netscape Communications
Category: Standards Track                                  January 1997

# Definition of an X.500 Attribute Type and an Object Class to Hold Uniform Resource Identifiers (URIs)(定义X.500中的attribute-type和object-classs用于保存URIs)

## Status of this Memo(略)

   This document specifies an Internet standards track protocol for the
   Internet community, and requests discussion and suggestions for
   improvements.  Please refer to the current edition of the "Internet
   Official Protocol Standards" (STD 1) for the standardization state
   and status of this protocol.  Distribution of this memo is unlimited.



## Abstract(摘要)

Uniform Resource Locators (URLs) are being widely used to specify the location of Internet resources.  There is an urgent need to be able to include URLs in directories that conform to the LDAP and X.500 information models, and a desire to include other types of Uniform Resource Identifiers (URIs) as they are defined.  A number of independent groups are already experimenting with the inclusion of URLs in LDAP and X.500 directories.  This document builds on the experimentation to date and defines a new attribute type and an auxiliary object class to allow URIs, including URLs, to be stored in directory entries in a standard way.
<font color=red>统一资源定位器(URLs)  被广泛用于 指定Internet资源的位置。</font>
<font color=green>迫切需要  能够在符合LDAP和X.500信息模型的  目录中包含URL，并且希望在定义时 包含其他类型的统一定义的资源标识符（URI）。</font>
许多独立的团体已经在尝试在 LDAP 和 X.500 目录中包含 URL。
<font color=blue>本文档以迄今为止的实验为基础，并定义了新的属性类型(attribute type)和辅助对象类(auxiliary object class)，以允许以标准方式将 URI（包括 URL）存储在目录条目/entry中。</font>



## Background and Intended Usage(背景和预期用途)

Uniform Resource Locators (URLs) as defined by [1] are the first of several types of Uniform Resource Identifiers (URIs) being defined by the IETF.  URIs are widely used on the Internet, most notably within Hypertext Markup Language [2] documents. This document defines an X.500 [3,4] attribute type called labeledURI and an auxiliary object class called labeledURIObject to hold all types of URIs, including URLs.  These definitions are designed for use in LDAP and X.500 directories, and may be used in other contexts as well.
[1] 中定义的统一资源定位器 (URL) 是 IETF 定义的几种统一资源标识符 (URI) 类型中的第一个。
URIs在Internet上被广泛使用，尤其是在超文本标记语言 [2] 文档中。
<font color=red>**本文档定义了     一个称为labeledURI的X.500 [3,4]属性类型(attribute type)，和一个称为labeledURIObject的辅助对象类(auxiliary object class)， 来保存所有类型的URIs，包括URLs。**</font>
这些定义设计用于 LDAP 和 X.500 目录，也可用于其他上下文。



# 1. Schema Definition of the labeledURI Attribute Type(Attribute-Type: labeledURI的schema定义)

```ABNF
   Name:             labeledURI
   ShortName:        None
   Description:      Uniform Resource Identifier with optional label
   OID:              umichAttributeType.57 (1.3.6.1.4.1.250.1.57)
   Syntax:           caseExactString
   SizeRestriction:  None
   SingleValued:     False
```

## 1.1 Discussion of the labeledURI Attribute Type

The labeledURI attribute type has the caseExactString syntax (since URIs are case-sensitive) and it is multivalued.  Values placed in the attribute should consist of a URI (at the present time, a URL) optionally followed by one or more space characters and a label. Since space characters are not allowed to appear un-encoded in URIs, there is no ambiguity about where the label begins.  At the present time, the URI portion must comply with the URL specification [1]. Multiple labeledURI values will generally indicate different resources that are all related to the X.500 object, but may indicate different locations for the same resource.
<font color=green>labeledURI属性类型 ：具有 caseExactString 语法(因为 URI 区分大小写)，并且它是多值的。</font>
<font color=green>放置在属性中的值应由一个URI(目前为 URL)组成，可选地 后跟  1个或多个空格字符 和 1个label。</font>
由于不允许在URI中出现 未编码的空格字符，因此label的开始位置没有歧义。
目前，URI 部分必须符合 URL 规范 [1]。
<font color=green>多个labeledURI-value通常表示与X.500-object相关的不同资源，但可能表示同一资源的不同位置。</font>

The label is used to describe the resource to which the URI points, and is intended as a friendly name fit for human consumption.  This document does not propose any specific syntax for the label part.  In some cases it may be helpful to include in the label some indication of the kind and/or size of the resource referenced by the URI.
label用于描述 URI 指向的资源，旨在作为适合人类消费的友好名称。
本文档没有为label部分提出任何特定的语法。
在某些情况下，在label中包含  由URI引用的   资源的种类和/或大小  的一些指示 可能会有所帮助。

Note that the label may include any characters allowed by the caseExactString syntax, but that the use of non-IA5 (non-ASCII) characters is discouraged as not all directory clients may handle them in the same manner.  If non-IA5 characters are included, they should be represented using the X.500 conventions, not the HTML conventions (e.g., the character that is an "a" with a ring above it should be encoded using the T.61 sequence 0xCA followed by an "a" character; do not use the HTML escape sequence "&aring").
请注意，标签可以包含 caseExactString 语法允许的任何字符，但不鼓励使用non-IA5 (non-ASCII) 字符，因为并非所有目录客户端都可以以相同方式处理它们。
如果包含non-IA5字符，则应使用 X.500 约定而不是 HTML 约定来表示它们
（例如，对于字符"a"(并且 其上带有ring)  应该使用T.61序列0xCA后跟一个字符"a"进行编码，不要使用 HTML 转义序列"&aring"）。



## 1.2 Examples of labeledURI Attribute Values

An example of a labeledURI attribute value that does not include a label:
不包含label的  labeledURI属性值  的示例：
```ABNF
               ftp://ds.internic.net/rfc/rfc822.txt
```

An example of a labeledURI attribute value that contains a tilde character in the URL (special characters in a URL must be encoded as specified by the URL document [1]).  The label is "LDAP Home Page":
一个  labeledURI属性值   的示例，它在URL 中包含波浪号(URL 中的特殊字符必须按照URL 文档[1] 的规定进行编码)。 
label是"LDAP Home Page"：

```ABNF
         http://www.umich.edu/%7Ersug/ldap/ LDAP Home Page
```

Another example.  This one includes a hint in the label to help the user realize that the URL points to a photo image.
另一个例子。 
这个在label中包含一个提示，以帮助用户意识到 URL 指向照片图像。

```ABNF
    http://champagne.inria.fr/Unites/rennes.gif Rennes [photo]
```



# 2. Schema Definition of the labeledURIObject Object Class

```ABNF
   Name:              labeledURIObject
   Description:       object that contains the URI attribute type
   OID:               umichObjectClass.15 (1.3.6.1.4.1.250.3.15)
   SubclassOf:        top
   MustContain:
   MayContain:        labeledURI
```


## 2.1 Discussion of the labeledURIObject Object Class

The labeledURIObject class is a subclass of top and may contain the labeledURI attribute.  The intent is that this object class can be added to existing directory objects to allow for inclusion of URI values.  This approach does not preclude including the labeledURI attribute type directly in other object classes as appropriate.
<font color=blue>labeledURIObject-class 是top 的子类，可能包含labeledURI-attribute。 
<font color=red>目的是可以将此object-class  添加到现有目录对象   以允许包含 URI 值。 </font>
这种方法不排除   将labeledURI 直接包含在适当的其他对象类/object-class中。



# Security Considerations

Security considerations are not discussed in this memo, except to note that blindly inserting the label portion of a labeledURI  attribute value into an HTML document is not recommended, as this may allow a malicious individual to include HTML tags in the label that mislead viewers of the entire document in which the labeledURI value was inserted.
本备忘录中不讨论安全性考虑，但要注意的是，<font color=blue>不建议盲目地将 labeledURI属性值的label部分 插入 HTML 文档，因为这可能允许恶意个人在label中包含 HTML-tags，从而误导浏览者 插入了labeledURI 值的整个文档。</font>



# Acknowledgments

Paul-Andre Pays, Martijn Koster, Tim Howes, Rakesh Patel, Russ Wright, and Hallvard Furuseth provided invaluable assistance in the creation of this document.

This material is based in part upon work supported by the National Science Foundation under Grant No. NCR-9416667.



# Appendix:  The labeledURL Attribute Type (Deprecated)(labeledURL-已弃用)

附录：labeledURL Attribute Type（已弃用）

An earlier draft of this document defined an additional attribute type called labeledURL.  This attribute type is deprecated, and should not be used when adding new values to directory entries.  The original motivation for including a separate attribute type to hold URLs was that this would better enable efficient progammatic access to specific types of URIs.  After some deliberation, the IETF-ASID working group concluded that it was better to simply have one attribute than two.
本文档的早期草案定义了一个名为labeledURL 的附加属性类型。 
此属性类型已弃用，不应在向目录条目添加新值时使用。 
包含一个单独的属性类型来保存 URL 的最初动机是，这将更好地实现对特定类型 URI 的高效编程访问。 
经过一番审议，IETF-ASID 工作组得出结论，简单地拥有一个属性比拥有两个属性要好。

The schema definition for labeledURL is included here for historical reference only.  Directory client software may want to support this schema definition (in addition to labeledURI) to ease the transition away from labeledURL for those sites that are using it.
此处包含了labeledURL 的schema定义，仅供历史参考。 
目录客户端软件可能希望支持此模式定义（除了labeledURI 之外），以便为那些使用它的站点简化从labeledURL 的转换。
```ABNF
   Name:             labeledURL
   ShortName:        None
   Description:      Uniform Resource Locator with optional label
   OID:              umichAttributeType.41 (1.3.6.1.4.1.250.1.41)
   Syntax:           caseExactString
   SizeRestriction:  None
   SingleValued:     False
   OID:              umichAttributeType.41 (1.3.6.1.4.1.250.1.41)
```



# References(参考)

   [1] Berners-Lee, T., Masinter, L., and M. McCahill, "Uniform
   Resource Locators (URL)", RFC 1738, CERN, Xerox Corporation,
   University of Minnesota, December 1994.
   <URL:ftp://ds.internic.net/rfc/rfc1738.txt>

   [2] Berners-Lee, T., and D. Connolly, "Hypertext Markup Language -
   2.0", RFC 1866, <URL:ftp://ds.internic.net/rfc/rfc1866.txt>

   [3] The Directory: Overview of Concepts, Models and Service.  CCITT
   Recommendation X.500, 1988.

   [4] Information Processing Systems -- Open Systems Interconnection --
   The Directory: Overview of Concepts, Models and Service.  ISO/IEC JTC
   1/SC21; International Standard 9594-1, 1988.










Smith                       Standards Track                     [Page 4]

RFC 2079          URI Attribute Type and Object Class       January 1997


# Author's Address

   Mark Smith
   Netscape Communications Corp.
   501 E. Middlefield Rd.
   Mountain View, CA 94043, USA

   Phone:  +1 415 937-3477
   EMail:  mcs@netscape.com










































Smith                       Standards Track                     [Page 5]

