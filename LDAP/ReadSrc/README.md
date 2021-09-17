# openldap-2.4.49+dfsg-debian-源码阅读

```bash
$ apt source openldap

$ ll
drwxrwxr-x 12 gos gos    4096 9月   8 09:50 openldap-2.4.49+dfsg/
-rw-r--r--  1 gos gos  187956 4月  15 07:33 openldap_2.4.49+dfsg-2ubuntu1.8.debian.tar.xz
-rw-r--r--  1 gos gos    3136 4月  15 07:33 openldap_2.4.49+dfsg-2ubuntu1.8.dsc
-rw-r--r--  1 gos gos 4844726 2月  10  2020 openldap_2.4.49+dfsg.orig.tar.gz
```





# BER

/include/lber.h

```c
//-------------------------------------------------------------------------------
//openLDAPdebian/openldap-2.4.49+dfsg/include/lber.h
/*
 * ber_tag_t represents the identifier octets at the beginning of BER
 * elements.  OpenLDAP treats them as mere big-endian unsigned integers.
 * ber_tag_t表示 BER元素开始处的 8位字节标识符。
 * OpenLDAP将它们仅仅看作大端无符号整数。
 *
 * Actually the BER identifier octets look like this:
 * 实际上，BER标识的 所谓8位字节 看起来是这样的：
 *
 *	Bits of 1st octet:
 *	______
 *	8 7 | CLASS
 *	0 0 = UNIVERSAL
 *	0 1 = APPLICATION
 *	1 0 = CONTEXT-SPECIFIC
 *	1 1 = PRIVATE
 *		_____
 *		| 6 | DATA-TYPE
 *		  0 = PRIMITIVE
 *		  1 = CONSTRUCTED
 *			___________
 *			| 5 ... 1 | TAG-NUMBER
 *
 *  For ASN.1 tag numbers >= 0x1F, TAG-NUMBER above is 0x1F and the next
 *  BER octets contain the actual ASN.1 tag number:  Big-endian, base
 *  128, 8.bit = 1 in all but the last octet, minimum number of octets.
 *  对于ASN.1 tag number >= 0x1F，
 *  	TAG-NUMBER的开头是0x1F，下一个BER 8位字节包含实际的ASN.1 tag number:
 *			Big-endian, base 128, 8。
 *  除了最后一个8位字节外，所有位都是1，这是最小的8位字节数。
 */
 

```







# schema



## servers/slapd/schema_init.c



