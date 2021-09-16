





Network Working Group                                    D. Crocker, Ed.
Request for Comments: 5234                   Brandenburg InternetWorking
STD: 68                                                       P. Overell
Obsoletes: 4234                                                THUS plc.
Category: Standards Track                                   January 2008

# Augmented BNF for Syntax Specifications: ABNF(增强型BNF语法规范: ABNF)



Status of This Memo

This document specifies an Internet standards track protocol for the Internet community, and requests discussion and suggestions for improvements.  Please refer to the current edition of the "Internet Official Protocol Standards" (STD 1) for the standardization state and status of this protocol.  Distribution of this memo is unlimited.

Abstract

Internet technical specifications often need to define a formal syntax.  Over the years, a modified version of Backus-Naur Form (BNF), called Augmented BNF (ABNF), has been popular among many Internet specifications.  The current specification documents ABNF. It balances compactness and simplicity with reasonable representational power.  The differences between standard BNF and ABNF involve naming rules, repetition, alternatives, order- independence, and value ranges.  This specification also supplies additional rule definitions and encoding for a core lexical analyzer of the type common to several Internet specifications.
Internet 技术规范通常需要定义正式的语法。 多年来，巴科斯-诺尔范式 (BNF) 的修改版本，称为增强型BNF (ABNF)，在许多 Internet 规范中都很流行。 当前规范文档 ABNF。 它平衡了紧凑性和简单性与合理的表现力。 标准 BNF 和 ABNF 之间的差异涉及命名规则、重复、可选、顺序无关和值范围。 该规范还为几个 Internet 规范共有的类型的核心词法分析器提供了额外的规则定义和编码。



## Table of Contents(目录)

```ABNF
Table of Contents
   1.  Introduction . . . . . . . . . . . . . . . . . . . . . . . . .  3
   2.  Rule Definition  . . . . . . . . . . . . . . . . . . . . . . .  3
     2.1.  Rule Naming  . . . . . . . . . . . . . . . . . . . . . . .  3
     2.2.  Rule Form  . . . . . . . . . . . . . . . . . . . . . . . .  4
     2.3.  Terminal Values  . . . . . . . . . . . . . . . . . . . . .  4
     2.4.  External Encodings . . . . . . . . . . . . . . . . . . . .  6
   3.  Operators  . . . . . . . . . . . . . . . . . . . . . . . . . .  6
     3.1.  Concatenation:  Rule1 Rule2  . . . . . . . . . . . . . . .  6
     3.2.  Alternatives:  Rule1 / Rule2 . . . . . . . . . . . . . . .  7
     3.3.  Incremental Alternatives: Rule1 =/ Rule2 . . . . . . . . .  7
     3.4.  Value Range Alternatives:  %c##-## . . . . . . . . . . . .  8
     3.5.  Sequence Group:  (Rule1 Rule2) . . . . . . . . . . . . . .  8
     3.6.  Variable Repetition:  *Rule  . . . . . . . . . . . . . . .  9
     3.7.  Specific Repetition:  nRule  . . . . . . . . . . . . . . .  9
     3.8.  Optional Sequence:  [RULE] . . . . . . . . . . . . . . . .  9
     3.9.  Comment:  ; Comment  . . . . . . . . . . . . . . . . . . .  9
     3.10. Operator Precedence  . . . . . . . . . . . . . . . . . . . 10
   4.  ABNF Definition of ABNF  . . . . . . . . . . . . . . . . . . . 10
   5.  Security Considerations  . . . . . . . . . . . . . . . . . . . 12
   6.  References . . . . . . . . . . . . . . . . . . . . . . . . . . 12
     6.1.  Normative References . . . . . . . . . . . . . . . . . . . 12
     6.2.  Informative References . . . . . . . . . . . . . . . . . . 12
   Appendix A.  Acknowledgements  . . . . . . . . . . . . . . . . . . 13
   Appendix B.  Core ABNF of ABNF . . . . . . . . . . . . . . . . . . 13
     B.1.  Core Rules . . . . . . . . . . . . . . . . . . . . . . . . 13
     B.2.  Common Encoding  . . . . . . . . . . . . . . . . . . . . . 15
```

