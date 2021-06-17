# [LDAPv3 Wire Protocol Reference: The ASN.1 Basic Encoding Rules](https://ldap.com/ldapv3-wire-protocol-reference-asn1-ber/ )

​	LDAP is a binary protocol, which helps make it compact and efficient to parse. The particular binary encoding that it uses is based on ASN.1 (Abstract Syntax Notation One), which is a framework for representing structured data. ASN.1 is actually a family of encodings that each have their own pros and cons for different situations. For example, you might use the Packed Encoding Rules (PER) if you want to make sure that the encoded representation is as small as possible, or you might use the Octet Encoding Rules (OER) if you favor encode/decode performance over size. LDAP uses the Basic Encoding Rules (BER), which finds a good middle ground between the two.

​		LDAP是一种二进制协议，有助于使其紧凑和高效地解析。它使用的特殊二进制编码是基于ASN.1(抽象语法表示法1)，这是一个表示结构化数据的框架。ASN.1实际上是一组编码，每种编码在不同的情况下都有各自的优缺点。例如，如果您希望确保编码的表示尽可能小，您可以使用打包编码规则(PER)，或者如果您希望编码/解码性能优于大小，您可以使用八位编码规则(OER)。LDAP使用基本编码规则(BER)，它在两者之间找到了一个很好的中间地带。

总结： 

​	LDAP使用ASN.1-BER进行编码，这是一种二进制协议，能紧凑和高效的进行解析。

​	

