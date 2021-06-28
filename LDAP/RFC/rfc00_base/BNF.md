# [Backus–Naur form](https://en.wikipedia.org/wiki/Backus%E2%80%93Naur_form)

From Wikipedia, the free encyclopedia
维基百科，自由的百科全书

Not to be confused with [Boyce–Codd normal form](https://en.wikipedia.org/wiki/Boyce–Codd_normal_form).
不要与[Boyce-Codd 范式]混淆。

In [computer science](https://en.wikipedia.org/wiki/Computer_science), **Backus–Naur form**[*[pronunciation?](https://en.wikipedia.org/wiki/Wikipedia:Manual_of_Style/Pronunciation)*] or **Backus normal form** (**BNF**) is a [metasyntax](https://en.wikipedia.org/wiki/Metasyntax) notation for [context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar), often used to describe the [syntax](https://en.wikipedia.org/wiki/Syntax_(programming_languages)) of [languages](https://en.wikipedia.org/wiki/Formal_language#Programming_languages) used in computing, such as computer [programming languages](https://en.wikipedia.org/wiki/Programming_language), [document formats](https://en.wikipedia.org/wiki/Document_format), [instruction sets](https://en.wikipedia.org/wiki/Instruction_set) and [communication protocols](https://en.wikipedia.org/wiki/Communication_protocol). They are applied wherever exact descriptions of languages are needed: for instance, in official language specifications, in manuals, and in textbooks on programming language theory.

在计算机科学中，**Backus–Naur form**/**巴科斯-诺尔范式**或 **Backus normal form** (**BNF**)/**巴科斯范式**  是一种用于表示上下文无关文法的元语法，常用于描述计算机中使用的语言 的语法，例如 计算机编程语言,文档格式,指令集和通信协议。它们适用于需要对语言进行精确描述的任何地方：例如，在官方语言规范、手册和编程语言理论的教科书中。

Many extensions and variants of the original Backus–Naur notation are used; some are exactly defined, including [extended Backus–Naur form](https://en.wikipedia.org/wiki/Extended_Backus–Naur_form) (EBNF) and [augmented Backus–Naur form](https://en.wikipedia.org/wiki/Augmented_Backus–Naur_form) (ABNF).
原始巴科斯符号 的许多扩展和变体 被使用；有些是精确定义的，包括 扩展型巴科斯范式[EBNF] 和 增强型巴科斯范式[ABNF]。



## Contents(目录/内容)

- [1History](https://en.wikipedia.org/wiki/Backus–Naur_form#History)(历史)
- [2Introduction](https://en.wikipedia.org/wiki/Backus–Naur_form#Introduction)(介绍)
- [3Example](https://en.wikipedia.org/wiki/Backus–Naur_form#Example)(例子)
- [4Further examples](https://en.wikipedia.org/wiki/Backus–Naur_form#Further_examples)(进一步的例子)
- 5Variants(变体)
    - [5.1Software using BNF](https://en.wikipedia.org/wiki/Backus–Naur_form#Software_using_BNF)(使用BNF的软件)
- [6See also](https://en.wikipedia.org/wiki/Backus–Naur_form#See_also)(也可以看看)
- [7References](https://en.wikipedia.org/wiki/Backus–Naur_form#References)(参考)
- 8External links(外部链接)
    - [8.1Language grammars](https://en.wikipedia.org/wiki/Backus–Naur_form#Language_grammars)(语言语法)

## History(历史)

The idea of describing the structure of language using [rewriting rules](https://en.wikipedia.org/wiki/Rewrite_rule) can be traced back to at least the work of [Pāṇini](https://en.wikipedia.org/wiki/Pāṇini), an ancient Indian Sanskrit grammarian and a revered scholar in Hinduism who lived sometime between the 6th and 4th century [BCE](https://en.wikipedia.org/wiki/BCE).[[1\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-1)[[2\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-2) His notation to describe [Sanskrit](https://en.wikipedia.org/wiki/Sanskrit) word structure is equivalent in power to that of Backus and has many similar properties.
使用重写规则描述语言结构的想法至少可以追溯到Pāṇini的工作，Pāṇini是一位古印度梵文语法学家，也是一位受人尊敬的印度教学者，他生活在公元前6 至 4 世纪之间。他描述梵文词结构的记法与巴库斯的记法相当，并且具有许多相似的性质。

In Western society, grammar was long regarded as a subject for teaching, rather than scientific study; descriptions were informal and targeted at practical usage. In the first half of the 20th century, [linguists](https://en.wikipedia.org/wiki/Linguistics) such as [Leonard Bloomfield](https://en.wikipedia.org/wiki/Leonard_Bloomfield) and [Zellig Harris](https://en.wikipedia.org/wiki/Zellig_Harris) started attempts to formalize the description of language, including phrase structure.
在西方社会，语法长期以来被视为一门教学学科，而不是科学研究；描述是非正式的，并且针对实际使用。20 世纪上半叶，伦纳德·布卢姆菲尔德( Leonard Bloomfield)和泽利格·哈里斯( Zellig Harris)等语言学家开始尝试将语言描述形式化，包括短语结构。

Meanwhile, [string rewriting rules](https://en.wikipedia.org/wiki/Semi-Thue_system) as [formal logical systems](https://en.wikipedia.org/wiki/Formal_logical_systems) were introduced and studied by mathematicians such as [Axel Thue](https://en.wikipedia.org/wiki/Axel_Thue) (in 1914), [Emil Post](https://en.wikipedia.org/wiki/Emil_Post) (1920s–40s) and [Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing) (1936). [Noam Chomsky](https://en.wikipedia.org/wiki/Noam_Chomsky), teaching linguistics to students of [information theory](https://en.wikipedia.org/wiki/Information_theory) at [MIT](https://en.wikipedia.org/wiki/MIT), combined linguistics and mathematics by taking what is essentially Thue's formalism as the basis for the description of the syntax of [natural language](https://en.wikipedia.org/wiki/Natural_language). He also introduced a clear distinction between generative rules (those of [context-free grammars](https://en.wikipedia.org/wiki/Context-free_grammar)) and transformation rules (1956).[[3\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-3)[[4\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-Chomsky1957-4)
同时，作为[形式逻辑系统]的[字符串重写规则]被Axel Thue(1914 年)、Emil Post(1920-40 年代)和Alan Turing(1936 年)等数学家引入和研究。 Noam Chomsky在麻省理工学院为信息论专业的学生教授语言学，他将语言学和数学结合起来，将本质上是 Thue 的形式主义作为描述自然语言句法的基础。他还介绍了生成规则（上下文无关文法的规则）和转换规则（1956）之间的明确区别。[3] [4]

[John Backus](https://en.wikipedia.org/wiki/John_Backus), a programming language designer at [IBM](https://en.wikipedia.org/wiki/IBM), proposed a [metalanguage](https://en.wikipedia.org/wiki/Metalanguage) of "metalinguistic formulas"[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5)[[6\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-Backus.1969-6)[[7\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-7) to describe the syntax of the new programming language IAL, known today as [ALGOL 58](https://en.wikipedia.org/wiki/ALGOL_58) (1959). His notation was first used in the ALGOL 60 report.
约翰·巴科斯/John Backus，一个在IBM的编程语言设计者，提出了元语言“元语言公式”的[5] [6] [7] 来形容新的编程语言IAL，今天被称为语法ALGOL 58（1959）。他的符号首次用于 ALGOL 60 报告。

BNF is a notation for Chomsky's context-free grammars. Backus was familiar with Chomsky's work.[[8\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-8)
BNF 是乔姆斯基的上下文无关文法的符号。巴克斯熟悉乔姆斯基的工作。[8]

As proposed by Backus, the formula defined "classes" whose names are enclosed in angle brackets. For example, `<ab>`. Each of these names denotes a class of basic symbols.[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5)
正如巴科斯提出的那样，该公式定义了名称括在尖括号中的“类”。例如，<ab>。这些名称中的每一个都表示一类基本符号。[5]

Further development of [ALGOL](https://en.wikipedia.org/wiki/ALGOL) led to [ALGOL 60](https://en.wikipedia.org/wiki/ALGOL_60). In the committee's 1963 report, [Peter Naur](https://en.wikipedia.org/wiki/Peter_Naur) called Backus's notation *Backus normal form*. [Donald Knuth](https://en.wikipedia.org/wiki/Donald_Knuth) argued that BNF should rather be read as *Backus–Naur form*, as it is "not a [normal form](https://en.wikipedia.org/wiki/Normal_form_(term_rewriting)) in the conventional sense",[[9\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-9) unlike, for instance, [Chomsky normal form](https://en.wikipedia.org/wiki/Chomsky_normal_form). The name *Pāṇini Backus form* was also once suggested in view of the fact that the expansion *Backus normal form* may not be accurate, and that [Pāṇini](https://en.wikipedia.org/wiki/Pāṇini) had independently developed a similar notation earlier.[[10\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-10)
ALGOL 的进一步发展导致了ALGOL 60。在该委员会的报告1963年，彼得·诺尔称为巴科斯的符号巴科斯范式。Donald Knuth认为 BNF 应该被解读为Backus-Naur 形式，因为它“不是传统意义上的正常形式”，[9] 不同于，例如，乔姆斯基正常形式。Pāṇini Backus形式的名称也曾被提出，因为扩展巴科斯范式可能不准确，而且Pāṇini早些时候已经独立开发了类似的符号。[10]

BNF is described by Peter Naur in the ALGOL 60 report as *metalinguistic formula*:[[11\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-ALGOL60RPT-11)
BNF 在 ALGOL 60 报告中被 Peter Naur 描述为元语言公式：[11]

> Sequences of characters enclosed in the brackets <> represent metalinguistic variables whose values are sequences of symbols. The marks "::=" and "|" (the latter with the meaning of "or") are metalinguistic connectives. Any mark in a formula, which is not a variable or a connective, denotes itself. Juxtaposition of marks or variables in a formula signifies juxtaposition of the sequence denoted.
>
> 括号 <> 中的字符序列表示元语言变量，其值为符号序列。标记“::=”和“|” （后者有“或”的意思）是元语言连接词。公式中的任何标记（不是变量或连接词）都表示它自己。公式中标记或变量的并列表示所表示的序列的并列。

Another example from the ALGOL 60 report illustrates a major difference between the BNF metalanguage and a Chomsky context-free grammar. Metalinguistic variables do not require a rule defining their formation. Their formation may simply be described in natural language within the <> brackets. The following ALGOL 60 report section 2.3 comments specification, exemplifies how this works:
ALGOL 60 报告中的另一个例子说明了 BNF 元语言和乔姆斯基上下文无关语法之间的主要区别。元语言变量不需要定义其形成的规则。它们的形成可以简单地用 <> 括号内的自然语言描述。以下 ALGOL 60 报告第 2.3 节注释规范举例说明了其工作原理：

> For the purpose of including text among the symbols of a program the following "comment" conventions hold:
> 为了在程序的符号中包含文本，遵循以下“注释”约定：
>
> | The sequence of basic symbols: / 基本符号序列：              | is equivalent to / 相当于 |
> | ------------------------------------------------------------ | ------------------------- |
> | **;** **comment** <any sequence not containing ';'>;                  /注释<任何不包含';'的序列> | **;**                     |
> | **begin** **comment** <any sequence not containing ';'>;        /开始 注释<任何不包含';'的序列>; | **begin**                 |
> | **end** <any sequence not containing 'end' or ';' or 'else'>  /结束 <任何不包含'end'或';'的序列 或“其他”> | **end**                   |
>
> Equivalence here means that any of the three structures shown in the left column may be replaced, in any occurrence outside of strings, by the symbol shown in the same line in the right column without any effect on the action of the program.
> 这里的等价意味着左列中显示的三个结构中的任何一个都可以在字符串之外的任何情况下被右列中同一行中显示的符号替换，而不会对程序的操作产生任何影响。

Naur changed two of Backus's symbols to commonly available characters. The `::=` symbol was originally a `:≡`. The `|` symbol was originally the word "or" (with a bar over it).[[6\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-Backus.1969-6):14[*[clarification needed](https://en.wikipedia.org/wiki/Wikipedia:Please_clarify)*] Working for IBM, Backus would have had a non-disclosure agreement and could not have talked about his source if it came from an IBM proprietary project.[*[citation needed](https://en.wikipedia.org/wiki/Wikipedia:Citation_needed)*]
诺尔将巴科斯的两个符号更改为常用字符。该::=符号最初是一个:≡。该|符号最初是单词“or”（上面有一个横杠）。[6] : 14 [需要澄清]为 IBM 工作的 Backus 会签订保密协议，如果消息来自 IBM 专有项目，则无法谈论他的消息来源。[需要引用]

BNF is very similar to [canonical-form](https://en.wikipedia.org/wiki/Canonical_form_(Boolean_algebra)) [boolean algebra](https://en.wikipedia.org/wiki/Boolean_algebra) equations that are, and were at the time, used in logic-circuit design. Backus was a mathematician and the designer of the FORTRAN programming language. Studies of boolean algebra is commonly part of a mathematics. What we do know is that neither Backus nor Naur described the names enclosed in `< >` as non-terminals. Chomsky's terminology was not originally used in describing BNF. Naur later described them as classes in ALGOL course materials.[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5) In the ALGOL 60 report they were called metalinguistic variables. Anything other than the metasymbols `::=`, `|`, and class names enclosed in `< >` are symbols of the language being defined. The metasymbols `::=` is to be interpreted as "is defined as". The `|` is used to separate alternative definitions and is interpreted as "or". The metasymbols `< >` are delimiters enclosing a class name. BNF is described as a [metalanguage](https://en.wikipedia.org/wiki/Metalanguage) for talking about ALGOL by Peter Naur and [Saul Rosen](https://en.wikipedia.org/wiki/Saul_Rosen).[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5)
BNF与当时用于逻辑电路设计的规范形式的 布尔代数方程非常相似。Backus 是一位数学家，也是 FORTRAN 编程语言的设计者。布尔代数的研究通常是数学的一部分。我们所知道的是，巴科斯和诺尔都没有将包含在其中的名称描述< >为非终结符。乔姆斯基的术语最初不是用于描述 BNF。Naur 后来将它们描述为 ALGOL 课程材料中的课程。[5]在 ALGOL 60 报告中，它们被称为元语言变量。除了元符号::=、|和类名之外的任何东西< >都是所定义语言的符号。元符号::=被解释为“被定义为”。的|用于分离的可替换定义和解释为“或”。元符号< >是包含类名的分隔符。BNF 被Peter Naur 和Saul Rosen描述为谈论 ALGOL的元语言。[5]

总结： 
	;    		是注释
	::=		被解释为 "is defined as" 
	|  		被解释为 "or" ，用于 分离/分隔   可选的定义(可以重复任意次数)
	<> 		是包含 class name的分隔符



In 1947 [Saul Rosen](https://en.wikipedia.org/wiki/Saul_Rosen) became involved in the activities of the fledgling [Association for Computing Machinery](https://en.wikipedia.org/wiki/Association_for_Computing_Machinery), first on the languages committee that became the IAL group and eventually led to ALGOL. He was the first managing editor of the Communications of the ACM.[*[clarification needed](https://en.wikipedia.org/wiki/Wikipedia:Please_clarify)*] What we do know is that BNF was first used as a metalanguage to talk about the ALGOL language in the ALGOL 60 report. That is how it is explained in ALGOL programming course material developed by Peter Naur in 1962.[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5) Early ALGOL manuals by IBM, Honeywell, Burroughs and Digital Equipment Corporation followed the ALGOL 60 report using it as a metalanguage. Saul Rosen in his book[[12\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-12) describes BNF as a metalanguage for talking about ALGOL. An example of its use as a metalanguage would be in defining an arithmetic expression:
1947 年，Saul Rosen参与了初出茅庐的计算机协会的活动，首先是语言委员会，后来成为 IAL 小组，最终导致了 ALGOL。他是 ACM 通讯的第一任总编辑。[需要澄清]我们所知道的是，在 ALGOL 60 报告中，BNF 首先被用作元语言来谈论 ALGOL 语言。这就是在 1962 年由 Peter Naur 开发的 ALGOL 编程课程材料中的解释。[5] IBM、霍尼韦尔、Burroughs 和数字设备公司的早期 ALGOL 手册遵循 ALGOL 60 报告，将其用作元语言。索尔·罗森在他的书中[12]将 BNF 描述为讨论 ALGOL 的元语言。它用作元语言的一个例子是定义算术表达式：

```
<expr> ::= <term>|<expr><addop><term>
```

The first symbol of an alternative may be the class being defined, the repetition, as explained by Naur, having the function of specifying that the alternative sequence can recursively begin with a previous alternative and can be repeated any number of times.[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5) For example, above `<expr>` is defined as a `<term>` followed by any number of `<addop> <term>`.
第一个可选的符号可能是将要被定义的类，重复，如 Naur 所解释的，具有指定功能的 可选的序列 可以递归地 从前一个可选的序列开始 可以重复任意次数。例如，<font color=red>上面<expr>定义为 一个<term>后跟任意数量的<addop> <term> </font>。

总结： 
​	BNF首先被用作元语言来讨论ALGOL语言；
​	可选的序列 可以递归的重复任意次数；



In some later metalanguages, such as Schorre's [META II](https://en.wikipedia.org/wiki/META_II), the BNF recursive repeat construct is replaced by a sequence operator and target language symbols defined using quoted strings. The `<` and `>` brackets were removed. Parentheses `(``)` for mathematical grouping were added. The `<expr>` rule would appear in META II as
在一些后来的元语言中，例如 Schorre 的META II，BNF递归重复结构 被 序列运算符 和 使用引号字符串定义的目标语言符号 替换。在 `<` and `>` 支架被拆除。添加了数学分组括号`(``)` 。该<expr>规则将出现在 META II 中

```
EXPR = TERM $('+' TERM .OUT('ADD') | '-' TERM .OUT('SUB'));
```

These changes enabled META II and its derivative programming languages to define and extend their own metalanguage, at the cost of the ability to use a natural language description, metalinguistic variable, language construct description. Many spin-off metalanguages were inspired by BNF.[*[citation needed](https://en.wikipedia.org/wiki/Wikipedia:Citation_needed)*] See [META II](https://en.wikipedia.org/wiki/META_II), [TREE-META](https://en.wikipedia.org/wiki/TREE-META), and [Metacompiler](https://en.wikipedia.org/wiki/Metacompiler).
这些变化使 META II 及其衍生的编程语言能够定义和扩展自己的元语言，代价是能够使用自然语言描述、元语言变量、语言构造描述。许多衍生的元语言都受到 BNF 的启发。[需要引用]参见META II、TREE-META和Metacompiler。

总结: 
​	`<` and `>`支架被拆除；
​	添加了分组括号`( )` ；



A BNF class describes a language construct formation, with formation defined as a pattern or the action of forming the pattern. The class name expr is described in a natural language as a `<term>` followed by a sequence `<addop> <term>`. A class is an abstraction; we can talk about it independent of its formation. We can talk about term, independent of its definition, as being added or subtracted in expr. We can talk about a term being a specific data type and how an expr is to be evaluated having specific combinations of data types. Or even reordering an expression to group data types and evaluation results of mixed types. The natural-language supplement provided specific details of the language class semantics to be used by a compiler implementation and a programmer writing an ALGOL program. Natural-language description further supplemented the syntax as well. The integer rule is a good example of natural and metalanguage used to describe syntax:
BNF 类描述了一种语言结构的形成，其中的形成被定义为一种模式或形成该模式的动作。类名 expr 在自然语言中被描述为 一个<term>后跟一个序列<addop> <term>. 一个类是一个抽象；我们可以独立于它的形成来谈论它。我们可以谈论术语，独立于它的定义，在 expr 中添加或减去。我们可以谈论作为特定数据类型的术语以及如何评估具有特定数据类型组合的 expr。甚至重新排序表达式以对混合类型的数据类型和评估结果进行分组。自然语言补充提供了编译器实现和编写 ALGOL 程序的程序员使用的语言类语义的具体细节。自然语言描述也进一步补充了语法。整数规则是用于描述语法的自然语言和元语言的一个很好的例子：

```
<integer> ::= <digit>|<integer><digit>
```



There are no specifics on white space in the above. As far as the rule states, we could have space between the digits. In the natural language we complement the BNF metalanguage by explaining that the digit sequence can have no white space between the digits. English is only one of the possible natural languages. Translations of the ALGOL reports were available in many natural languages.
上面没有关于空白的细节。就规则规定而言，我们可以在数字之间留有空格。在自然语言中，我们通过解释数字序列在数字之间不能有空格来补充 BNF 元语言。英语只是可能的自然语言之一。ALGOL 报告有多种自然语言的翻译版本。

The origin of BNF is not as important as its impact on programming language development.[*[citation needed](https://en.wikipedia.org/wiki/Wikipedia:Citation_needed)*] During the period immediately following the publication of the ALGOL 60 report BNF was the basis of many [compiler-compiler](https://en.wikipedia.org/wiki/Compiler-compiler) systems.
BNF 的起源并不像它对编程语言发展的影响那么重要。[需要引用]在 ALGOL 60 报告发布后的那个时期，BNF 是许多编译器-编译器系统的基础。

Some, like "A Syntax Directed Compiler for ALGOL 60" developed by [Edgar T. Irons](https://en.wikipedia.org/w/index.php?title=Edgar_T._Irons&action=edit&redlink=1) and "A Compiler Building System" Developed by Brooker and Morris, directly used BNF. Others, like the [Schorre Metacompilers](https://en.wikipedia.org/w/index.php?title=Schorre_Metacompilers&action=edit&redlink=1), made it into a programming language with only a few changes. `<class name>` became symbol identifiers, dropping the enclosing <,> and using quoted strings for symbols of the target language. Arithmetic-like grouping provided a simplification that removed using classes where grouping was its only value. The META II arithmetic expression rule shows grouping use. Output expressions placed in a META II rule are used to output code and labels in an assembly language. Rules in META II are equivalent to a class definitions in BNF. The Unix utility [yacc](https://en.wikipedia.org/wiki/Yacc) is based on BNF with code production similar to META II. yacc is most commonly used as a [parser generator](https://en.wikipedia.org/wiki/Parser_generator), and its roots are obviously BNF.
有些，例如Edgar T. Irons开发的“A Syntax Directed Compiler for ALGOL 60”和 Brooker 和 Morris 开发的“A Compiler Building System”，直接使用了 BNF。其他的，比如Schorre Metacompilers，只做了一些改动就将它变成了一种编程语言。<class name>成为符号标识符，删除封闭的 <,> 并使用带引号的字符串作为目标语言的符号。类算术分组提供了一种简化，删除了使用分组是唯一值的类。META II 算术表达式规则显示了分组使用。放置在 META II 规则中的输出表达式用于以汇编语言输出代码和标签。META II 中的规则等价于 BNF 中的类定义。Unix 实用程序yacc基于 BNF，代码生成类似于 META II。yacc 最常被用作解析器生成器，其根源显然是 BNF。

BNF today is one of the oldest computer-related languages still in use.[*[citation needed](https://en.wikipedia.org/wiki/Wikipedia:Citation_needed)*]
今天的 BNF 是仍在使用的最古老的计算机相关语言之一。[需要引用]



## Introduction(介绍)

A BNF specification is a set of derivation rules, written as
BNF 规范是一组推导规则，写成

```
 <symbol> ::= __expression__
```

where <[symbol](https://en.wikipedia.org/wiki/Symbol)>[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5) is a *[nonterminal](https://en.wikipedia.org/wiki/Nonterminal)*, and the [__expression__](https://en.wikipedia.org/wiki/Expression_(mathematics)) consists of one or more sequences of symbols; more sequences are separated by the [vertical bar](https://en.wikipedia.org/wiki/Vertical_bar) "|", indicating a [choice](https://en.wikipedia.org/wiki/Alternation_(formal_language_theory)), the whole being a possible substitution for the symbol on the left. Symbols that never appear on a left side are *[terminals](https://en.wikipedia.org/wiki/Terminal_symbol)*. On the other hand, symbols that appear on a left side are *[non-terminals](https://en.wikipedia.org/wiki/Nonterminal_symbol)* and are always enclosed between the pair <>.[[5\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-class-5)
其中symbol是一个非终结符，并且__expression__由一个或多个符号序列组成；更多的序列由竖线“|”分隔，表示一个选项，整个是左边符号的可能替代。永远不会出现在左侧的符号是终端。另一方面，出现在左侧的符号是非终结符，并且总是包含在 <> 对之间。[5]

The "::=" means that the symbol on the left must be replaced with the expression on the right.
“::=”表示左边的符号必须替换为右边的表达式。

总结:
​	左侧是 非终止符 ，并且包在<>之间；
​	::= 表示左边的符号 定义为 右边的表达式；
​	右侧是 一个或多个序列，由"|"分隔；



## Example(示例)

As an example, consider this possible BNF for a U.S. [postal address](https://en.wikipedia.org/wiki/Address_(geography)):
例如，考虑 美国邮政地址 这种可能的 BNF ：

```BNF
 <postal-address> ::= <name-part> <street-address> <zip-part>

      <name-part> ::= <personal-part> <last-name> <opt-suffix-part> <EOL> | <personal-part> <name-part>

  <personal-part> ::= <initial> "." | <first-name>

 <street-address> ::= <house-num> <street-name> <opt-apt-num> <EOL>

       <zip-part> ::= <town-name> "," <state-code> <ZIP-code> <EOL>

<opt-suffix-part> ::= "Sr." | "Jr." | <roman-numeral> | ""
    <opt-apt-num> ::= <apt-num> | ""

;-----------------------------------------------------------------------------------------------
 <邮政地址>  ::=  <姓名部分>  <街道地址>  <邮编部分> 
      <姓名部分>  ::=  <个人部分>  <姓氏>  <可选后缀部分>  < EOL > | < personal-part >  < name-part > 
  < personal-part >  ::=  <初始> "." | <名字> 
 <街道地址> ::=  < house-num >  < street-name >  < opt-apt-num >  < EOL > 
       < zip-part >  ::=  < town-name > "," < state-code >  < ZIP-code >  < EOL > 
< opt-suffix-part >  ::= "Sr." | "Jr." | <罗马数字> | ""
     < opt-apt-num >  ::=  < apt-num > | “”
```

This translates into English as:
这翻译成英文如下：

- A postal address consists of a name-part, followed by a [street-address](https://en.wikipedia.org/wiki/Street_name) part, followed by a [zip-code](https://en.wikipedia.org/wiki/ZIP_Code) part.
    - [邮政地址]由 ：[姓名部分]、[街道地址部分]和[邮政编码部分]组成。
- A name-part consists of either: a personal-part followed by a [last name](https://en.wikipedia.org/wiki/Last_name) followed by an optional [suffix](https://en.wikipedia.org/wiki/Suffix_(name)) (Jr., Sr., or dynastic number) and [end-of-line](https://en.wikipedia.org/wiki/End-of-line), or a personal part followed by a name part (this rule illustrates the use of [recursion](https://en.wikipedia.org/wiki/Recursion_(computer_science)) in BNFs, covering the case of people who use multiple first and middle names and initials).
    - [姓名部分]包括：[个人部分]后跟[姓氏]，后跟[可选后缀]（Jr.、Sr. 或王朝编号）和[行尾]，或者 [个人部分] 后跟[姓名部分]
    -  (该规则说明了BNF中递归的使用，涵盖了使用多个名字和中间名以及首字母的人的情况)。
- A personal-part consists of either a [first name](https://en.wikipedia.org/wiki/First_name) or an [initial](https://en.wikipedia.org/wiki/Initial) followed by a dot.
    - [个人部分]由：[名字]或[首字母]后跟一个[点]组成。
- A street address consists of a house number, followed by a street name, followed by an optional [apartment](https://en.wikipedia.org/wiki/Apartment) specifier, followed by an end-of-line.
    - [街道地址]由：[门牌号]、[街道名称]、可选的[公寓]说明符和[行尾]组成。
- A zip-part consists of a [town](https://en.wikipedia.org/wiki/Town)-name, followed by a comma, followed by a [state code](https://en.wikipedia.org/wiki/U.S._postal_abbreviations), followed by a ZIP-code followed by an end-of-line.
    - [邮政编码]部分由：[城镇名称]、[逗号]、[州代码]、[邮政编码]和[行尾]组成。
- An opt-suffix-part consists of a suffix, such as "Sr.", "Jr." or a [roman-numeral](https://en.wikipedia.org/wiki/Roman_numerals), or an empty string (i.e. nothing).
    - [可选后缀]由：后缀组成，例如“Sr.”、“Jr.”。或罗马数字，或空字符串(即什么都没有)。
- An opt-apt-num consists of an apartment number or an empty string (i.e. nothing).
    - [可选公寓号]由：[公寓号]或[空字符串] (即什么都没有) 组成。

Note that many things (such as the format of a first-name, apartment specifier, ZIP-code, and Roman numeral) are left unspecified here. If necessary, they may be described using additional BNF rules.
请注意，此处未指定许多内容（例如名字的格式、公寓说明符、邮政编码和罗马数字）。如有必要，可以使用额外的 BNF 规则来描述它们。



## Further examples(进一步的例子)

BNF's syntax itself may be represented with a BNF like the following:
BNF 的语法本身可以用 BNF 表示，如下所示：

```
 <syntax>         ::= <rule> | <rule> <syntax>
 <rule>           ::= <opt-whitespace> "<" <rule-name> ">" <opt-whitespace> "::=" <opt-whitespace> <expression> <line-end>
 <opt-whitespace> ::= " " <opt-whitespace> | ""
 <expression>     ::= <list> | <list> <opt-whitespace> "|" <opt-whitespace> <expression>
 <line-end>       ::= <opt-whitespace> <EOL> | <line-end> <line-end>
 <list>           ::= <term> | <term> <opt-whitespace> <list>
 <term>           ::= <literal> | "<" <rule-name> ">"
 <literal>        ::= '"' <text1> '"' | "'" <text2> "'"
 <text1>          ::= "" | <character1> <text1>
 <text2>          ::= '' | <character2> <text2>
 <character>      ::= <letter> | <digit> | <symbol>
 <letter>         ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" | "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" | "y" | "z"
 <digit>          ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9"
 <symbol>         ::=  "|" | " " | "!" | "#" | "$" | "%" | "&" | "(" | ")" | "*" | "+" | "," | "-" | "." | "/" | ":" | ";" | ">" | "=" | "<" | "?" | "@" | "[" | "\" | "]" | "^" | "_" | "`" | "{" | "}" | "~"
 <character1>     ::= <character> | "'"
 <character2>     ::= <character> | '"'
 <rule-name>      ::= <letter> | <rule-name> <rule-char>
 <rule-char>      ::= <letter> | <digit> | "-"
 
 -----------------------------------------------------------------------------------------------------
 
 <语法>          ::=  <规则> | < rule >  < syntax > 
 < rule >            ::=  < opt-whitespace > "<" < rule-name > ">" < opt-whitespace > " ::= " < opt-whitespace >  <表达式>  < line-end > 
 <选择空白>  ::= " " < 选择空白> | ""
  <表达式>      ::=  <列表> | <列表>  <选择空白> "|" < opt-whitespace >  < expression > 
 < line-end >        ::=  < opt-whitespace >  < EOL > | <行尾>  <行尾> 
 <列表>            ::=  <术语> | <术语>  < 列表> 
 <术语>            ::=  <文字> | "<" < rule-name > ">"
  < literal >         ::= '"' < text1 > '"' | "'" < text2 > "'"
  < text1 >           ::= "" | < character1 >  <文本1 > 
 <文本2 >           :: = '' | < 
       ::=  <字母> | <数字> | <符号> 
 <字母>          ::= "A" | “乙” | "C" | "D" | "E" | "F" | "G" | "H" | “我” | "J" | "K" | "L" | "M" | "N" | “哦” | "P" | “问” | "R" | "S" | "T" | “你” | "V" | "W" | "X" | “是” | "Z" | "一个" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "我" | "j" | "k" | ”
 | "1" | "2" | "3" | "4" | “5” | "6" | "7" | "8" | "9" <符号> ::= | "1" | "2" | "3" | "4" | “5” | "6" | "7" | "8" | "9" <符号> ::=                     “|” | " " | “！” | "#" | "$" | "%" | "&" | "(" | ")" | "*" | "+" | "," | "-" | “。” | "/" | ":" | “；” | ">" | “=” | "<" | “？” | "@" | "[" | "\" | "]" | "^" | "_" | "`" | "{" | "}" | "~"
  <字符 1 >      ::=  <字符> | "'"
  <字符 2 >      ::=  <字符> | '"'
  < 规则名称>       ::=  <字母> | <规则名称>  <规则字符> 
 <规则字符>       ::=  <字母> | <数字> | “——”

```

Note that "" is the [empty string](https://en.wikipedia.org/wiki/Empty_string).
请注意，[""]是[空字符串]。

The original BNF did not use quotes as shown in `<literal>` rule. This assumes that no [whitespace](https://en.wikipedia.org/wiki/Whitespace_(computer_science)) is necessary for proper interpretation of the rule.
原始 BNF 没有使用`<literal>`规则中所示的引号。这假设正确解释规则不需要[空格]。

`<EOL>` represents the appropriate [line-end](https://en.wikipedia.org/wiki/Newline) specifier (in [ASCII](https://en.wikipedia.org/wiki/ASCII), carriage-return, line-feed or both depending on the [operating system](https://en.wikipedia.org/wiki/Operating_system)). `<rule-name>` and `<text>` are to be substituted with a declared rule's name/label or literal text, respectively.
`<EOL>`表示适当的行尾说明符（在ASCII、回车、换行或两者中，取决于操作系统）。`<rule-name>`和`<text>`分别替换为已声明规则的名称/标签或文字文本。

In the U.S. postal address example above, the entire block-quote is a syntax. Each line or unbroken grouping of lines is a rule; for example one rule begins with `<name-part> ::=`. The other part of that rule (aside from a line-end) is an expression, which consists of two lists separated by a pipe `|`. These two lists consists of some terms (three terms and two terms, respectively). Each term in this particular rule is a rule-name.
在上面的美国邮政地址示例中，整个块引用是一种语法。每条线或不间断的线组是一条规则；例如，一个规则以`<name-part> ::=`开始。该规则的另一部分（除了行尾）是一个表达式，它由两个由管道分隔的列表组成`|`。这两个列表由一些术语（分别为三个术语和两个术语）组成。此特定规则中的每个术语都是一个规则名称。



## Variants(变体)

There are many variants and extensions of BNF, generally either for the sake of simplicity and succinctness, or to adapt it to a specific application. One common feature of many variants is the use of [regular expression](https://en.wikipedia.org/wiki/Regular_expression) repetition operators such as `*` and `+`. The [extended Backus–Naur form](https://en.wikipedia.org/wiki/Extended_Backus–Naur_form) (EBNF) is a common one.
BNF 有许多变体和扩展，通常要么是为了简单和简洁，要么是为了使其适应特定的应用程序。许多变体的一个共同特征是使用[正则表达式]重复运算符，例如*和+。扩展型巴科斯范式（EBNF）是一种常见的一种。

Another common extension is the use of square brackets around optional items. Although not present in the original ALGOL 60 report (instead introduced a few years later in [IBM](https://en.wikipedia.org/wiki/International_Business_Machines)'s [PL/I](https://en.wikipedia.org/wiki/PL/I) definition), the notation is now universally recognised.
另一个常见的扩展是在可选项周围使用方括号。尽管最初的 ALGOL 60 报告中没有出现（而是在几年后在IBM的PL/I定义中引入），但该表示法现在已得到普遍认可。

[Augmented Backus–Naur form](https://en.wikipedia.org/wiki/Augmented_Backus–Naur_form) (ABNF) and Routing Backus–Naur form (RBNF)[[13\]](https://en.wikipedia.org/wiki/Backus–Naur_form#cite_note-13) are extensions commonly used to describe [Internet Engineering Task Force](https://en.wikipedia.org/wiki/Internet_Engineering_Task_Force) (IETF) [protocols](https://en.wikipedia.org/wiki/Protocol_(computing)).
Augmented Backus-Naur form (ABNF) 和 Routing Backus-Naur form (RBNF) [13]是通常用于描述互联网工程任务组(IETF)协议的扩展。

[Parsing expression grammars](https://en.wikipedia.org/wiki/Parsing_expression_grammar) build on the BNF and [regular expression](https://en.wikipedia.org/wiki/Regular_expression) notations to form an alternative class of [formal grammar](https://en.wikipedia.org/wiki/Formal_grammar), which is essentially [analytic](https://en.wikipedia.org/wiki/Analytic_grammar) rather than [generative](https://en.wikipedia.org/wiki/Generative_grammar) in character.
[解析表达式语法]建立在 [BNF] 和[正则表达式]符号的基础上，以形成另一种形式的语法，它本质上是[分析性的]而不是[生成性的]。

Many BNF specifications found online today are intended to be human-readable and are non-formal. These often include many of the following syntax rules and extensions:
今天在网上找到的许多 BNF 规范旨在[使人类可读]并且是[非正式的]。这些通常包括以下许多语法规则和扩展：

- Optional items enclosed in square brackets: `[<item-x>]`.
    - 方括号中的可选项：[<item-x>].
- Items existing 0 or more times are enclosed in curly brackets or suffixed with an asterisk (`*`) such as `<word> ::= <letter> {<letter>}` or `<word> ::= <letter> <letter>*` respectively.
    - 出现 0 次或更多次的项 用大括号括起来 或 分别以星号`*`为后缀，例如`<word> ::= <letter> {<letter>}`或`<word> ::= <letter> <letter>*` 。
- Items existing 1 or more times are suffixed with an addition (plus) symbol, `+`.
    - 出现 1 次或多次的项 以加号为后缀，`+`。
- Terminals may appear in bold rather than italics, and non-terminals in plain text rather than angle brackets.
    - 终端可能以粗体而不是斜体出现，非终端可能以纯文本而不是尖括号出现。
- Where items are grouped, they are enclosed in simple parentheses.
    - 在项分组的地方，它们用简单的括号括起来。  



### Software using BNF(使用 BNF 的软件)

略.



## See also(另见)

略.



## References(参考文献)

略.



## External links(外部链接)

- Garshol, Lars Marius, [*BNF and EBNF: What are they and how do they work?*](http://www.garshol.priv.no/download/text/bnf.html), [NO](https://en.wikipedia.org/wiki/Norway): Priv.
- [RFC](https://en.wikipedia.org/wiki/RFC_(identifier)) [5234](https://datatracker.ietf.org/doc/html/rfc5234) — Augmented BNF for Syntax Specifications: ABNF.
- [RFC](https://en.wikipedia.org/wiki/RFC_(identifier)) [5511](https://datatracker.ietf.org/doc/html/rfc5511) — Routing BNF: A Syntax Used in Various Protocol Specifications.
- ISO/IEC 14977:1996(E) *Information technology – Syntactic metalanguage – Extended BNF*, available from "Publicly available", [*Standards*](http://standards.iso.org/ittf/PubliclyAvailableStandards/), ISO or from Kuhn, Marcus, [*Iso 14977*](http://www.cl.cam.ac.uk/~mgk25/iso-14977.pdf) (PDF), [UK](https://en.wikipedia.org/wiki/United_Kingdom): CAM (the latter is missing the cover page, but is otherwise much cleaner)



### Language grammars(语言语法)

略.