# 1. Introduction(介绍)(不用看)

Internet technical specifications often need to define a formal syntax and are free to employ whatever notation their authors deem useful.  Over the years, a modified version of Backus-Naur Form (BNF), called Augmented BNF (ABNF), has been popular among many Internet specifications.  It balances compactness and simplicity with reasonable representational power.  In the early days of the Arpanet, each specification contained its own definition of ABNF.  This included the email specifications, [RFC733] and then [RFC822], which came to be the common citations for defining ABNF.  The current
document separates those definitions to permit selective reference. Predictably, it also provides some modifications and enhancements.
Internet 技术规范通常需要定义正式的语法，并且可以自由使用 作者认为有用的任何符号。多年来，巴科斯-诺尔表 (BNF) 的修改版本，称为增强 BNF (ABNF)，在许多 Internet 规范中都很流行。它在紧凑性和简单性与合理的表现力之间取得了平衡。在 Arpanet 的早期，每个规范都包含自己对 ABNF 的定义。这包括电子邮件规范、[RFC733] 和 [RFC822]，它们成为定义 ABNF 的常见引用。当前文档 将这些定义分开以允许选择性参考。可以预见的是，它还提供了一些修改和增强功能。

The differences between standard BNF and ABNF involve naming rules, repetition, alternatives, order-independence, and value ranges. Appendix B supplies rule definitions and encoding for a core lexical analyzer of the type common to several Internet specifications.  It is provided as a convenience and is otherwise separate from the meta language defined in the body of this document, and separate from its formal status.
标准 BNF 和 ABNF 之间的差异涉及命名规则、重复、可选、顺序无关和值范围。附录 B 提供了一些 Internet 规范通用类型的核心词法分析器的规则定义和编码。它是为了方便而提供的，并且与本文档正文中定义的元语言分开，并与其正式状态分开。

# 2. Rule Definition

## 2.1.  Rule Naming(规则名 的命名)

The name of a rule is simply the name itself, that is, a sequence of characters, beginning with an alphabetic character, and followed by a combination of alphabetics, digits, and hyphens (dashes).
规则的名称只是名称本身，即，一个字符序列，以字母字符开头，后跟字母、数字和连字符（破折号）的组合。

NOTE:
​	Rule names are case insensitive.
​	<font color=red>规则名称不区分大小写。</font>

The names <rulename>, <Rulename>, <RULENAME>, and <rUlENamE> all refer to the same rule.
名称 <rulename>、<Rulename>、<RULENAME> 和 <rUlENamE> 均指同一规则。

Unlike original BNF, angle brackets ("<", ">") are not required. However, angle brackets may be used around a rule name whenever their presence facilitates in discerning the use of a rule name.  This is typically restricted to rule name references in free-form prose, or to distinguish partial rules that combine into a string not separated by white space, such as shown in the discussion about repetition, below.
与原始 BNF 不同，不需要尖括号（“<”、“>”）。 然而，只要尖括号的存在有助于识别规则名称的使用，就可以在规则名称周围使用尖括号。 这通常仅限于自由形式散文中的规则名称引用，或区分组合成不由空格分隔的字符串的部分规则，例如下面关于重复的讨论中所示。



总结： 
	<font color=red>rule-name/规则名  的命名：是一个字符序列，以字母开头 后根字母/数字/连字符`-`  ；</font>
	<font color=red>和BNF不同，ABNF不需要使用`<>`，但也可以使用 ；</font>



## 2.2.  Rule Form(规则 的组成形式)

A rule is defined by the following sequence:
规则由以下序列定义：

```ABNF
     name =  elements crlf
     
     规则名    =     一个/多个规则名或终端规范     行尾
```