The complete BER specification has a lot of flexibility and ambiguity, and there are several special cases to consider. Covering all of it in depth would make for a somewhat daunting task, both for me trying to explain everything, and for someone trying to take it all in. If you’re interested in all the gory details, there are already some good books that tackle that much better than I can. I highly recommend Professor John Larmouth’s excellent book *ASN.1 Complete*, which you can get online as a [free PDF download](http://www.oss.com/asn1/resources/books-whitepapers-pubs/asn1-books.html), or you can buy an honest-to-goodness paper copy if you’d prefer a physical copy. And you can always look at the [official ASN.1 specifications](http://www.itu.int/en/ITU-T/asn1/Pages/introduction.aspx) for the authoritative source, although they can be dense and they’re not always all that easy to interpret.

​	完整的 BER 规范具有很大的灵活性和模糊性，并且有几种特殊情况需要考虑。 深入介绍所有内容将是一项艰巨的任务，无论是对我试图解释所有事情还是对于试图将其全部理解的人来说。如果您对所有血腥细节感兴趣，那么已经有一些好书 比我能更好地解决这个问题。 我强烈推荐 John Larmouth 教授的优秀著作 *ASN.1 Complete*，您可以在线获取 [免费 PDF 下载]，或者如果您更喜欢实体副本，也可以购买一本正经的纸质副本。 并且您可以随时查看权威来源的[官方 ASN.1 规范]，尽管它们可以是密集和 它们并不总是那么容易解释。

Fortunately, LDAP uses a pretty well-defined subset of BER that has less ambiguity and fewer special cases. We should be able to cover all the BER that you need to understand the LDAP wire protocol without too much difficulty.

​	幸运的是，LDAP 使用了一个非常明确的 BER 子集，它具有较少的歧义和较少的特殊情况。 我们应该能够轻松涵盖您理解 LDAP 有线协议所需的所有 BER。

In ASN.1 BER, each piece of data is called an element, and each BER element has three parts: a type, a length, and a value. Let’s take a closer look at each of these components.

​	在ASN.1 BER中，每条数据称为一个元素，每个BER元素由三部分组成：类型、长度和值。 让我们仔细看看这些组件中的每一个。

总结： 

​	我们只需要了解 ASN.1的BER中(LDAP用到的那部分)

​	每个BER elements由3部分构成：type/length/value



### 1. BER Types(数据类型)

A BER element’s type is used to indicate what kind of information that element can hold, not unlike declaring the data type (string, integer, boolean, etc.) for a variable in a computer program. There are a lot of different kinds of BER types, but if we’re just talking about LDAP’s use of BER, then there are really only seven basic data types that we need to know about:

BER 元素的类型用于指示该元素可以保存的信息类型，这与在计算机程序中声明变量的数据类型（字符串、整数、布尔值等）不同。 BER 类型有很多种，但如果我们只是谈论 LDAP 对 BER 的使用，那么我们实际上只需要了解七种基本数据类型：

- Null elements don’t have a value.
  - Null elements 没有值
- Boolean elements have a value that is either true or false.
  - Boolean elements 有一个为true或false的值
- Integer elements have a value that is a whole number, with no fractional component.
  - Integer elements 有一个整数值，没有小数部分。
- Octet string elements have a value that is a collection of zero or more bytes. An octet string’s value may represent a text string, but it could also just be a binary blob.
  - Octet string elements 有一个值 是0个或多个字节的集合。 八位字节字符串 的值可能代表一个文本字符串，但它也可能只是一个二进制 blob。
- Enumerated elements have a predefined set of values in which each value has a particular meaning.
  - Enumerated elements 有一组预定义的值，其中每个值都有特定的含义。
- Sequence elements encapsulate a collection of zero or more other elements in which the order of those elements is considered significant.
  - Sequence elements 封装0个或多个其他元素的集合，其中这些元素的顺序被认为是重要的。
- Set elements encapsulate a collection of zero or more other elements in which the order of those elements is not considered significant.
  - Set elements 封装0个或多个其他元素的集合，其中这些元素的顺序不重要。

Using these seven types, we can construct any kind of LDAP request or response.

使用这七种类型，我们可以构造任何类型的 LDAP request/请求或response/响应。

Because BER is a compact binary protocol, it uses a compact binary representation for an element’s type. Although general-purpose BER supports types that span multiple bytes, it is highly unlikely that you’ll ever encounter a BER element in an LDAP message that uses more than one byte for its type. And that byte is laid out as follows:

因为 BER 是一种紧凑的二进制协议，它对element's type使用紧凑的二进制表示。 尽管 通用目的的BER 支持`跨越多个字节的类型`，但您极不可能在 LDAP 消息中遇到使用多个字节作为其类型的 BER 元素。 该字节的布局如下：

| Bits/位 | 8     | 7    | 6                         | 5          | 4    | 3    | 2    | 1    |
| ------- | ----- | ---- | ------------------------- | ---------- | ---- | ---- | ---- | ---- |
| Purpose | Class |      | Primitive or Constructed? | Tag Number |      |      |      |      |

总结： 

​	1. 七种基本数据类型：空值/布尔值/整数/字符串/枚举值/有序集合/无序集合

	2. 多字节的类型： Class + Primitive or Constructed? + Tag Number



#### 1.1 The BER Type Class(BER-type's byte的前两位)

The two most significant bits in this byte (i.e., the two leftmost bits in the big-endian representation of that byte) represent the class for the type. You can also think of this as the scope for the type, which lets you know how likely it is for the same BER type to have the same meaning in two different settings. Since the class is encoded as two bits, there are four possible values:

该字节中的两个最高有效位（即该字节的 大端表示中 最左边的两个位）： 表示该type的class/类。 您也可以将其视为type的 scope/范围，它让您知道相同 BER 类型在两种不同设置中具有相同含义的可能性有多大。 由于class被编码为两位，因此有四种可能的值：

- `00` — This is the universal class. BER types in the universal class always mean the same thing, regardless of where you see it. For example, if you see a BER element with a type of `00000010` binary (`0x02` hex, which means universal class, primitive, tag number two), then the value of that element will always be an integer.
  - `00` — 这是通用类(universal class)。 通用类中的 BER type总是意味着相同的东西，无论您在哪里看到它。 例如，如果您看到一个 BER element的type为“00000010”二进制（“0x02”十六进制，表示universal-class、primitive、tag-number为2），则该element的value将始终是integer。
- `01` — This is the application class. BER types in the application class always mean the same thing within one application but might mean something completely different in another application. And here “application” doesn’t necessarily mean a computer program; in the case of LDAP, it means the complete protocol specification. For example, if you see a BER element in an LDAP message with a type of `01100011` binary (`0x63` hex, which means application class, constructed, tag number three), then the value of that element will always be an LDAP search request protocol op.
  - `01` — 这是应用程序类(application class)。 application class中的 BER type在一个应用程序中总是意味着相同的东西，但在另一个应用程序中可能意味着完全不同的东西。 这里的“应用程序”并不一定意味着计算机程序； 对于 LDAP，它意味着完整的协议规范。 例如，如果您在 LDAP message中看到一个 BER element，其type为“01100011”二进制（“0x63”十六进制，这意味着application-class、constructed、tag-number为3），则该元素的值将始终是 LDAP 搜索请求协议操作(LDAP search request protocol op).
- `10` — This is the context-specific class. BER types in the context-specific class can have different meanings from one element to another, and you need to have an understanding of how it’s being used to be able to determine what it means. For example, if you see a BER element in an LDAP message with a type of `10100011` binary (`0xa3` hex, which means context-specific class, constructed, tag number three), then it could represent a set of referral URLs if it appears in an `LDAPResult` sequence, or it could represent an equality filter component in a search request, or it could mean something completely different somewhere else in some other context.
  - `10` — 这是特定于上下文的类。 特定于上下文类中的 BER type可以从一个element到另一个element具有不同的含义，您需要了解它的使用方式才能确定它的含义。 例如，如果您在 LDAP message中看到一个 BER element，其type为 `10100011` 二进制（`0xa3` 十六进制，这意味着context-specific-class，constructed，tagNumber为 3），如果它出现在“LDAPResult”sequence中 那么它可能代表一组引用 URL ，或者它可能代表search-request中的相等过滤器组件，或者在其他上下文中的其他地方 它可能意味着完全不同的含义。
- `11` — This is the private class. It’s intended to be something in between the universal and application classes, where an organization could define its own set of types that have the same meaning across all of their applications, but the use of the private class is discouraged, and it’s highly unlikely that you’ll ever encounter it in LDAP.
  - `11` — 这是私有类型(private class)。 它旨在介于universal-class和application-class之间，organization/组织 可以在他们的 application/应用程序 中定义一组自己的 具有相同含义的 type，但不鼓励使用私有类，而且您极可能 将永远 不会在 LDAP 中遇到它。

总结： 

​	BER-type's byte的前两个 最高有效位 是class(用于对 BER Type 划分范围/scope)(即 ：使用class对type进行划分)

​	class占2位(前两个最高有效位)(大端表示的最左边两位)



#### 1.2 The BER Type Primitive/Constructed Bit(BER-type's byte的第三位)

The third most significant bit in a BER type is used to indicate whether the element is primitive or constructed. If this bit is set to one, then it means that the element is constructed and that its value is comprised of a concatenation of zero or more encoded BER elements. Sequences and sets, which encapsulate elements, are constructed. On the other hand, if this third bit is set to zero, then it means that the element is primitive and that its value should not be assumed to be comprised of encoded elements. Null, Boolean, integer, octet string, and enumerated elements are all primitive.

BER type中的第三个最高有效位 用于指示元素是 primitive/原始的 还是 constructed/构造的。 如果该位设置为 1，则表示该元素是constructed并且其值由0个或多个编码后的 BER element的串联组成。 sequence和set封装的元素是constructed/构造的。 另一方面，如果第三位设置为1，则意味着该元素是primitive/原始的，并且不应假定其值由(各种)编码元素组(合)成。 空值/null、布尔值/boolean、整数/integer、八位字节字符串/octet-string 和 枚举/enumerated 元素都是 primitive/原始的。

总结: 

​	BER type中的第三个最高有效位  用于指示 element是 primitive 还是 constructed。

​	该位设置为1，表示该element是constructed/构造的 其值是 0个或多个 编码后的BER element的串联组成；

​		sequence和set  元素(封装元素)是constructed。

​	该位设置为0，表示element是primitive/原始的，其值不是由(各种)编码元素组(合)成；

​		Null, Boolean, integer, octet string,  enumerated 元素/element，都是primitive

​	关于 primitive和constructed： 

​			primitive即表示       该元素/element是原始的，仅仅是本element-type自己

​			constructed即表示 该元素/element是构造的，是由 其他元素/element 组合而成



#### 1.3 The BER Type Tag Number(BER-type's byte的后五位)

The remaining five bits in a BER type are used to encode the tag number, which is used to differentiate between different kinds of elements within the same class. The tag number is encoded using the binary representation of that number, so `00000` represents a tag number of zero, `00001` is a tag number of one, `00010` a tag number of two, and so on. Since there are only five bits used for the tag number, you can only have tag numbers up to thirty encoded in a single byte. Fortunately, it’s extremely unlikely that you’ll ever encounter a tag number that is greater than thirty in LDAP (the highest tag number I’m aware of is twenty-five, used for the LDAP intermediate response protocol op), so you probably don’t need to worry about multi-byte types.

BER type中剩余的 5 位用于对标签号(tag number)进行编码，用于区分同一类中的不同类型元素。 标签编号使用该数字的二进制表示进行编码，因此“00000”表示标签编号为零，“00001”表示标签编号为 1，“00010”表示标签编号为 2，依此类推。 由于标签编号仅使用 5 位，因此单个字节中最多只能编码 30 位标签编号。 幸运的是，您在 LDAP 中遇到大于 30 的标签编号的可能性极小（我所知道的最高标签编号是 25，用于 LDAP 中间响应协议操作），因此您无需担心多字节类型。

总结: 

​	BER type的剩余5位，用于对 tag number进行编码，用于区分 同一class中的不同类型的element。

​	tag number对数字的二进制进行编码

​	tag number占，5位，最多表示30个编号



#### 1.4 The Universal BER Types Used in LDAP

The following are the BER types in the universal class that you’re likely to encounter in LDAP:

以下是您在 LDAP 中可能会遇到的 (universal class)通用类 中的 BER type：

| Element Type | Binary Encoding | Hex Encoding |
| ------------ | --------------- | ------------ |
| Boolean      | 00000001        | 0x01         |
| Integer      | 00000010        | 0x02         |
| Octet String | 00000100        | 0x04         |
| Null         | 00000101        | 0x05         |
| Enumerated   | 00001010        | 0x0a         |
| Sequence     | 00110000        | 0x30         |
| Set          | 00110001        | 0x31         |

总结： 

​	上表是在 universal-class 范围中的 BER-type

​				sequence/set 是：universal-`constructed`-tagNumber

​				其他的都是          ：universal-`prmitive`-tagNumber

​				(大多数是 universal-primitive)

​	Universal BER Types：即 被划分为Universal class的BER Types	





#### 1.5 The Application BER Types Used in LDAP

The following are the BER types in the application class that are defined for LDAP:

以下是为LDAP定义的(application class)应用程序类 中的 BER type：

| Element Type                        | Binary Encoding | Hex Encoding |
| ----------------------------------- | --------------- | ------------ |
|                                     |                 |              |
| Bind Request Protocol Op            | 01100000        | 0x60         |
| Bind Response Protocol Op           | 01100001        | 0x61         |
| Unbind Request Protocol Op          | 01000010        | 0x42         |
| Search Request Protocol Op          | 01100011        | 0x63         |
| Search Result Entry Protocol Op     | 01100100        | 0x64         |
| Search Result Done Protocol Op      | 01100101        | 0x65         |
| Modify Request Protocol Op          | 01100110        | 0x66         |
| Modify Response Protocol Op         | 01100111        | 0x67         |
| Add Request Protocol Op             | 01101000        | 0x68         |
| Add Response Protocol Op            | 01101001        | 0x69         |
| Delete Request Protocol Op          | 01001010        | 0x4a         |
| Delete Response Protocol Op         | 01101011        | 0x6b         |
| Modify DN Request Protocol Op       | 01101100        | 0x6c         |
| Modify DN Response Protocol Op      | 01101101        | 0x6d         |
| Compare Request Protocol Op         | 01101110        | 0x6e         |
| Compare Response Protocol Op        | 01101111        | 0x6f         |
| Abandon Request Protocol Op         | 01010000        | 0x50         |
| Search Result Reference Protocol Op | 01110011        | 0x73         |
| Extended Request Protocol Op        | 01110111        | 0x77         |
| Extended Response Protocol Op       | 01111000        | 0x78         |
| Intermediate Response Protocol Op   | 01111001        | 0x79         |

The unbind request, delete request, and abandon request protocol op types are primitive, while all the rest are constructed. This explains why their hexadecimal representations are so out-of-line with their neighboring values. The unbind request protocol op is a null element, the delete request protocol op is an octet string element, the abandon request protocol op is an integer element, and all other types are sequence elements.

unbind request, delete request, abandon request协议操作类型是 primitive/原始的，而其余的都是 constructed/构造的。 这解释了为什么它们的十六进制表示与它们的相邻值如此不一致。 unbind request protocol op为null元素，delete request protocol op为octet string元素，abandon request protocol op为integer元素，其他类型均为sequence元素。

总结： 

​	上表是在 application-class 范围中的 BER-type

​			unbind-request/delete-request/abandon-request是：application-`primitive`-tagNumber		

​			其他的都是																		 ：application-`constructed`-tagNumber

​			(大多数是application-constructed)		

​	Application BER Types：即被划分为Application class的BER Types

​	其中的 3个BER-type 	

​		unbind request,     的protocol op是null element，             是primitive的

​		delete request,       的protocol op是octet string element，是primitive的

​		abandon request，的protocol op是integer element，       是primitive的

​	其他的BER type           的protocol op 都是`sequence` element，是constructed





### 2.BER Lengths

A BER element’s length specifies the number of bytes in the value. There are two ways to encode the length: a single-byte representation for values of up to 127 bytes, and a multi-byte representation for values of any size.

BER element的 length/长度 指定value的字节数。 有两种方法可以对长度进行编码：最多 127 个字节值的单字节表示，以及任意大小值的多字节表示。  

In the single-byte representation, the length is just encoded using the binary representation of the number of bytes in the value. For example, if the value is zero bytes long (which will be the case for a null element, for a zero-byte octet string, or an empty sequence or set), then the length is encoded as `00000000` binary or `0x00` hex. If the value is five bytes long, then the length is encoded as `00000101` binary or `0x05` hex. And a value that is 123 bytes long would be encoded as `01111011` binary or `0x7b` hex.

在单字节表示中，长度只是使用值中字节数的二进制表示进行编码。 例如，如果值是零字节长（对于空元素、零字节八位字节字符串或空序列或空集合就是这种情况），则长度被编码为“00000000”二进制或“0x00” `十六进制。 如果该值是五个字节长，则该长度被编码为“00000101”二进制或“0x05”十六进制。 123 字节长的值将被编码为“01111011”二进制或“0x7b”十六进制。

In the multi-byte representation, the first byte has its most significant bit set to one, and the lower seven bits are used to indicate how many bytes are required to represent the length. For example, let’s say that you want to encode the length for a value that is 1234 bytes long. The binary representation of 1234 is `10011010010` (`0x4d2` hex), which is large enough that it will require two bytes. And then we’ll need to precede those two bytes with a third byte that has its leftmost bit set to one and the right seven bits used to hold the binary representation of the number two. So the full binary representation of a BER length for a 1234-byte-long value is `100000100000010011010010` (`0x8204d2` hex).

在多字节表示中，第一个字节的最高有效位设置为1，低七位用于表示需要多少字节来表示长度。 例如，假设您想对 1234 字节长的值的长度进行编码。 1234 的二进制表示是“10011010010”（“0x4d2”十六进制），它足够大，需要两个字节。 然后我们需要在这两个字节之前添加第三个字节，该字节的最左边的位设置为 1，右边的 7 位用于保存数字1234的二进制表示。 因此，1234 字节长值的 BER 长度的完整二进制表示为“100000100000010011010010”（“0x8204d2”十六进制）。

总结： 

​	BER element的length 指出了value占用的字节数；

​	有两种对length进行编码的方式：最多127字节的单字节表示，任意大小的多字节表示；

​			单字节表示：直接对 value/值 所占字节数的二进制进行编码；

​			多字节表示：第一个字节的最高位为1 第一个字节的低7位表示 value/值 所占用的字节数

​					多字节表示：即 0x8n 1 2 .. n   （0x8n表示后面占用n字节，1 2 ... n  n个字节组成的数字即为value的字节数的length）     



#### 2.1 Note 1: Encoding BER Lengths with More Bytes than Necessary

使用多于必需的字节数对 BER length/长度 进行编码

Although the above BER doesn’t require you to encode the length in the smallest possible number of bytes. You can use a multi-byte representation for lengths that could be encoded in just a single byte, and you can use more bytes than necessary in a multi-byte representation. For example, all of the following hexadecimal encodings are valid ways to represent a BER length of ten bytes:

尽管上述 BER 不要求您以尽可能少的字节数对 length/长度进行编码。 对于可以仅用单个字节编码的长度，您可以使用多字节表示，并且您可以在多字节表示中使用比所需更多的字节。 例如，以下所有十六进制编码都是表示10字节 BER length的有效方式：

- `0a`
- `81 0a`
- `82 00 0a`
- `84 00 00 00 0a`
- `8a 00 00 00 00 00 00 00 00 00 0a`

Some BER libraries choose to always use multi-byte encodings for certain types of elements (especially sequences and sets). When looking at encoded LDAP traffic, it’s relatively common to see encoded lengths that start with `0x84`, followed by four more bytes that actually hold the encoded length. This is usually done for efficiency, because it allows the library to just directly copy the bytes that make up the 32-bit integer representation of the length, and because it makes it possible for the library to go back and fill in the length for a sequence or set once it knows how many elements that sequence or set contains and how big those elements are.

某些 BER libraries/库 选择始终对某些类型的元素（尤其是sequences/序列和sets/集合）使用多字节编码。 在查看编码的 LDAP 流量时，通常会看到以“0x84”开头的编码长度，然后是另外四个实际保存编码长度的字节。 这样做通常是为了提高效率，因为它允许库直接复制构成长度的 32 位整数表示的字节，并且因为它使库可以返回并填充长度 一旦知道sequence/序列或set/集合包含多少个元素以及这些元素有多大。

Although it’s technically valid to use any number of bytes to encode a BER length, many libraries impose a limit on the number of bytes that they will support in multi-byte lengths. In most cases, that limit is four bytes, not counting the one extra byte used to indicate that it’s a multi-byte length, so it’s probably best to avoid generating multi-byte lengths that start with anything larger that `0x84`.

尽管使用任意数量的字节对 BER 长度进行编码在技术上是有效的，但许多库对它们将支持的多字节长度的字节数施加了限制。 在大多数情况下，该限制是四个字节，不包括用于指示它是多字节长度的一个额外字节，因此最好避免生成以任何大于 0x84 开头的多字节长度。

总结: 

​	对于length的多字节表示，我们可以使用任意多字节，但一般推荐不大于4字节，即 最大为0x84



#### 2.2 Note 2: Imposing Upper Bounds on BER Lengths for Safety

为安全起见对 BER length/长度施加上限

Most BER libraries impose an upper limit on the size of the elements that they will accept. This is a safety feature that is intended to mitigate the risk of a malicious application claiming that it’s going to send a very large element in the hopes that it will cause the application to allocate enough memory to hold that element, which could cause the application to crash or the system to start swapping. If you’re thinking about writing a BER decoder, it’s a very good idea to ensure you have some way of rejecting elements that are unreasonably large.

大多数 BER 库对它们接受的元素大小施加了上限。 这是一项安全功能，旨在降低恶意应用程序声称将发送一个非常大的元素以希望它会导致应用程序分配足够的内存来保存该元素的风险，这可能会导致应用程序 崩溃或系统开始交换。 如果您正在考虑编写 BER 解码器，最好确保您有某种方法来拒绝过大的元素。

总结: 

​	对接收元素的大小施加上限，这是为了防止被恶意占用内存。



#### 2.3 Note 3: The Indefinite Length Form

不定长形式

BER actually offers a third way to represent the length of an element. This is called the indefinite form, and it uses a special token at the beginning to indicate the start of a value that uses the indefinite form, and then another special token after the end of the value. This is potentially useful for cases in which the size of the element may not be known in advance (for example, when starting a sequence without knowing how many elements will be added to that sequence). However, you won’t encounter the indefinite length form in LDAP because [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) section 5.1 explicitly forbids its use, so I won’t go into any more detail about it here.

BER 实际上提供了第三种表示元素长度的方法。 这称为不定形式，它在开头使用一个特殊标记来指示使用不定形式的值的开始，然后在值的结尾之后使用另一个特殊标记。 这对于可能事先不知道元素大小的情况（例如，在不知道将向该序列添加多少元素的情况下启动序列时）可能很有用。 但是，您不会在 LDAP 中遇到不定长形式，因为 [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) 第 5.1 节明确禁止使用它，所以我不会讨论任何 关于它的更多细节在这里。

总结： 

​	第3种表示 element length的方法：不定长形式

​	 [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) 第 5.1 节明确禁止使用 	不定长形式，所以我们不讨论它的细节！



### 3.BER Values

A BER element’s value holds an encoded representation of the data for that element. The way that the value is encoded depends on the type of element, so we’ll cover each kind of value separately.

BER element的value/值保存了该元素数据的编码表示。 value的编码方式取决于element的type，因此我们将分别介绍每种值。

总结: 

​	对于不同的 BER type，它们的value的编码方式是不同的



#### 3.1 Null Values

A null element is one that doesn’t have a value. Or, more accurately, it always has a value with a length of zero bytes. Null elements are typically used in cases where an element is needed, but the value for that element isn’t important. For example, the LDAP unbind request protocol op is a null element because an unbind request doesn’t have any parameters.

(null element)/空元素 是没有值的元素。 或者，更准确地说，它总是有一个长度为零字节的值。 空元素通常用于需要元素的情况，但该元素的值并不重要。 例如，LDAP 解除绑定请求协议操作 是一个空元素，因为解除绑定请求没有任何参数。

Null elements are always primitive, and the value is always empty, so the length is always zero bytes. The universal BER type for a null element is `0x05`, so the full hexadecimal encoding for a universal null element is:

空元素始终是primitive/原始元素，值始终为empty/空，因此length/长度始终为零字节。 空元素的universal/通用 BER type为“0x05”，因此通用空元素的完整十六进制编码为：

```ASN.1
05 00
```

In LDAP, the unbind request protocol op is encoded as a null element in the application class with a tag number of two (as per [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) section 4.3). The hexadecimal representation of that element is:

在 LDAP 中，unbind request protocol op 被编码为 (application class)/应用程序类中的空元素，标签号为 2（根据 [RFC 4511] 部分 4.3）。 该元素的十六进制表示是：

```ASN.1
42 00
```

总结: 

​	null element总是有一个length为0的value(value 是empty/空的)；

​		null element 通常用于 需要一个element但是 该element的value并不重；

​			例如：unbind request 的protocol op 是一个 null element.

​	null element始终是primitive ！！！；

​		null element的 universal (class) BER type为0x05；值/value始终是empty 所以length始终是0字节；

​			所以，universal null element的十六进制编码为 05 00

​		unbind request protocol op 编码为： application class)中的null element，tagNumber为2 --> 01 0 00010

​			例如： unbind request protocol op的 null element 十六进制编码为 42 00



#### 3.2 Boolean Values

A Boolean element is one whose value represents the Boolean condition of either true or false. The value of a Boolean element is always encoded as a single byte, with `0xff` representing true and `0x00` representing false.

(Boolean element)/布尔元素 是其值表示 布尔条件为true或false的元素。 布尔元素的值始终编码为单个字节，“0xff”表示真，“0x00”表示假。

> LDAP is more restrictive than general-purpose BER is when it comes to encoding Boolean values of true. In general BER, a value of false is always as represented a single byte with all bits set to zero (hex `0x00`), while a value in which at least one bit is set to one represents true. But [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) section 5.1 states that LDAP messages should always encode true values with all bits set to one, which is `0xff` hex.

Boolean elements are always primitive, and they always have a one-byte value. The universal BER type for a Boolean element is `0x01`, so the encoding for a universal Boolean element with a value of true is:

布尔元素总是primitive/原始的，它们总是有一个一字节的值。 布尔元素的通用 BER 类型为“0x01”，因此值为 true 的通用布尔元素的编码为：

```ASN.1
01 01 ff
```

And the encoding for a universal Boolean element with a value of false is:

```ASN.1
01 01 00
```

总结： 

​	Boolean element的value 编码为 单个字节，0xff表示true，0x00表示false；

​	Boolean element总是primitive！！！，有一个1字节的value,

​	Boolean element的universal BER type是0x01；

​		value为true的universal Boolean element 的十六进制编码为 01 01 ff

​		value为false的universal Boolean element 的十六进制编码为 01 01 00



#### 3.3 Octet String Values

An octet is a byte, and an octet string is simply zero or more bytes strung together. Those bytes can represent text (in LDAP, it’s usually the bytes that comprise the UTF-8 representation of that text), or they can just make up some arbitrary blob of binary data. LDAP uses octet strings all over the place, including for DNs, attribute names and values, diagnostic messages, and to hold the encoded values of controls, extended requests and responses, and SASL credentials.

一个八位字节是一个字节，八位字节字符串只是0个或多个串在一起的字节。 这些字节可以表示文本（在 LDAP 中，通常是包含该文本的 UTF-8 表示的字节），或者它们可以组成一些任意的二进制数据 blob。 LDAP 到处使用八位字节字符串，包括用于 DN、属性名称和值、诊断消息，并保存控制、扩展请求和响应以及 SASL 凭证的编码值。

In LDAP, octet strings are always primitive (BER allows for the possibility of constructed octet strings, but [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) section 5.1 forbids that use in LDAP). The universal BER type for an octet string element is `0x04`, and the hexadecimal bytes that correspond to the UTF-8-encoded text string “Hello!” are: `48 65 6c 6c 6f 21`, so the encoding for a universal octet string element meant to hold the text string “Hello!” is:

在 LDAP 中，八位字节字符串始终是primitive/原始的（BER 允许八位字节字符串是 constructed/构造的，但 [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) 第 5.1 节禁止在 LDAP 中使用）。 八位字节字符串元素的通用 BER 类型是“0x04”，对应于 UTF-8 编码的文本字符串“Hello!”的十六进制字节。 是：`48 65 6c 6c 6f 21`，因此通用八位字节字符串元素的编码意味着保存文本字符串“Hello！” 是：

```ASN.1
04 06 48 65 6c 6c 6f 21
```

总结: 

​	an octet 是一个字节

​	octet string是0个/多个 字节 串在一起

​	这些字节 用于表示文本/text，LDAP中通常是包含文本的UTF-8表示的字节；

​	LDAP中到处使用 octet string：

​		DN/attribute name/diagnostic messages/

​		controls的编码值/extended requests的编码值/responses的编码值/SASL credentials/证书 的编码值

​	LDAP中 octet string 始终是promitive！！！

​	octet string的universal BER type是0x04



#### 3.4 Integer Values

An integer is a whole number, without any decimal point or fractional portion. Integer values can be positive, negative, or zero.

整数是一个数字，没有任何小数点或小数部分。 整数值可以是正数、负数或零。

In BER, integer values are encoded using the two’s complement representation of the desired numeric value, using the smallest number of bytes that can hold the specified value. The process for coming up with the two’s complement representation varies a little based on whether the value is negative or not.

在 BER 中，整数值 使用 所需数值的 二进制补码表示 进行编码，使用可以容纳指定值的最小字节数。 根据值是否为负，二进制补码表示的过程略有不同。

An integer value of zero is always encoded as a single byte, and that byte is `00000000` binary or `00` hexadecimal. Integer elements are always primitive, and the BER type for universal integer elements is `0x02`, so the hexadecimal encoding for a universal integer element with a value of zero is:

整数值0 始终编码为单个字节，该字节是“00000000”二进制或“00”十六进制。 整数元素始终是primitive/原始的，通用整数元素的 BER 类型为“0x02”，因此值为 0 的通用整数元素的十六进制编码为：

```ASN.1
02 01 00
```

Positive integer values are encoded in the smallest number of bytes needed to hold the big-endian binary representation of that number, with the caveat that the most significant bit of the first byte cannot be set to one. If the binary representation of the desired integer value requires a multiple of eight bits, then you should prepend an extra byte with all bits set to zero. For example, the binary representation of the integer value 50 is `00110010` (`32` hex), so the hex encoding for a universal integer element with a value of 50 is:

1)  正整数值以保持该数字的 big-endian/大端 二进制表示所需的最小字节数进行编码，

2)  但需要注意的是，第一个字节的最高有效位不能设置为 1。 如果所需整数值的二进制表示需要 8 位的倍数，那么您应该预先添加一个所有位都设置为零的额外字节。 

例如，整数值 50 的二进制表示是“00110010”（“32”十六进制），因此值为 50 的通用整数元素的十六进制编码为：

```ASN.1
02 01 32
```

But the binary representation of the integer value 50,000 is `11000011 01010000` (`c3 50` hex), which does have its most significant bit set to one so we need to pad it with an extra byte of all zeros to get `00000000 11000011 01010000` binary (`00 c3 50` hex), and the hex encoding for a universal integer element with a value of 50,000 is:

但是整数值 50,000 的二进制表示是 `11000011 01010000`（`c3 50` 十六进制），它的最高有效位设置为 1，所以我们需要用一个额外的全零字节填充它以获得 `00000000 11000011 01010000` 二进制（`00 c3 50` 十六进制），值为 50,000 的通用整数元素的十六进制编码为：

```ASN.1
02 03 00 c3 50
```

Negative integer values are more difficult to understand in the two’s complement notation. If the most significant bit of the first byte is a one, then it indicates that the value is negative, but it’s not sufficient to just flip that bit from zero to one in order to turn a positive value into its negative equivalent. To compute the two’s complement representation for a negative integer, you need to use the following process:

负整数值在二进制补码表示法中更难理解。 如果第一个字节的最高有效位是 1，则表示该值是负数，但仅将该位从 0 翻转到 1 以将正值转换为负值是不够的。 要计算负整数的二进制补码表示，您需要使用以下过程：

1. Start with the big-endian binary representation of the absolute value for the desired negative number. For example, if you want to find the two’s complement representation for the number -12345, start by finding the big-endian binary representation of positive 12345, which is `00110000 00111001` (`30 39` hex).
   1. 从 负数的绝对值的 大端二进制表示 开始。 例如，如果您想找到数字 -12345 的二进制补码表示，首先要找到正数 12345 的大端二进制表示，即`00110000 00111001`（`30 39` 十六进制）。
2. Flip all of the bits in the value that you just computed so that all the ones become zeros, and the zeros become ones. So `00110000 00111001` would become `11001111 11000110`. (`cf c6` hex).
   1. 翻转您刚刚计算的值中的所有位，使所有的 1 都变为 0，而所有的 0 变为 1。 所以`00110000 00111001`会变成`11001111 11000110`。 （`cf c6` 十六进制）。
3. Add one to the resulting value, so `11001111 11000110` binary would become `11001111 11000111` (`cf c7` hex).
   1. 给结果值加 1，所以 `11001111 11000110` 二进制将变成 `11001111 11000111`（`cf c7` 十六进制）。

So the hex encoding for a universal integer element with a value of -12,345 is:

因此，值为 -12,345 的通用整数元素的十六进制编码为：

```ASN.1
02 02 cf c7
```

> Technically, BER does not impose any limits on the magnitude of the positive or negative integer values that it can represent. However, many BER libraries do define their own bounds for the sizes of integer values that they can handle. It’s probably a safe assumption that a BER library can work with signed 32-bit integer values (that is, numbers between -2,147,483,648 and 2,147,483,647), which is the range that LDAP requires, but if you’re writing your own BER library, or are looking for a library to use with LDAP, then it’s probably better to ensure that it has support for at least signed 64-bit integer values (between -9,223,372,036,854,775,808 and 9,223,372,036,854,775,807).

总结： 

​	integer value 是整数 可以是：正整数/0/负整数；对数值的二进制补码进行编码；使用最少的字节数；

​	integer element 始终是primitive/原始的；

​	universal integer element的BER type是0x02；

​		0：

​			始终编码为单字节，00000000 ==  0x00 

​			例子，值为0的universal integer element的十六进制编码为02 01 00

​		正整数：

​			以 保持数值的大端二进制补码所需的最小字节数 进行编码；

​			第一个字节的最高为不能为1，若是1则需 额外添加一个全0的字节；

​			例子，50==00110010==0x32 ，因此值为50的universal integer element的十六进制编码为02 01 32

​			例子，50000==00000000 11000011 01010000==00 c3 50，因此值为50000的...编码为02 03 00 c3 50

​		负整数： 

​			1.先求 对应的 正整数 的二进制补码

​			2.反转所有位

​			3.+1

​			例子： -12345

​				正整数: 12345==00110000 00111001==0x30 39

​				翻转    : 11001111 11000110==0xcf c6

​				+1       : 11001111 11000111==0xcf c7

​				-->> 02 02 cf c7

​	

#### 3.5 Enumerated Values

An enumerated element is like an integer in that its value is numeric, but each number is associated with a particular meaning. For example, LDAP result messages use an enumerated element to encode the result code (for example, a numeric value of 0 means that the operation completed successfully, 32 means that the operation targeted an entry that didn’t exist, 49 means that an authentication attempt failed because the user provided invalid credentials, etc.). LDAP also uses enumerated elements for things like modification types, search scopes, and alias dereferencing behaviors.

枚举元素就像一个整数，因为它的值是数字，但每个数字都与特定的含义相关联。 例如，LDAP result message使用枚举元素对result code进行编码（例如，数值 0 表示操作成功完成，32 表示操作针对不存在的条目，49 表示身份验证 尝试失败，因为用户提供了无效的凭据/证书等）。 LDAP 还使用枚举元素来表示修改类型、搜索范围和别名解引用行为等内容。

Enumerated elements are encoded in exactly the same way as integer elements. They’re always primitive, and the value is the two’s complement representation of the integer value that it holds. The universal BER type for an enumerated element is `0x0a`, so the hexadecimal encoding for a universal enumerated element that represents the LDAP “success” result code (integer value zero) is:

枚举元素的编码方式与整数元素完全相同。 它们总是primitive/原始的，值是它所持有的整数值的二进制补码表示。 枚举元素的通用 BER 类型为“0x0a”，因此表示 LDAP“成功”结果代码（整数值零）的通用枚举元素的十六进制编码为：

```ASN.1
0a 01 00
```

> Although they often are, the allowed set of numeric values for an enumerated element do not have to fall in a contiguous range. For example, there are gaps in the defined set of values for LDAP result codes.
>
> Enumerated elements should not have negative numeric values. However, values are still encoded using the two’s complement representation of the value, so that it may be necessary to add a leading byte in which all bits are set to zero if the binary representation of the numeric value would have otherwise caused the most significant bit in the first byte to be set to one.

总结: 

​	enumerated element用来表示(使用整数值的二进制补码进行表示)：

​		result-code / 

​		modification-type /  

​		search scope / 

​		alias dereference behavior

​	enumerated element总是primitive ；

​	enumerated element的universal BER type是0x0a；

​		例子，LDAP “success” result code (integer value zero) 的 通用枚举元素的十六进制表示是 0a 01 00



#### 3.6 Sequence Values

A sequence element is a container that holds a list of zero or more other elements. The order in which elements appear in a sequence is considered significant. The value of a sequence element is simply a concatenation of the encoded representations of all of the elements contained in the sequence.

序列元素是一个容器，其中包含零个或多个其他元素的列表。 元素在序列中出现的顺序被认为是重要的。 序列元素的值只是序列中包含的所有元素的编码表示的串联。

Sequences are always constructed. The universal BER type for a sequence is `0x30`, so the encoded representation of a BER sequence that contains a universal octet string with a value of “Hello!”, a Boolean value of true, and an integer value of five would be encoded as follows:

序列总是constructed/构造的。 序列的通用 BER 类型是“0x30”，因此包含  一个值为“Hello!”的通用八位字节字符串、一个布尔值为 true  和 一个整数值为 5      的BER sequence/序列的编码表示  将被编码 如下：

```ASN.1
30 0e 04 06 48 65 6c 6c 6f 21 01 01 ff 02 01 05
```

This encoding is easier to understand if you break it up into its components, like:

如果将其分解为多个组件，则此编码更容易理解，例如：

```ASN.1
30 0e -- The type and length of the sequence
   04 06 48 65 6c 6c 6f 21 -- The encoded octet string "Hello!"
   01 01 ff -- The encoded Boolean true
   02 01 05 -- The encoded integer five
```

LDAP makes heavy use of sequence elements. Every LDAP request and response is encapsulated in an element called an LDAP message, which is a sequence that contains a message ID (which is an integer), a protocol operation (which varies, but is often a sequence), and an optional list of controls (which, if present, is a sequence of sequences).

LDAP 大量使用序列元素。 每个 LDAP 请求和响应都封装在一个称为 LDAP 消息的元素中，该元素是一个序列，其中包含消息 ID（它是一个整数）、一个协议操作（它有所不同，但通常是一个序列）和一个可选的列表 控件（如果存在，则是一个序列序列）。

总结： 

​	sequence element是一个容器，0个/多个元素，元素在sequence中的顺序是重要的；

​	sequence element总是constructed；

​	sequence element的universal BER type是0x30；	00 1 10000

​	LDAP大量使用sequence element

​			每一个LDAP request和response都被封装在一个LDAP message元素中；

​			LDAP message元素是一个sequence，

​				包含一个messageID(整数)，

​				包含一个protocolOp(通常是一个sequence)

​				一个可选的controls列表(is a sequence of sequences)



#### 3.7 Set Values

A set element is also a container that holds zero or more other elements, and it’s encoded in exactly the same way as a sequence. The only real differences between a sequence and a set are that the order of elements in a set is not considered significant and that the universal BER type for a set is `0x31` instead of the `0x30` type used for a universal sequence.

集合元素也是一个包含零个或多个其他元素的容器，它的编码方式与序列完全相同。 序列和集合之间唯一真正的区别是集合中元素的顺序并不重要，并且集合的通用 BER 类型是“0x31”而不是用于通用序列的“0x30”类型。

LDAP does not use sets nearly as much as it does for sequences. The only place that sets are used in the core LDAP protocol specification ([RFC 4511](https://docs.ldap.com/specs/rfc4511.txt)) are to hold a collection of values for an attribute, and to hold the components inside an AND or OR search filter.

LDAP 不像使用序列那样使用集合。 核心 LDAP 协议规范 ([RFC 4511]) 中唯一使用集合的地方是保存属性值的集合，并将组件保存在 AND 或 OR 搜索过滤器中。

总结： 

​	set element是一个容器，0个/多个元素，元素在set中的顺序不重要 (这是set和sequence的唯一区别)；

​	set element的universal BER type是0x31；    00 1 10001

​	LDAP核心协议规范[RFC4511]中唯一使用set 的地方是：

​			保存 attribute 的 value集合，

​			并将组件保存在AND或OR搜索过滤器中



### 4. The String Representation of ASN.1 Elements(ASN.1 element的string表示)

The X.680 standard, titled “Information technology — Abstract Syntax Notation One (ASN.1): Specification of basic notation”, defines a syntax for representing ASN.1 elements as strings. As with many things related to the ASN.1, the complete syntax is long and complicated, but if you just constrain yourself to what you need to understand to get by in LDAP, it’s pretty manageable.

X.680 标准，标题名为《信息技术 — 抽象语法表示法一 (ASN.1)：基本表示法规范》，定义了将 ASN.1 元素表示为字符串的语法。 与 ASN.1 相关的许多内容一样，完整的语法又长又复杂，但如果您只限于在 LDAP 中需要了解的内容，那么它是非常易于管理的。

The string representation of an ASN.1 element is comprised of the following components:

ASN.1 element 的string/字符串表示由以下 component/组件 组成：

1. An optional set of whitespace characters and comments. What exactly constitutes whitespace and comments will be described below.
   1. 一组可选的空白字符和注释。 下面将描述空白和注释的确切构成。
2. The name of the element. This is technically called a “type reference”. This must start with a letter, and it must consist of one or more letters, digits, and hyphens. It must not end with a hyphen, and it must not contain consecutive hyphens.
   1. 元素的名称。 这在技术上称为“type reference/类型引用”。 这必须以字母开头，并且必须由一个或多个字母、数字和连字符组成。 它不能以连字符结尾，并且不能包含连续的连字符。
3. An optional set of whitespace characters and comments.
   1. 一组可选的空白字符和注释。
4. The assignment operator “`::=`”.
   1. 赋值运算符“`::=`”。
5. An optional set of whitespace characters and comments.
   1. 一组可选的空白字符和注释。
6. An indication of the type of the element. This can be as simple as the name of the value type (for example, `BOOLEAN` or `OCTET STRING`), but it can be substantially more involved. We’ll get into this in more detail below.
   1. 元素类型的指示。 这可以像值类型的名称一样简单（例如，`BOOLEAN` 或`OCTET STRING`），但它可能涉及更多。 我们将在下面更详细地介绍这一点。
7. An optional set of whitespace characters and comments.
   1. 一组可选的空白字符和注释。

For example, a simple ASN.1 element definition might look like:

例如，一个简单的 ASN.1 element定义可能如下所示：

```ASN.1
AttributeValue ::= OCTET STRING
```

总结： 

​	X.680定义了 将ASN.1 element表示为string的语法；

​	ASN.1 element的string表示由以下组件组成： 

​			element‘s name  ::=  element‘s type indication(value type 's name)

​	



#### 4.1 Whitespace in the String Representation of ASN.1 Elements(ASN.1 element中的空格)

ASN.1 element的 string/字符串 表示中的 空格

In the string representation of ASN.1 elements, whitespace consists of one or more of the following characters:

在 ASN.1 element的string表示中，空格由以下一个或多个字符组成：

| Description             | UTF-8 Encoding (hexadecimal) |
| ----------------------- | ---------------------------- |
| Regular space           | 20                           |
| Non-breaking space      | c2 a0                        |
| Horizontal tab          | 09                           |
| Vertical tab            | 0b                           |
| Line feed (aka newline) | 0a                           |
| Form feed               | 0c                           |
| Carriage return         | 0d                           |

总结： 

​	ASN.1 element的string 表示中，空格 由上表中的一个或多个字符组成。



#### 4.2 Comments in the String Representation of ASN.1 Elements(ASN.1 element中的注释)

ASN.1 element的 string/字符串 表示中的 注释

There are two ways to specify comments in the string representation of ASN.1 elements:

有两种方法可以在 ASN.1 element的string表示中指定注释：

- A comment can start with two consecutive hyphen characters, “`--`”, and it will continue either until the next occurrence of “`--`”, or until the end of the line, whichever comes first.
  - 注释可以以两个连续的连字符“`--`”开头，并且会一直持续到下一次出现“`--`”，或者直到行尾，以先到者为准。
- Like in a number of programming languages like C and Java, a comment can start with “`/*`”, and it will continue until it is closed with “`*/`”. These comments can span multiple lines.
  - 就像在 C 和 Java 等许多编程语言中一样，注释可以以“`/*`”开头，并且会一直持续到以“`*/`”结束。 这些注释可以跨越多行。

总结： 

​	ASN.1 element的string表示中，注释有两种： "--" 单行注释，“/* */”多行注释



#### 4.3 Specifying the BER Type in the String Representation of ASN.1 Elements(ASN.1 element中指定BER type)

在ASN.1 element 的string表示中 指定 BER Type

You can specify the BER type for an ASN.1 element by enclosing it in square brackets in front of the name of the value type. The square brackets should include at least the tag number for the BER type, but may also contain a string that indicates the class for the type.

您可以在 value-type's name 前面的方括号中 指定 ASN.1 elemeny的 BER type。 方括号应至少包含 BER type的tag number，但也可以包含指示type's class的字符串。

To indicate that an element should have a BER type in the universal class, you can use the string “`UNIVERSAL`” inside the square brackets, followed by whitespace and the tag number for that type of element. For example:

要指示 universal class/通用类中的 element/元素 应具有 BER type，您可以在方括号内使用字符串“`UNIVERSAL`”，后跟空格和该类型元素的标记号/tag number。 例如：

```ASN.1
AttributeValue ::= [UNIVERSAL 4] OCTET STRING
```

But this is a rare occurrence because you can omit the type specification if the element is in the universal class. So the above is equivalent to:

但这种情况很少见，因为如果元素在通用类中，您可以省略类型说明。 所以上面的等价于：

```ASN.1
AttributeValue ::= OCTET STRING
```

To indicate that an element should have a BER type in the application class, use the string “`APPLICATION`” inside the square brackets, followed by whitespace and the tag number. For example:

要指示 aplication class/应用程序类中的 element/元素 应具有 BER type，请在方括号内使用字符串“`APPLICATION`”，后跟空格和标签编号。 例如：

```ASN.1
UnbindRequest ::= [APPLICATION 2] NULL
```

To indicate that an element should have a BER type in the context-specific class, simply place the tag number inside the square brackets without any other text. For example:

要指示 context-specific class/特定于上下文类中的 element/元素 应具有BEER type，只需将标签编号放在方括号内，无需任何其他文本。 例如：

```ASN.1
HypotheticalContextSpecificElement ::= [0] INTEGER
```

And although you’ll probably never encounter it in LDAP, if you want to indicate that an element should have a BER type in the private class, use the string “`PRIVATE`” inside the square brackets before the tag number, like:

虽然您可能永远不会在 LDAP 中遇到它，但如果您想指示一个元素在private class/私有类中应该具有 BER 类型，请在标签号之前的方括号内使用字符串“`PRIVATE`”，例如：

```ASN.1
HypotheticalPrivateElement ::= [PRIVATE 5] BOOLEAN
```

总结： 

​	在 ASN.1 element的string表示中指定 BER Type.

​	在value type‘s name前的 方括号中 指定 ASN.1 element的BER type；

​		方括号中至少包含 BER type的tag number/标签编号，(也可以包含 指示type的class的string)，

​				-->>  即： [class  tag-number]  BER-type

​	1) 要指示universal class中的element应该有一个BER type，

​		在方括号中： "UNIVERSAL" + 空格 + element type的tag number

​			例如： AttributeValue ::= [UNIVERSAL 4] OCTET STRING

​		但是，在universal class中的element通常 省略 类型说明

​			所以，等价于 AttributeValue ::= OCTET STRING

​	2) 要指示application class中的element应该有一个BER type，

​		在方括号中： "APPLICATION" + 空格 + element type的tag number，

​			例如： UnbindRequest ::= [APPLICATION 2] NULL

​	3)要指示context-specific class中的element应该有一个BER type，

​		在方括号中：只需包含  element type的tag number，

​	4) 要指示private class中的element应该有一个BER type，

​		您永远不会再LDAP中遇到......

​	<font color=red >注意：</font>

​		<font color=red >在ASN.1 element 的string表示中的 tag-number 是6位的，</font>

​		<font color=red >即  此处的tag-number == primitive/constructed  + tagNumber</font>



#### 4.4 Specifying Null Values(ASN.1 element中 指定 空值)

Since null elements don’t have values, there isn’t much variation in the string representation of null values. You just use the string “`NULL`”, optionally preceded by the type specification in square brackets. For example:

由于空元素没有值，因此空值的字符串表示形式没有太大变化。 您只需使用字符串“`NULL`”，可选地以方括号中的类型规范开头。 例如：

```ASN.1
UnbindRequest ::= [APPLICATION 2] NULL
```

总结： 

​	指定element value的type是null element。

​	null element的值，只需使用"NULL"( 可选的：方括号中指定type [class类型  type的tag-number] )

​	例如： UnbindRequest ::= [APPLICATION 2] NULL



#### 4.5 Specifying Boolean Values(ASN.1 element中 指定布尔值)

Unlike null elements, Boolean elements do have values. But since a Boolean value is so simple, there aren’t any constraints that you can impose, so the string representation of a Boolean value is just the string “`BOOLEAN`”, optionally including the type in square brackets. For example:

与空元素不同，布尔元素确实有值。 但是由于布尔值非常简单，因此没有任何可以强加的约束，因此布尔值的字符串表示只是字符串“`BOOLEAN`”，可选地包括方括号中的类型。 例如：

```ASN.1
HypotheticalBooleanElement ::= [1] BOOLEAN
```

总结： 

​	指定element value的type是boolean element

​	boolean element的值: 是 (可选的[ ]中的type  + ) "BOOLEAN"   ) 

​		我认为，上述也可以写为： HypotheticalBooleanElement ::= [UNIVERSAL 1] BOOLEAN



#### 4.6 Specifying Octet String Values(指定字符串的值)

The string representation of an octet string element uses the string “`OCTET STRING`”, optionally preceded by the BER type specification. For example:

八位字节字符串元素 的 string/字符串表示 使用字符串“`OCTET STRING`”，可选地以 BER type规范开头。 例如：

```ASN.1
AttributeValue ::= OCTET STRING
```

Octet string elements can have any kind of value since the value is just a collection of zero or more bytes. However, just because a general-purpose octet string can have any kind of value, that doesn’t mean that every octet string element should be treated as a free-for-all. A particular octet string element might be indented to hold a particular kind of value, and therefore you might want to indicate that there should be certain constraints on the value of that element.

八位字节字符串元素可以具有任何类型的值，因为该值只是0个或多个字节的集合。 然而，仅仅因为通用八位字节字符串可以具有任何类型的值，这并不意味着每个八位字节字符串元素都应该被视为免费的。 特定的八位字节字符串元素可能会缩进以保存特定类型的值，因此您可能希望表明对该元素的值应该有某些限制。

If an octet string’s value should have a specific size, you can indicate that with the SIZE constraint with the allowed number of bytes specified in parentheses, like:

如果八位字节字符串值应具有特定大小，则可以使用括号中指定的允许字节数来指示 SIZE 约束，例如：

```ASN.1
FiveByteOctetString ::= OCTET STRING SIZE(5)
```

And if the value’s size should be within a specified range, you can indicate that range by separating the upper and lower bounds with two periods, like:

如果值大小应该在指定范围内，您可以通过用两个句点分隔上限和下限来指示该范围，例如：

```ASN.1
FiveToTenByteOctetString ::= OCTET STRING SIZE(5..10)
```

If you need to specify a constraint that is more complex than just restricting the number of bytes that can be in the value, then you can just use a comment to specify what that constraint is. For example:

如果您需要指定一个比限制值中可以包含的字节数更复杂的约束，那么您可以只使用注释来指定该约束是什么。 例如：

```ASN.1
LDAPString ::= OCTET STRING -- UTF-8 encoded,
              -- [ISO10646] characters
```

总结： 

​	指定element value的type是octet string element

​	Octet String可以保存 任何类型的值；

​	可以在'( )'中 指定Octet String确切的 字节数；

​	可以在'( )'中 指定Octet String允许的  字节数的范围；

​	可以对Octet String指定更复杂的约束，使用注释指定该约束是什么；



#### 4.7 Specifying Integer Values(指定整数值)

To indicate that an element has a value that is an integer, use the string “`INTEGER`”, like:

要指示元素具有整数值，请使用字符串“`INTEGER`”，例如：

```ASN.1
SomeNumber ::= INTEGER
```

You can specify a range of valid values by separating the upper and lower bounds with two periods and enclosing that range in parentheses, like:

您可以通过用两个句点分隔上限和下限并将该范围括在括号中来指定有效值的范围，例如：

```ASN.1
NumberBetweenOneAndTen ::= INTEGER (1..10)
```

You can also define an integer constant, which is a named representation of a fixed value. For example, the LDAP specification defines a maxInt constant with a value of 2147483647, and it uses that constant in various places. For example:

您还可以定义一个整数常量，它是一个固定值的命名表示。 例如，LDAP 规范定义了一个值为 2147483647 的 maxInt 常量，并且它在不同的地方使用了这个常量。 例如：

```ASN.1
MessageID ::= INTEGER (0..maxInt)
maxInt INTEGER ::= 2147483647 -- (2^^31 - 1) --
```

总结: 

​	指定element value的type是integer element

​	指示element具有整数值，使用"INTEGER"

​			SomeNumber ::= INTEGER

​	指定值的范围

​			NumberBetweenOneAndTen ::= INTEGER (1..10)

​	可以定义 整数常量(类似于C语言中的 #define)，它表示了一个固定值

​			MessageID ::= INTEGER (0..maxInt)
​			maxInt INTEGER ::= 2147483647 -- (2^^31 - 1) --	





#### 4.8 Specifying Enumerated Values(指定枚举值)

An enumerated element has exactly the same encoded representation as an integer element, but they have very different string representations. That’s because each of the possible numeric values for an enumerated element has a specific name that indicates its meaning, and the string representation correlates the name with its numeric value.

枚举元素具有与整数元素完全相同的编码表示，但它们具有非常不同的字符串表示。 这是因为枚举元素的每个可能的数值都有一个表示其含义的特定名称，并且字符串表示将名称与其数值相关联。

The string representation of an enumerated element starts with the string “`ENUMERATED`” (optionally preceded by the type specification in square brackets), followed by an opening curly brace. It then includes a number of name-value pairs in which the name for each pair follows the same syntax as a "type reference" (it must start with a letter, must not contain consecutive hyphens, must not end with a hyphen, and must contain only letters, digits, and hyphens), and the numeric value follows that name in parentheses. Each name-value pair except for the last one is followed by a comma, and the last one is followed by a closing curly brace. For example:

枚举元素的字符串表示以字符串“`ENUMERATED`”开头（可选地以方括号中的类型规范开头），后跟左花括号。 然后它包含多对name-value，其中每对的name遵循与"type reference"相同的语法（它必须以字母开头，不得包含连续的连字符，不得以连字符结尾，并且必须仅包含 字母、数字和连字符），数值 跟在括号中的名称后面。 除了最后一个name-value对之外，每个name-value对后跟一个逗号，最后一个后跟一个右花括号。 例如：

总结： 基本形式如下所示；

```ASN.1
TrafficLightColor ::= ENUMERATED {
     red        (0),
     yellow     (1),
     green      (2) }
```



The string representation of an enumerated element typically lists the values in ascending order, but those values don’t have to represent a contiguous range, and there is no set minimum or maximum value. For example:

枚举元素 的字符串表示 通常按 升序 列出 值，但这些值不必表示连续范围，并且没有设置最小值或最大值。 例如：

总结：值是升序列出，但是并不要求连续；

```ASN.1
SparseValues ::= ENUMERATED {
     smallestValue     (5),
     middleValue       (10),
     largestValue      (17) }
```



There may also be cases in which you want to define a given set of allowed values now, but also permit defining additional values that can be used in the future. For example, the LDAP protocol specification uses an enumerated element to define a number of possible result code values, but it also allows for other result codes to be defined in other specifications or by specific vendors. To indicate that this should be allowed, use three periods to create an ellipsis, typically at the end of the list of possible values, like:

在某些情况下，您现在可能想要定义一组给定的允许值，但也允许定义将来可以使用的其他值。 例如，LDAP 协议规范使用枚举元素来定义许多可能的result code值，但它也允许在其他规范中或由特定供应商定义其他result code。 为了表明应该允许这样做，请使用三个句点来创建省略号，通常位于可能值列表的末尾，例如：

总结：name-value末尾的 "..." 表示允许定义其他扩展；

```ASN.1
MayIncludeAdditionalValues ::= ENUMERATED {
     first      (1),
     second     (2),
     third      (3),
     ... }
```

This indicates that the three specified values are known at the time the specification was created, but that an application should be prepared to encounter other values. The application may not necessarily be able to interpret those values correctly, and it may return an error if it encounters an unrecognized value, but at least that error shouldn’t result from an inability to decode the element.

这表明三个指定的值在创建规范时是已知的，但应用程序应该准备好遇到其他值。 应用程序可能不一定能够正确解释这些值，如果遇到无法识别的值，它可能会返回错误，但至少该错误不应该是由于无法解码元素而导致的。

For example, [RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) section 4.5.1 specification defines three possible search scope values but uses an ellipsis to indicate that there may be additional scopes defined in the future. It does this like:

例如，[RFC 4511](https://docs.ldap.com/specs/rfc4511.txt) 第 4.5.1 节规范定义了三个可能的搜索范围值，但使用省略号来表示可能在未来扩展scope。 它这样做：

```ASN.1
scope ::= ENUMERATED {
     baseObject       (0),
     singleLevel      (1),
     wholeSubtree     (2),
     ... }
```

And in fact the [draft-sermersheim-ldap-subordinate-scope](https://docs.ldap.com/specs/draft-sermersheim-ldap-subordinate-scope-02.txt) specification does propose a fourth scope, `subordinateSubtree`, with a numeric value of 3.

事实上，[draft-sermersheim-ldap-subordinate-scope])规范确实提出了第四个范围，`subordinate Subtree`，其数值为 3。

总结: 

​	基本形式： 

​			"ENUMERATED"   '{'   name-value, [name-value]  '}'

​			值是升序列出，但是并不要求连续；

​			name-value末尾的 "..." 表示允许定义其他扩展；

​			



#### 4.9 Specifying Sequence Values(指定sequence的值)

There are two basic kinds of sequences: those that have a well-defined set of elements, and those that have an arbitrary number of elements that are all of the same type. The first is primarily used as a data structure to represent some entity with multiple components, while the second is primarily used to hold a bunch of the same kind of thing.

有两种基本类型的序列：具有明确定义的元素集的序列，以及具有任意数量的相同类型元素的序列。 第一个主要用作数据结构来表示具有多个组件的某个实体，而第二个主要用于保存一堆相同类型的东西。

总结：

​	两种sequence： 

​		1) 具有明确定义的各种元素的集合，用作数据结构 表示具有多个组件的某个实体； 

​		2) 任意数量的相同类型元素的集合，用于保存一堆相同类型的东西。



##### 4.9.1 Specifying Sequences with Predefined Element Types

使用 预定义的 元素类型/element type   指定 序列/sequence

The string representation of a sequence element with a specific number and type of elements is similar to that of an enumerated element. It starts with the “`SEQUENCE`” keyword (optionally preceded by the type specification in square brackets), followed by an opening curly brace, a comma-delimited list of the allowed elements, and a closing curly brace. Each item in the comma-delimited list of elements consists of a name, some whitespace, and the value specifier. For example:

具有 特定数量和元素类型的 序列元素的 字符串表示 类似于枚举元素的字符串表示。 它以“`SEQUENCE`”关键字开头（可选地以方括号中的类型规范开头），然后是左花括号、逗号分隔的允许元素列表和右花括号。 逗号分隔的元素列表中的每一项都包含一个name/名称、一些空格和 value/值说明符。 例如：

```ASN.1
Date ::= SEQUENCE {
     year           INTEGER,
     month          ENUMERATED {
          january       (1),
          february      (2),
          march         (3),
          april         (4),
          may           (5),
          june          (6),
          july          (7),
          august        (8),
          september     (9),
          october       (10),
          november      (11),
          december      (12) },
     dayOfMonth     INTEGER (1..31) }
```

总结：

​	sequence element的string表示 类似于 enumerated element的string表示。

​	"SEQUENCE"   +   "{"   +  逗号分割的元素列表  +   "}"

​		元素列表中的每一项: name  value-type(的说明)



All of the constraints that you can define for the elements on their own are also available for those elements in a sequence (for example, the above constraint that only allows the `dayOfMonth` value to be between 1 and 31). But there are also additional constraints that you can define for elements in a sequence. These include the `OPTIONAL` and `DEFAULT` constraints.

您 为元素自定义的所有约束 也可用于 sequence/序列中的这些元素（例如，上述约束只允许 `dayOfMonth` 值介于 1 和 31 之间）。 但是，您还可以为sequence/序列中的元素定义其他约束。 其中包括“OPTIONAL” 和 “DEFAULT” 约束。

The `OPTIONAL` constraint indicates that the specified element is optional and doesn’t have to be present. For example, the following sequence defines a data structure for specifying the time of the day in which the hour and minute are required, but the second is optional:

`OPTIONAL` 约束表示指定的元素是可选的，不是必须存在。 例如，以下序列定义了一个数据结构，用于指定需要一天中小时和分钟的的时间，但第二个是可选的：

```ASN.1
TimeOfDay ::= SEQUENCE {
     hour       INTEGER (0..23),
     minute     INTEGER (0..59),
     second     INTEGER (0..60) OPTIONAL }
```

The `DEFAULT` constraint is like the `OPTIONAL` constraint in that it indicates that the specified element doesn’t have to be there, but the `DEFAULT` constraint also specifies what value should be assumed if that element isn’t present by following that keyword with whitespace and the default value that should be used. For example:

`DEFAULT` 约束类似于 `OPTIONAL` 约束，因为它表明指定的元素不是必须存在，但 `DEFAULT` 约束还指定如果该元素不存在，则应采用以下值: 带有空格的关键字和应该使用的默认值。 例如：

```ASN.1
Control ::= SEQUENCE {
     controlType      LDAPOID,
     criticality      BOOLEAN DEFAULT FALSE,
     controlValue     OCTET STRING OPTIONAL }
```

总结： 

​	可以为sequence中的元素自定义约束；

​	其他约束：

​		OPTIONAL：不是必须存在，是可选的

​		DEFAULT：  不是必须存在，  是可选的  -- 当没有指定值时使用默认值



As with an enumerated element, you may want to define a sequence that has a defined set of elements right now, but that may also have additional elements in the future. In that case, you can use the ellipsis (`...`) at the end of the sequence before the closing curly brace, just like you can in an enumerated element. For example:

与枚举元素一样，您可能希望定义一个序列，该序列现在具有一组已定义的元素，但将来可能还有其他元素。 在这种情况下，您可以在序列末尾的大括号之前使用省略号 (`...`)，就像在枚举元素中一样。 例如：

```ASN.1
ExtendableSequence ::= SEQUENCE {
     element1     OCTET STRING,
     element2     OCTET STRING,
     element3     OCTET STRING,
     ... }
```

总结： 

​	sequence末尾的 "}"之前，使用 省略号...   表明允许以后扩展。



Because the order of elements in a sequence is significant, you can often use the positions of each element to determine what they represent. In the `ExtendableSequence` defined above, the first element in the sequence corresponds to `element1` in the definition, the second corresponds to `element2`, and the third corresponds to `element3`. However, this may not work if a sequence contains non-required elements. For example, consider the following:

由于序列中元素的顺序很重要，因此您通常可以使用每个元素的位置来确定它们代表什么。 在上面定义的`ExtendableSequence`中，序列中的第一个元素对应于定义中的`element1`，第二个对应于`element2`，第三个对应于`element3`。 但是，如果序列包含非必需元素，这可能不起作用。 例如，请考虑以下情况：

```ASN.1
AnInvalidSequenceDefinition ::= SEQUENCE {
     element1     OCTET STRING OPTIONAL,
     element2     OCTET STRING OPTIONAL,
     element3     OCTET STRING OPTIONAL }
```

The above sequence is not valid because, if any of the elements is omitted, it’s not possible to determine which one it was. To deal with this, you need to ensure that all of the elements (or at least all of the elements starting with the first non-required element) have a unique BER type so that you can use the type to determine which elements are present and which are absent. For example, the following is valid because even if one or two elements are missing, you can use the BER types of the elements that are present to figure out which ones they are:

上述序列是无效的，因为如果省略了任何元素，则无法确定它是哪个元素。 为了解决这个问题，您需要确保所有元素（或至少从第一个非必需元素开始的所有元素）都具有唯一的 BER 类型，以便您可以使用该类型来确定存在哪些元素以及 哪些是缺席的。 例如，以下内容是有效的，因为即使缺少一两个元素，您也可以使用存在的元素的 BER 类型来确定它们是哪些：

```ASN.1
AValidSequenceDefinition ::= SEQUENCE {
     element1     OCTET STRING OPTIONAL,
     element2     BOOLEAN DEFAULT TRUE,
     element3     INTEGER DEFAULT 1234 }
```

But what if you want a sequence to have multiple elements with the same data type? This is when you specify an explicit BER type (usually in the context-specific class) so that you can use it to tell the difference between them. So the following is valid:

但是，如果您希望序列具有多个具有相同数据类型的元素怎么办？ 这是当您指定显式 BER 类型时（通常在特定于上下文的类中），以便您可以使用它来区分它们之间的区别。 所以以下是有效的：

```ASN.1
AnotherValidSequenceDefinition ::= SEQUENCE {
     element1     [1] OCTET STRING OPTIONAL,
     element2     [2] OCTET STRING OPTIONAL,
     element3     [3] OCTET STRING OPTIONAL }
```

总结： 

​	sequence中元素的顺序是重要的，为了确定每个位置的元素代表什么，有两种方式： 

​			1) 从第一个`OPTIONAL`(可选的/非必须出现的) 元素开始的所有元素，都有唯一BER类型；

​			2) 当希望具有同一数据类型的多个元素时，显示指定BER类型；



##### 4.9.2 Specifying Sequences with an Arbitrary Number of Elements of the Same Kind

使用任意数量的同类元素指定序列

Sometimes you want to have a sequence that is just a list containing some number of elements of a given kind, and you may or may not know how many elements should be in that list. You can indicate this with “`SEQUENCE OF`” followed by the type of element that should be contained in the list. For example:

有时您想要一个序列，它只是一个包含 一定数量的给定类型元素的 列表，您可能知道也可能不知道该列表中应该有多少元素。 您可以使用“`SEQUENCE OF`”后跟应包含在列表中的元素类型来表示。 例如：

```ASN.1
ListOfIntegers ::= SEQUENCE OF listItem INTEGER
```

总结： 

​	使用 任意数量的 同类元素 来 指定 sequence/序列。

​	1) 当不知道sequence中有多少个这种元素时，举例如下： 

​			ListOfIntegers ::= SEQUENCE OF listItem INTEGER		



If you want to restrict the number of elements in the sequence, you can use the `SIZE` constraint. In this case, the word `SIZE` comes immediately after the word `SEQUENCE` and is followed by either a single number in parentheses (to indicate exactly how many elements should be present) or a pair of numbers separated by two periods (to indicate that the number of elements should fall within a specified range). For example:

如果要限制序列中元素的数量，可以使用“SIZE”约束。 在这种情况下，单词“SIZE”紧跟在单词“SEQUENCE”之后，后跟括号中的单个数字（以准确表示应该存在多少个元素）或由两个句点分隔的一对数字（以表示 元素的数量应该在指定的范围内）。 例如：

```ASN.1
ListOfThreeIntegers ::= SEQUENCE SIZE (3) OF listItem INTEGER

ListOfFiveOrSixIntegers ::= SEQUENCE SIZE (5..6) OF listItem INTEGER
```

总结： 

​	2) 当需要限制 sequence中这种元素的确切个数 或 范围 时，使用`SIZE` 约束，举例如下： 

​			ListOfThreeIntegers ::= SEQUENCE SIZE (3) OF listItem INTEGER								

​			ListOfFiveOrSixIntegers ::= SEQUENCE SIZE (5..6) OF listItem INTEGER



If there is a lower bound on the number of items but no upper bound, you can use the word `MAX` in place of the upper bound in the range, like:

如果项目数量有下限但没有上限，则可以使用“MAX”一词代替范围内的上限，例如：

```ASN.1
NonEmptyListOfIntegers ::= SEQUENCE SIZE (1..MAX) OF listItem INTEGER
```

总结： 

​	3) 当sequence中这种元素的个数 有下限 但是没有上限时，使用`MAX`表示不限制上限，举例如下： 

​			NonEmptyListOfIntegers ::= SEQUENCE SIZE (1..MAX) OF listItem INTEGER



##### 4.9.3 Inheriting from an Existing Sequence(继承)

从现有sequence/序列继承

Sometimes, you may want to create one sequence that contains all of the elements of another sequence, but that also allows additional elements not in the original sequence. For example, most response messages for LDAP operations allow for a result code, matched DN, diagnostic message, and a list of referral URLs, and these are all contained in an `LDAPResult` sequence, which is defined as follows:

有时，您可能希望创建一个包含另一个序列的所有元素的序列，但同时也允许添加不在原始序列中的元素。 例如，大多数 LDAP operation的response-message/响应消息  允许：result-code/结果代码、matched-DN/匹配的DN、diagnostic-message/诊断消息和 list-of-referral-URLs/引用 URL 列表，这些都包含在`LDAPResult`序列中，其定义如下：

```ASN.1
LDAPResult ::= SEQUENCE {
     resultCode         ENUMERATED {
          success                      (0),
          operationsError              (1),
          protocolError                (2),
          timeLimitExceeded            (3),
          sizeLimitExceeded            (4),
          compareFalse                 (5),
          compareTrue                  (6),
          authMethodNotSupported       (7),
          strongerAuthRequired         (8),
 -- 9 reserved --
          referral                     (10),
          adminLimitExceeded           (11),
          unavailableCriticalExtension (12),
          confidentialityRequired      (13),
          saslBindInProgress           (14),
          noSuchAttribute              (16),
          undefinedAttributeType       (17),
          inappropriateMatching        (18),
          constraintViolation          (19),
          attributeOrValueExists       (20),
          invalidAttributeSyntax       (21),
 -- 22-31 unused --
          noSuchObject                 (32),
          aliasProblem                 (33),
          invalidDNSyntax              (34),
 -- 35 reserved for undefined isLeaf --
          aliasDereferencingProblem    (36),
 -- 37-47 unused --
          inappropriateAuthentication  (48),
          invalidCredentials           (49),
          insufficientAccessRights     (50),
          busy                         (51),
          unavailable                  (52),
          unwillingToPerform           (53),
          loopDetect                   (54),
 -- 55-63 unused --
          namingViolation              (64),
          objectClassViolation         (65),
          notAllowedOnNonLeaf          (66),
          notAllowedOnRDN              (67),
          entryAlreadyExists           (68),
          objectClassModsProhibited    (69),
 -- 70 reserved for CLDAP --
          affectsMultipleDSAs          (71),
 -- 72-79 unused --
          other                        (80),
          ...  },
     matchedDN          LDAPDN,
     diagnosticMessage  LDAPString,
     referral           [3] Referral OPTIONAL }

Referral ::= SEQUENCE SIZE (1..MAX) OF uri URI

URI ::= LDAPString     -- limited to characters permitted in
         -- URIs
```

But an LDAP bind response can include all of these `LDAPResult` elements, plus an additional octet string element used to hold server SASL credentials. And an LDAP extended response can include all of the `LDAPResult` elements, plus an additional octet string for the response OID and an additional octet string for the response value.

但是一个 `LDAP bind response` 可以包含`LDAPResult`的所有这些元素，以及用于保存服务器 SASL 证书的额外octet string元素。 一个 `LDAP extended response`可以包括 `LDAPResult`的所有元素，加上一个额外的octet string 作为response-OID 和一个额外的octet string作为response-value。

Rather than duplicating the entire `LDAPResult` element and making the desired changes, you can use the “`COMPONENTS OF`” keyword followed by the name of the sequence whose elements you want to import. For example:

您可以使用`COMPONENTS OF`关键字后跟要导入其元素的序列名称，而不是复制整个`LDAPResult`的元素并进行所需的更改。 例如：

```ASN.1
BindResponse ::= [APPLICATION 1] SEQUENCE {
     COMPONENTS OF LDAPResult,
     serverSaslCreds    [7] OCTET STRING OPTIONAL }

ExtendedResponse ::= [APPLICATION 24] SEQUENCE {
     COMPONENTS OF LDAPResult,
     responseName     [10] LDAPOID OPTIONAL,
     responseValue    [11] OCTET STRING OPTIONAL }
```

总结： 

​	如何在一个sequence中包含另一个sequence中的全部元素，有两种方法：

​	1) 一个sequence可以继承自另一个sequence(继承了全部的元素列表)，并且可以扩展额外的元素；

​	    (类似于C++的继承)(是复制)

​	`LDAPResult` = resultCode + matchedDN + diagnosticMessage + referral

​	 `LDAP bind response` == `LDAPResult` + SASL证书(octet string)

​	`LDAP extended response` == `LDAPResult` + response-OID(octet string) + response-value(octet string)

​	2) 可以 使用`COMPONENTS OF`导入某个sequence的所有元素；(是导入，不是复制)  (推荐！！！)

​			BindResponse ::= [APPLICATION 1] SEQUENCE {
​     			COMPONENTS OF LDAPResult,
​     			serverSaslCreds    [7] OCTET STRING OPTIONAL }		

​			ExtendedResponse ::= [APPLICATION 24] SEQUENCE {
​     			COMPONENTS OF LDAPResult,
​    			 responseName     [10] LDAPOID OPTIONAL,
​     			responseValue    [11] OCTET STRING OPTIONAL }



#### 4.10 Specifying Set Values(指定set的值)

The string representation of set elements is virtually identical to that of sequence elements. Just replace “`SEQUENCE`” with “`SET`”, and “`SEQUENCE OF`” with “`SET OF`”. However, given that the order of elements in a set is not considered significant, you are more likely to encounter the “`SET OF`” variant.

集合元素的字符串表示实际上与序列元素的字符串表示相同。 只需将“`SEQUENCE`”替换为“`SET`”，将“`SEQUENCE OF`”替换为“`SET OF`”。 但是，考虑到集合中元素的顺序并不重要，您更有可能遇到“`SET OF`”变体。

总结： 

​	set的string表示和sequence的string表示相同，只需要将：`SEQUENCE`替换为`SET` ，将`SEQUENCE OF`替换为`SET OF`；

​	但是set中的元素的顺序并不重要；



#### 4.11 Specifying Choice Values(指定choice的值)

There may be cases in which you want to allow for one of several elements in a given slot in a sequence or set. You can accomplish that with a choice. The string representation of a choice element is very much like a sequence or a set, except that the encoded element can only contain one of the elements. For example:

在某些情况下，您可能希望  允许在sequence或set中包含  给定slot/槽 中的多个元素之一。 您可以通过choice/选择来实现这一点。 choice element的string表示非常类似于sequence或set，不同之处在于 编码时只能包含其中一个元素。 例如：

```ASN.1
NameValuePair ::= SEQUENCE {
     name      OCTET STRING,
     value     CHOICE {
          booleanValue     BOOLEAN,
          integerValue     INTEGER,
          stringValue      OCTET STRING } }
```

Most of the time, the encoded representation of the choice element is just the encoded representation of the element that is selected. For example, the encoded representation of the above sequence with a name of “age” and an integer value of 35 would be:

大多数时候，choice element的编码表示 只是被选择元素的编码表示。 例如，上述name为`age`且integerValue为 35 的sequence的编码表示为：

```ASN.1
30 08 -- Begin a universal sequence with a total value size of 8 bytes
   04 03 61 67 65 -- The universal octet string age
   02 01 23 -- The universal integer 35 (0x23)
```

This even works for most choice elements with custom element types. For example:

这甚至适用于 具有自定义元素类型的 大多数choice element。 例如：

```ASN.1
NameAndOctetStringValue ::= SEQUENCE {
     name      OCTET STRING,
     value     CHOICE {
          stringValue     [0] OCTET STRING,
          binaryValue     [1] OCTET STRING } } 
```

In this case, if you have a name of “hello” and a string value of “there” then the encoded representation would be:

在这种情况下，如果您有一个name=“hello”和stringValue=“there”，那么编码表示将是：

```ASN.1
30 0e -- Begin a universal sequence with a total value size of 14 bytes
   04 05 68 65 6c 6c 6f -- The universal octet string hello
   80 05 64 68 65 72 65 -- The context-specific primitive zero octet string there
```

However, there is a case in which this doesn’t work, and that is the case in which the choice element itself is defined with a custom BER type. For example:

但是，在某些情况下这不起作用，即choice element本身使用自定义 BER 类型定义的情况。 例如：

```ASN.1
NameAndOptionalValue ::= SEQUENCE {
     name      [0] OCTET STRING,
     value     [1] CHOICE {
          booleanValue     [2] BOOLEAN,
          integerValue     [3] INTEGER,
          stringValue      [4] OCTET STRING,
          binaryValue      [5] OCTET STRING } OPTIONAL }
```

In this case, the choice element is encoded as a constructed element, with a value that is the full encoding of the selected element inside that choice. For example, if you have a name of “state” and a string value of “Texas”, the encoding would be:

在这种情况下，choice element被编码为一个constructed元素，其值是该choice 中所选元素的完整编码。 例如，如果您的name为“state”，string值为“Texas”，则编码为：

```ASN.1
30 10 -- Begin a universal sequence with a total value size of 16 bytes
   80 05 73 74 61 74 65 -- The context-specific primitive zero octet string state
   A1 07 -- Begin a context-specific constructed one value size of 7 bytes
      84 05 54 65 78 61 73 -- The context-specific primitive four octet string Texas
```

总结: 

​	只允许在 `sequence`/`SET`中出现， choice element中列出的元素  的其中一个；

​	0x30 	是universal sequence

​	0x31	 是universal set

​		0x04	是universal octet string

​		0x02	是universal integer

​		0x80	是context-specific primitive zero octet string

​		0xA1	是context-specific constructed







| Previous: [LDAPv3 Wire Protocol Reference](https://ldap.com/ldapv3-wire-protocol-reference) | Next: [The `LDAPMessage` Sequence](https://ldap.com/ldapv3-wire-protocol-reference-ldap-message) |
| ------------------------------------------------------------ | ------------------------------------------------------------ |