```c
/*
 * Syntaxes - implementation notes:
 *
Validate function(syntax, value):
	Called before the other functions here to check if the value is valid according to the syntax.
	在其他函数之前调用，根据语法检查值是否有效。

Pretty function(syntax, input value, output prettified...):
	If it exists, maps different notations of the same value to a unique representation which can be stored in the directory and possibly be passed to the Match/Indexer/Filter() functions.
	如果存在，将相同值的不同表示法映射到一个唯一表示，该表示可以存储在目录中，并可能被传递给Match/Indexer/Filter()函数。
 
	E.g. DN "2.5.4.3 = foo\,bar, o = BAZ" -> "cn=foo\2Cbar,o=BAZ", but unlike DN normalization, "BAZ" is not mapped to "baz".
	例如："2.5.4.3 = foo\,bar, o = BAZ" -> "cn=foo\2Cbar,o=BAZ",
	但不像DN规范化，"BAZ"没有映射到"baz"。

 */


/*
 * Matching rules - implementation notes:
 *
Matching rules match an attribute value (often from the directory) against an asserted value (e.g. from a filter).
匹配规则将 属性值(通常来自目录) 与 断言值(例如来自过滤器) 进行匹配。
 
Invoked with validated and commonly pretty/normalized arguments, thus a number of matching rules can simply use the octetString functions.
使用 经过验证的、通常很漂亮的/规范化的参数 调用，因此许多匹配规则可以简单地使用octetString函数。
 
 
Normalize function(...input value, output normalized...):
	If it exists, maps matching values to a unique representation   which is passed to the Match/Indexer/Filter() functions.
	如果存在，将匹配值映射到一个惟一的表示，该表示传递给Match/Indexer/Filter()函数。
   
	Different matching rules can normalize values of the same syntax  differently.  E.g. caseIgnore rules normalize to lowercase,  caseExact rules do not.
	不同的匹配规则会以不同的方式对相同语法的值进行规范化。例如，caseIgnore规则规范化为小写，caseExact规则则不会。


Match function(*output matchp, ...value, asserted value):
    On success, set *matchp.  0 means match.  For ORDERING/most EQUALITY,less/greater than 0 means value less/greater than asserted.  However:
    成功时，设置*matchp。0表示匹配。
    对于ORDERING/most EQUALITY,小于/大于0表示值小于/大于断言值。然而:
 
    In extensible match filters, ORDERING rules match if value<asserted.
    在可扩展匹配过滤器中，如果 值<断言(value<asserted)，则排序规则(ORDERING rules)匹配。
 
    EQUALITY rules may order values differently than ORDERING rules for speed, since EQUALITY ordering is only used for SLAP_AT_SORTED_VAL. Some EQUALITY rules do not order values (ITS#6722).
    相等规则(EQUALITY rules) 对值的排序 可能与排序规则(ORDERING rules)的速度不同，因为相等排序只用于SLAP_AT_SORTED_VAL。有些相等规则(EQUALITY rules)不排序值(ITS#6722)。
 

Indexer function(...attribute values, *output keysp,...):
    Generates index keys for the attribute values.  Backends can store them in an index, a {key->entry ID set} mapping, for the attribute.
    为属性值(attribute values)生成索引键(index key)。
    后端可以将它们存储在属性的索引(一个{key->entry ID set}映射)中。
 
    A search can look up the DN/scope and asserted values in the indexes, if any, to narrow down the number of entires to check against the search criteria.
    搜索可以在索引中查找DN/scope和断言值,如果有的话,
    以缩小要根据搜索条件检查的条目数量。

 
Filter function(...asserted value, *output keysp,...):
    Generates index key(s) for the asserted value, to be looked up in the index from the Indexer function.  *keysp is an array because substring matching rules can generate multiple lookup keys.
    为断言值生成索引键，以便在Indexer函数的索引中查找。
    *keysp是一个数组，因为子字符串匹配规则可以生成多个查找键。
 
 
Index keys:
    A key is usually a hash of match type, attribute value and schema info, because one index can contain keys for many filtering types.
    键通常是 匹配类型、属性值和模式信息 的散列，因为一个索引可以包含许多过滤类型的键。
 
    Some indexes instead have EQUALITY keys ordered so that if key(val1) < key(val2), then val1 < val2 by the ORDERING rule. That way the ORDERING rule can use the EQUALITY index.
    有些索引的EQUALITY键是按顺序排列的，如果key(val1) < key(val2)，那么根据ORDERING规则，val1 < val2。这样，ORDERING规则就可以使用EQUITY索引。
 
 
Substring indexing:
    This chops the attribute values up in small chunks and indexes all possible chunks of certain sizes.  Substring filtering looks up SOME of the asserted value's chunks, and the caller uses the intersection of the resulting entry ID sets. See the index_substr_* keywords in slapd.conf(5).
    这将属性值分割成小块，并对所有可能的特定大小的块进行索引。
    子字符串过滤查找一些断言值的块，调用者使用生成的entry ID sets的交集。
    参见slapd.conf(5)中的index_substr_*关键字。

 */


```



















# DN

### /servers/slapd/dn.c

```c
//-------------------------------------------------------------------------------

/*
The DN syntax-related functions take advantage of the dn representation
 * handling functions ldap_str2dn/ldap_dn2str.  The latter are not schema-
 * aware, so the attributes and their values need be validated (and possibly
 * normalized).  In the current implementation the required validation/nor-
 * malization/"pretty"ing are done on newly created DN structural represen-
 * tations; however the idea is to move towards DN handling in structural
 * representation instead of the current string representation.  To this
 * purpose, we need to do only the required operations and keep track of
 * what has been done to minimize their impact on performances.
与DN语法相关的函数利用  DN表示处理函数ldap_str2dn/ldap_dn2str。
后者不支持schema识别，因此需要验证属性及其值(可能还需要规范化)。

在当前的实现中，需要 对新创建的DN结构表示 进行验证/正规化/美化;
然而，其想法是在结构表示中转向DN处理，而不是当前的字符串表示。
为了达到这个目的，我们只需要执行所需的操作，并跟踪已经完成的操作，以最小化它们对性能的影响。

Developers are strongly encouraged to use this feature, to speed-up its stabilization.
强烈鼓励开发人员使用这个特性，以加快其稳定性。
 */

static int LDAPRDN_validate( LDAPRDN rdn );//验证每个RDN的有效性

/*
In-place, schema-aware validation of the structural representation of a distinguished name.
对DN的结构化表示进行schema识别 的就地验证
 */
static int LDAPDN_validate( LDAPDN dn );//验证DN的有效性，-->> 验证每个RDN的有效性



```







## /libraries/libldap/getdn.c