where <name> is the name of the rule, <elements> is one or more rule names or terminal specifications, and <crlf> is the end-of-line indicator (carriage return followed by line feed).  The equal sign separates the name from the definition of the rule.  The elements form a sequence of one or more rule names and/or value definitions, combined according to the various operators defined in this document, such as alternative and repetition.
其中 `<name>` 是规则的名称，`<elements>` 是一个或多个规则名称或终端规范，而 `<crlf> `是行尾指示符（回车后跟换行符）。 等号将名称与规则定义分开。 这些元素形成一个或多个规则名称和/或值定义的序列，根据本文档中定义的各种运算符（例如替代和重复）进行组合。

For visual ease, rule definitions are left aligned.  When a rule requires multiple lines, the continuation lines are indented.  The left alignment and indentation are relative to the first lines of the ABNF rules and need not match the left margin of the document.
为了视觉上的方便，规则定义左对齐。 当规则需要多行时，连续行会缩进。 左对齐和缩进是相对于 ABNF 规则的第一行，不需要与文档的左边距匹配。



## 2.3.  Terminal Values(终端值)

Rules resolve into a string of terminal values, sometimes called characters.  In ABNF, a character is merely a non-negative integer. In certain contexts, a specific mapping (encoding) of values into a character set (such as ASCII) will be specified.
规则解析为一串终端值，有时称为字符。 在 ABNF 中，字符只是一个非负整数。 在某些上下文中，将指定 值 到  字符集(例如 ASCII) 的特定映射(编码)。



- 指定数字字符

Terminals are specified by one or more numeric characters, with the base interpretation of those characters indicated explicitly.  The following bases are currently defined:
<font color=red>终端由一个或多个数字字符指定</font>，并明确指出这些字符的基本解释。 目前定义了以下基础：

```ABNF
         b           =  binary
         d           =  decimal
         x           =  hexadecimal

   Hence/因此:
         CR          =  %d13
         CR          =  %x0D
```
respectively specify the decimal and hexadecimal representation of [US-ASCII] for carriage return.
分别指定  回车[US-ASCII]  的十进制和十六进制表示。

A concatenated string of such values is specified compactly, using a period (".") to indicate a separation of characters within that value.  Hence:
此类值 的串联字符串 被紧凑地指定，使用句点 (".") 表示该值内的字符分隔。 因此：

```ABNF
     CRLF        =  %d13.10
```



- 指定 文本字符串

ABNF permits the specification of literal text strings directly, enclosed in quotation marks.  Hence:
ABNF 允许直接指定 文本字符串，用引号括起来。 因此：

```ABNF
     command     =  "command string"
```

Literal text strings are interpreted as a concatenated set of printable characters.
文字文本字符串 被解释为一组串联的可打印字符。



NOTE:ABNF strings are case insensitive and the character set for these  strings is US-ASCII.
注意：<font color=red>ABNF 字符串不区分大小写</font>，这些字符串的字符集是 US-ASCII。

```ABNF
   Hence/因此:
     rulename = "abc"
     
   and/和:
     rulename = "aBc"
     
   will match/将会匹配 "abc", "Abc", "aBc", "abC", "ABc", "aBC", "AbC", and "ABC".
```



To specify a rule that is case sensitive, specify the characters  individually.
<font color=red>要指定区分大小写的规则，请单独指定(每个)字符。</font>

```ABNF
   For example:
     rulename    =  %d97 %d98 %d99

   or
     rulename    =  %d97.98.99
     
   will match only the string that comprises only the lowercase characters, abc.
   将仅匹配仅包含小写字符 abc 的字符串。
```





## 2.4.  External Encodings(外部编码)

External representations of terminal value characters will vary according to constraints in the storage or transmission environment. Hence, the same ABNF-based grammar may have multiple external encodings, such as one for a 7-bit US-ASCII environment, another for a binary octet environment, and still a different one when 16-bit Unicode is used.  Encoding details are beyond the scope of ABNF, although Appendix B provides definitions for a 7-bit US-ASCII environment as has been common to much of the Internet.
终端值字符  的外部表示  将根据存储或传输环境中的限制而变化。 因此，相同的基于 ABNF 的语法可能有多种外部编码，例如一种用于 7 位 US-ASCII 环境，另一种用于二进制八位字节环境，并且在使用 16 位 Unicode 时仍然不同。 编码细节超出了 ABNF 的范围，尽管附录 B 提供了对 7 位 US-ASCII 环境的定义，这在互联网的大部分地区都是通用的。

By separating external encoding from the syntax, it is intended that alternate encoding environments can be used for the same syntax.
通过将外部编码与语法分开，旨在为相同的语法使用可选的编码环境。

总结： 

​	<font color=red>ABNF可以使用多种编码方式：7-bit US-ASCII，a binary octet，16-bit Unicode。</font>在本文档，这不是讨论的重点。



# 3. Operators(运算符)

## 3.1.  Concatenation:  Rule1 Rule2(串联)

A rule can define a simple, ordered string of values (i.e., a concatenation of contiguous characters) by listing a sequence of rule names.  For example:
规则可以  通过 列出一系列规则名称 来  定义一个简单的、有序的值字符串（即，连续字符的串联）。

```ABNF
     foo         =  %x61           ; a

     bar         =  %x62           ; b

     mumble      =  foo bar foo
```

So that the rule <mumble> matches the lowercase string "aba".
所以规则 <mumble> 匹配小写字符串“aba”。



Linear white space: Concatenation is at the core of the ABNF parsing model.  A string of contiguous characters (values) is parsed according to the rules defined in ABNF.  For Internet specifications, there is some history of permitting linear white space (space and horizontal tab) to be freely and implicitly interspersed around major constructs, such as delimiting special characters or atomic strings.
线性空白：拼接/级联 是ABNF解析模型的核心。 
根据 ABNF中定义的规则 解析一串连续字符（值）。 
对于 Internet 规范，有一些历史允许线性空白（空格和水平制表符）自由且隐式地散布在主要结构周围，例如分隔特殊字符或原子字符串。

NOTE: This specification for ABNF does not provide for implicit specification of linear white space.
注意：该 ABNF 规范不提供线性空白的隐式规范。

Any grammar that wishes to permit linear white space around delimiters or string segments must specify it explicitly.  It is often useful to provide for such white space in "core" rules that are then used variously among higher-level rules.  The "core" rules might be formed into a lexical analyzer or simply be part of the main ruleset.
任何希望在分隔符或字符串段周围允许线性空白的语法都必须明确指定。 在“核心”规则中提供这样的空白通常很有用，然后在更高级别的规则中以各种方式使用。 “核心”规则可能会形成词法分析器或只是主要规则集的一部分。





## 3.2.  Alternatives:  Rule1 / Rule2(可选的  二选1)

Elements separated by a forward slash ("/") are alternatives. Therefore,
由 正斜杠`/` 分隔的元素 是可选的元素。所以，

```ABNF
     foo / bar
```
will accept <foo> or <bar>.
将接受 `<foo>`或`<bar>`



NOTE: A quoted string containing alphabetic characters is a special form for specifying alternative characters and is interpreted as a non-terminal representing the set of combinatorial strings with the contained characters, in the specified order but with any mixture of upper- and lowercase.
注意：包含字母字符的带引号的字符串  是用于指定 可选 字符的特殊形式，并被解释为非终结符，表示包含字符的组合字符串集，按指定的顺序，但可以混合使用大写和小写。



<font color=red>总结： 使用 `/` 分隔的元素是可选的(二选一 或 多选一)</font>



## 3.3.  Incremental Alternatives: Rule1 =/ Rule2