```c







//-------------------------------------------------------------------------------


//-------------------------------------------------------------------------------



//-------------------------------------------------------------------------------



//-------------------------------------------------------------------------------
/*
Converts a string representation of a DN (in LDAPv3, LDAPv2 or DCE) into a structural representation of the DN, by separating attribute types and values encoded in the more appropriate form, which is string or OID for attribute types and binary form of the BER encoded value or Unicode string. Formats different from LDAPv3 are parsed according to their own rules and turned into the more appropriate form according to LDAPv3. 
 将 字符串(string)表示的DN(LDAPv3 LDAPv2或DCE)转换成 结构化表示的DN,
 通过 分隔 属性类型和值 以更合适的形式编码 ,
 这是属性类型 的字符串或OID形式 和 BER编码值或者Unicode字符串 的二进制形式。
 不同于LDAPv3的格式将根据它们自己的规则进行解析，并根据LDAPv3将其转换为更合适的形式。

NOTE: I realize the code is getting spaghettish; it is rather experimental and will hopefully turn into something more simple and readable as soon as it works as expected.
注意:
	我意识到代码变得像意大利面条一样;
	它是相当试验性的，
	只要它能像预期的那样工作，就有希望变成更简单和可读的东。
 */
/*
Default sizes of AVA and RDN static working arrays; if required the are dynamically resized.  The values can be tuned in case of special requirements (e.g. very deep DN trees or high number of AVAs per RDN).
 AVA和RDN静态工作数组的默认大小;   （AVA RND DNB的定义  见下面）
 如果需要，则动态调整大小。
 这些值可以在特殊需求的情况下进行调优(例如，非常深的DN树或每个RDN有大量的ava)。
 */
#define	TMP_AVA_SLOTS	8
#define	TMP_RDN_SLOTS	32

int ldap_str2dn( LDAP_CONST char *str, LDAPDN *dn, unsigned flags )
int ldap_bv2dn( struct berval *bv, LDAPDN *dn, unsigned flags )
int ldap_bv2dn_x( struct berval *bvin, LDAPDN *dn, unsigned flags, void *ctx )
    	//首先进行 有效性判断
    	// 判断LDAP的协议版本

    
//-------------------------------------------------------------------------------
    
    
    
//-------------------------------------------------------------------------------
    /string     

```











# 数据类型

## AVA RND DN的定义

```c
// /include/ldap.h

typedef struct ldap_ava {
	struct berval la_attr;
	struct berval la_value;
	unsigned la_flags;
#define LDAP_AVA_NULL				0x0000U
#define LDAP_AVA_STRING				0x0001U
#define LDAP_AVA_BINARY				0x0002U
#define LDAP_AVA_NONPRINTABLE		0x0004U
#define LDAP_AVA_FREE_ATTR			0x0010U
#define LDAP_AVA_FREE_VALUE			0x0020U

	void *la_private;
} LDAPAVA;

//每个RND都是一个结构体指针数组(每个元素是个指针，指针指向结构体)(因为RND可能是多值的，所以是个数组)
typedef LDAPAVA** LDAPRDN;
typedef LDAPRDN* LDAPDN; // DN是个数组，每个元素是个RDN，每个RDN即为LDAPRDN


```







## ber_tag_t

```c
// openLDAPdebian/openldap-2.4.49+dfsg/doc/man/man3/lber-types.3
typedef impl_tag_t ber_tag_t; 

// openLDAPdebian/openldap-2.4.49+dfsg/include/lber_types.hin
/* tags */
typedef unsigned LBER_TAG_T ber_tag_t;

// openLDAPdebian/openldap-2.4.49+dfsg/configure
$as_echo "#define LBER_TAG_T long" >>confdefs.h
#define LBER_TAG_T long

// openLDAPdebian/openldap-2.4.49+dfsg/configure.in
AC_DEFINE(LBER_TAG_T,long,[define to large integer type])

// -->> ber_tag_t 即为 unsigned long

```









## struct berval

```c
/* 
structure for returning a sequence of octet strings + length 
 对 返回的8位字节序列 结构化，
 {
  length ; 
  string ;
  }
*/
typedef struct berval {
	ber_len_t	bv_len;
	char		*bv_val;
} BerValue;

typedef BerValue *BerVarray;	/* To distinguish from a single bv */

/* this should be moved to lber-int.h */
```





## struct AttributeDescription

```c
//openLDAPdebian/openldap-2.4.49+dfsg/servers/slapd/slap.h
/* Represents a recognized attribute description ( type + options ). */
struct AttributeDescription {
	AttributeDescription	*ad_next;
	AttributeType		*ad_type;	/* attribute type, must be specified */
	struct berval		ad_cname;	/* canonical name, must be specified */
	struct berval		ad_tags;	/* empty if no tagging options */
	unsigned ad_flags;
#define SLAP_DESC_NONE		0x00U
#define SLAP_DESC_BINARY	0x01U
#define SLAP_DESC_TAG_RANGE	0x80U
#define SLAP_DESC_TEMPORARY	0x1000U
	unsigned ad_index;
};


//
typedef struct AttributeDescription AttributeDescription;

```