It is sometimes convenient to specify a list of alternatives in fragments.  That is, an initial rule may match one or more alternatives, with later rule definitions adding to the set of alternatives.  This is particularly useful for otherwise independent specifications that derive from the same parent ruleset, such as often occurs with parameter lists.  ABNF permits this incremental definition through the construct:
有时在片段中指定一个备选列表是很方便的。 也就是说，初始规则可以匹配一个或多个备选方案，随后的规则定义添加到备选方案集合中。 这对于源自相同父规则集的其他独立规范特别有用，例如经常出现在参数列表中。 ABNF 通过以下构造允许这种增量定义：

```ABNF
     oldrule     =/ additional-alternatives

   So that the ruleset     所以ruleset
     ruleset     =  alt1 / alt2
     ruleset     =/ alt3
     ruleset     =/ alt4 / alt5

   is the same as specifying 等价于
     ruleset     =  alt1 / alt2 / alt3 / alt4 / alt5
```



<font color=red>总结: 使用 `=/` 定义 备选列表</font>



## 3.4.  Value Range Alternatives:  %c##-## (指定数值的范围)

A range of alternative numeric values can be specified compactly, using a dash ("-") to indicate the range of alternative values. Hence:
可以使用短划线（“-”）来指示替代值的范围，可以紧凑地指定可选数值的范围。 因此：

```ABNF
     DIGIT       =  %x30-39

   is equivalent to:  相当于
     DIGIT       =  "0" / "1" / "2" / "3" / "4" / "5" / "6" /
                    "7" / "8" / "9"
```

Concatenated numeric values and numeric value ranges cannot be specified in the same string.  A numeric value may use the dotted notation for concatenation or it may use the dash notation to specify one value range.  Hence, to specify one printable character between end-of-line sequences, the specification could be:
不能在同一字符串中指定 串联数值和数值范围。 数值可以使用点号表示连接，也可以使用短划线表示法来指定一个值范围。 因此，要在行尾序列之间指定一个可打印字符，规范可以是：

```ABNF
     char-line = %x0D.0A %x20-7E %x0D.0A
```

总结： 
​	数值可以用`.`连接；
​	可以用`-`指定一个数值范围；即%c##-##  (其中c 代表了 几进制)  ；并在行尾和序列之间指定一个可打印字符  （%x0D是回车键 0x0A是换行键）



## 3.5.  Sequence Group:  (Rule1 Rule2)(序列分组)

Elements enclosed in parentheses are treated as a single element, whose contents are strictly ordered.  Thus,
括号中的元素被视为单个元素，其内容是严格排序的。 因此，
```
         elem (foo / bar) blat
matches (elem foo blat) or (elem bar blat), and

         elem foo / bar blat
matches (elem foo) or (bar blat).
```
NOTE: It is strongly advised that grouping notation be used, rather than relying on the proper reading of "bare" alternations, when alternatives consist of multiple rule names or literals. Hence, it is recommended that the following form be used:
注意：当替代/可选项由多个规则名称或文字组成时，强烈建议使用分组符号，而不是依赖于对“裸”替代项的正确阅读。 因此，建议使用以下表格：

```ABNF
    (elem foo) / (bar blat)
```

It will avoid misinterpretation by casual readers.
它将避免普通读者的误解。

The sequence group notation is also used within free text to set off an element sequence from the prose.
序列组符号也用于自由文本中，以从散文中引出元素序列。



<font color=red>总结：建议使用 `()`进行分组   如对于: elem foo / bar blat  推荐形式为: (elem foo) / (bar blat) </font>



## 3.6.  Variable Repetition:  *Rule(使用`*`代表元素可以重复)

The operator "*" preceding an element indicates repetition.  The full form is:
元素前面的运算符`*`表示重复。 完整的表格是：

         <a>*<b>element

where <a> and <b> are optional decimal values, indicating at least  <a> and at most <b> occurrences of the element.
其中 <a> 和 <b> 是可选的十进制值，表示元素至少出现` <a>` 次，最多出现 `<b>` 次。

Default values are 0 and infinity so that *<element> allows any number, including zero; 1*<element> requires at least one; 3*3<element> allows exactly 3; and 1*2<element> allows one or two.
默认值为 0 和无穷大，因此 `*<element> `允许任何次数/个数，包括零； `1*<element>` 至少需要一个； `3*3<element> `允许 3个； 和 `1*2<element>` 允许一两个。

<font color=red>`<a>*<b><element>` 表示元素至少出现a次 最多出现b次</font>





## 3.7.  Specific Repetition:  nRule(正好出现n次)

```
   A rule of the form:
         <n>element

   is equivalent to
         <n>*<n>element
```
That is, exactly <n> occurrences of <element>.  Thus, 2DIGIT is a 2-digit number, and 3ALPHA is a string of three alphabetic characters.
也就是说，正好 <n> 次出现 <element>。 因此，2DIGIT 是一个 2 位数字，而 3ALPHA 是一个由三个字母字符组成的字符串。

<font color=red>`<n><element>` 表示元素正好出现n次 ，等价于`<n>*<n>element`</font>





## 3.8.  Optional Sequence:  [RULE] (出现0次或1次)

Square brackets enclose an optional element sequence:
方括号包含一个可选的元素序列：

```
         [foo bar]

   is equivalent to

         *1(foo bar).
```
<font color=red>`[]` 表示元素出现0次或1次</font>





## 3.9.  Comment:  ; Comment(注释)

A semicolon starts a comment that continues to the end of line.  This is a simple way of including useful notes in parallel with the specifications.
分号`;`开始注释，一直到行尾。 这是一种在规范的同时包含有用注释的简单方法。

<font color=red>`;` 表示 开始注释，一直到行尾</font>



## 3.10.  Operator Precedence(运算符优先级)

The various mechanisms described above have the following precedence, from highest (binding tightest) at the top, to lowest (loosest) at the bottom:
上述各种机制具有以下优先级，从顶部最高（绑定最紧密）到底部最低（最松散）：
```
      Rule name, prose-val, Terminal value
    
      Comment注释
    
      Value range 取值范围
    
      Repetition  重复
    
      Grouping, Optional 分组`()`    出现0次或1次`[]`
    
      Concatenation 串联(连续摆放 空格分隔开 即为串联)
    
      Alternative   备选`/`
```
Use of the alternative operator, freely mixed with concatenations, can be confusing.
使用与串联随意混合的`/`运算符可能会令人困惑。

Again, it is recommended that the grouping operator be used to make explicit concatenation groups.
同样，建议使用分组`()`运算符来创建显式连接组。



<font color=red>总结：推荐使用分组运算符`()`</font>



# <font color=red>4. ABNF Definition of ABNF(！！！)</font>

NOTES:

1.This syntax requires a formatting of rules that is relatively strict.  Hence, the version of a ruleset included in a specification might need preprocessing to ensure that it can be interpreted by an ABNF parser.
此语法需要相对严格的规则格式。 因此，规范中包含的规则集版本可能需要预处理以确保它可以被 ABNF 解析器解释。

2.This syntax uses the rules provided in Appendix B.
此语法使用附录 B 中提供的规则。



总结：为了使能被ABNF解析器解释，必须使用附录B中的预处理



```
         rulelist       =  1*( rule / (*c-wsp c-nl) )
    
         rule           =  rulename defined-as elements c-nl		
                                ; continues if next line starts
                                ;  with white space
    
         rulename       =  ALPHA *(ALPHA / DIGIT / "-")  ;大写或小写字母开头 后跟 字母/数字/-
         defined-as     =  *c-wsp ("=" / "=/") *c-wsp
                                ; basic rules definition and
                                ;  incremental alternatives
         elements       =  alternation *c-wsp
    
         c-wsp          =  WSP / (c-nl WSP)						; `空白符号(空格/Tab键)`  或 `注释或回车+换行`
         c-nl           =  comment / CRLF						; 注释 或 回车+换行
                                ; comment or newline
         comment        =  ";" *(WSP / VCHAR) CRLF				;注释
    
         alternation    =  concatenation						; /
                           *(*c-wsp "/" *c-wsp concatenation)
         concatenation  =  repetition *(1*c-wsp repetition)
    
         repetition     =  [repeat] element						;重复
         repeat         =  1*DIGIT / (*DIGIT "*" *DIGIT)		;重复
    
         element        =  rulename / group / option /			;元素：可以是规则名 () [] 字符 数字 
                           char-val / num-val / prose-val
    
         group          =  "(" *c-wsp alternation *c-wsp ")"	; ()
    
         option         =  "[" *c-wsp alternation *c-wsp "]"	; []
    
         char-val       =  DQUOTE *(%x20-21 / %x23-7E) DQUOTE	;字符的表示 括在""之间
                                ; quoted string of SP and VCHAR
                                ;  without DQUOTE
    
         num-val        =  "%" (bin-val / dec-val / hex-val)  	;数字
         bin-val        =  "b" 1*BIT							;二进制数
                           [ 1*("." 1*BIT) / ("-" 1*BIT) ]
                                ; series of concatenated bit values
                                ;  or single ONEOF range
         dec-val        =  "d" 1*DIGIT							;十进制数
                           [ 1*("." 1*DIGIT) / ("-" 1*DIGIT) ]
         hex-val        =  "x" 1*HEXDIG							;十六进制数
                           [ 1*("." 1*HEXDIG) / ("-" 1*HEXDIG) ]
         prose-val      =  "<" *(%x20-3D / %x3F-7E) ">" 		; 括在<>之间
                                ; bracketed string of SP and VCHAR
                                ;  without angles
                                ; prose description, to be used as
                                ;  last resort
```



# 5.Security Considerations

Security is truly believed to be irrelevant to this document.



# 6. References

6.1.  Normative References

   [US-ASCII]  American National Standards Institute, "Coded Character
               Set -- 7-bit American Standard Code for Information
               Interchange", ANSI X3.4, 1986.

6.2.  Informative References

   [RFC733]    Crocker, D., Vittal, J., Pogran, K., and D. Henderson,
               "Standard for the format of ARPA network text messages",
               RFC 733, November 1977.

   [RFC822]    Crocker, D., "Standard for the format of ARPA Internet
               text messages", STD 11, RFC 822, August 1982.



# Appendix A.  Acknowledgements(致谢)

   The syntax for ABNF was originally specified in RFC 733.  Ken L.
   Harrenstien, of SRI International, was responsible for re-coding the
   BNF into an Augmented BNF that makes the representation smaller and
   easier to understand.

   This recent project began as a simple effort to cull out the portion
   of RFC 822 that has been repeatedly cited by non-email specification
   writers, namely the description of Augmented BNF.  Rather than simply
   and blindly converting the existing text into a separate document,
   the working group chose to give careful consideration to the
   deficiencies, as well as benefits, of the existing specification and
   related specifications made available over the last 15 years, and
   therefore to pursue enhancement.  This turned the project into
   something rather more ambitious than was first intended.
   Interestingly, the result is not massively different from that
   original, although decisions, such as removing the list notation,
   came as a surprise.

   This "separated" version of the specification was part of the DRUMS
   working group, with significant contributions from Jerome Abela,
   Harald Alvestrand, Robert Elz, Roger Fajman, Aviva Garrett, Tom
   Harsch, Dan Kohn, Bill McQuillan, Keith Moore, Chris Newman, Pete
   Resnick, and Henning Schulzrinne.

   Julian Reschke warrants a special thanks for converting the Draft
   Standard version to XML source form.

# Appendix B.  Core ABNF of ABNF

   This appendix contains some basic rules that are in common use.
   Basic rules are in uppercase.  Note that these rules are only valid
   for ABNF encoded in 7-bit ASCII or in characters sets that are a
   superset of 7-bit ASCII.

## <font color=red>B.1.  Core Rules(核心rule！！！)</font>

Certain basic rules are in uppercase, such as SP, HTAB, CRLF, DIGIT,  ALPHA, etc.
某些基本规则是大写的，例如 SP、HTAB、CRLF、DIGIT、ALPHA 等。

```ABNF
         ALPHA          =  %x41-5A / %x61-7A   ; A-Z / a-z  ;路径是大写或小写字母组成
    
         BIT            =  "0" / "1"						;bit是0或1
    
         CHAR           =  %x01-7F							; 字符是ASCII，这是个值的范围
                                ; any 7-bit US-ASCII character,
                                ;  excluding NUL

         CR             =  %x0D								;回车
                                ; carriage return
    
         CRLF           =  CR LF							;Internet标准的 回车+换行 --> 新的一行
                                ; Internet standard newline
    
         CTL            =  %x00-1F / %x7F
                                ; controls
    
         DIGIT          =  %x30-39							;字符"0"到"9"
                                ; 0-9
    
         DQUOTE         =  %x22								; 双引号`"`
                                ; " (Double Quote)
    
         HEXDIG         =  DIGIT / "A" / "B" / "C" / "D" / "E" / "F" ;字符"0"到"9"和 "A"到"F"
    
         HTAB           =  %x09								;tab键
                                ; horizontal tab
    
         LF             =  %x0A								;换行
                                ; linefeed
    
         LWSP           =  *(WSP / CRLF WSP)				;多个`(空格/Tab键)`或`回车+换行+(空格/Tab键)` 
                                ; Use of this linear-white-space rule ; 不要在邮件标题中使用LMSP
                                ;  permits lines containing only white; 在其他上下文中 也要谨慎使用LMSP
                                ;  space that are no longer legal in
                                ;  mail headers and have caused
                                ;  interoperability problems in other
                                ;  contexts.
                                ; Do not use when defining mail
                                ;  headers and use with caution in
                                ;  other contexts.
    
         OCTET          =  %x00-FF							;8位字符/8位数据
                                ; 8 bits of data
    
         SP             =  %x20								;空格
    
         VCHAR          =  %x21-7E							;可见（打印）字符
                                ; visible (printing) characters
    
         WSP            =  SP / HTAB						;空白符号(空格/Tab键)
                                ; white space

```

## B.2.  Common Encoding

   Externally, data are represented as "network virtual ASCII" (namely,
   7-bit US-ASCII in an 8-bit field), with the high (8th) bit set to
   zero.  A string of values is in "network byte order", in which the
   higher-valued bytes are represented on the left-hand side and are
   sent over the network first.

# Authors' Addresses

   Dave Crocker (editor)
   Brandenburg InternetWorking
   675 Spruce Dr.
   Sunnyvale, CA  94086
   US

   Phone: +1.408.246.8253
   EMail: dcrocker@bbiw.net

   Paul Overell
   THUS plc.
   1/2 Berkeley Square,
   99 Berkeley Street
   Glasgow  G3 7HR
   UK

   EMail: paul.overell@thus.net

# Full Copyright Statement

   Copyright (C) The IETF Trust (2008).

   This document is subject to the rights, licenses and restrictions
   contained in BCP 78, and except as set forth therein, the authors
   retain all their rights.

   This document and the information contained herein are provided on an
   "AS IS" basis and THE CONTRIBUTOR, THE ORGANIZATION HE/SHE REPRESENTS
   OR IS SPONSORED BY (IF ANY), THE INTERNET SOCIETY, THE IETF TRUST AND
   THE INTERNET ENGINEERING TASK FORCE DISCLAIM ALL WARRANTIES, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO ANY WARRANTY THAT THE USE OF
   THE INFORMATION HEREIN WILL NOT INFRINGE ANY RIGHTS OR ANY IMPLIED
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












Crocker & Overell           Standards Track                    [Page 16]

