





Network Working Group                                        K. Zeilenga
Request for Comments: 3672                           OpenLDAP Foundation
Category: Standards Track                                        S. Legg
                                                     Adacel Technologies
                                                           December 2003

# Subentries in the Lightweight Directory Access Protocol (LDAP)

## Status of this Memo

This document specifies an Internet standards track protocol for the Internet community, and requests discussion and suggestions for improvements.  Please refer to the current edition of the "Internet Official Protocol Standards" (STD 1) for the standardization state and status of this protocol. Distribution of this memo is unlimited.

## Copyright Notice

Copyright (C) The Internet Society (2003).  All Rights Reserved.

## Abstract(摘要)

In X.500 directories, subentries are special entries used to hold information associated with a subtree or subtree refinement.  This document adapts X.500 subentries mechanisms for use with the Lightweight Directory Access Protocol (LDAP).
<font color=red>在 X.500 目录中，subentry/子条目  是用于保存  与subtree或subtree-refinement/子树细化的相关信息   的特殊entry。</font>
本文档改编 X.500-subentry机制以与轻量级目录访问协议 (LDAP) 一起使用。

# 1. Overview(概述)

From [X.501]:

A subentry is a special kind of entry immediately subordinate to an administrative point.  It contains attributes that pertain to a subtree (or subtree refinement) associated with its administrative point.  The subentries and their administrative point are part of the same naming context.
<font color=red>subentry  是一种  直接从属于administrative-point的  特殊entry。</font>
<font color=red>它包含  与administrative-point相关联的  subtree或subtree-refinement   相关的  属性。</font>
<font color=red>subentry及其管理点   是同一命名上下文的  一部分。</font>

A single subentry may serve all or several aspects of administrative authority.  Alternatively, a specific aspect of administrative authority may be handled through one or more of its own subentries.
<font color=green>单个subentry   可以服务于   管理权限的所有或几个方面。</font>
<font color=green>或者，管理权限的特定方面  可以通过其自己的一个或多个subentry来处理。</font>

Subentries in the Lightweight Directory Access Protocol (LDAP) [RFC3377] SHALL behave in accordance with X.501 unless noted otherwise in this specification.
<font color=blue>轻量级目录访问协议 (LDAP) [RFC3377] 中的subentry，"应"按照 X.501 运行，除非在本规范中另有说明。</font>

In absence of the subentries control (detailed in Section 3),  subentries SHALL NOT be considered in one-level and subtree scope search operations.  For all other operations, including base scope search operations, subentries SHALL be considered.
<font color=green>如果没有subentry-control（详见第 3 节），在one-level和subtree范围搜索操作中  不应考虑subentry。</font>
<font color=green>对于所有其他操作，包括基本范围搜索操作，应考虑subentry。</font>



## 1.1.  Conventions(约定)

Schema definitions are provided using LDAP description formats [RFC2252].  Definitions provided here are formatted (line wrapped) for readability.
<font color=blue>**schema定义**   是使用 LDAP描述格式 [RFC2252] 提供的。 </font>
此处提供的定义  已格式化（换行）以提高可读性。

Protocol elements are described using ASN.1 [X.680].  The term "BER-encoded" means the element is to be encoded using the Basic Encoding Rules [X.690] under the restrictions detailed in Section 5.1 of [RFC2251].
<font color=green>**Protocol elements**使用 ASN.1 [X.680] 进行描述。 </font>
术语<font color=green>"BER-encoded"</font>意味着element将使用基本编码规则/BER [X.690] 根据 [RFC2251] 的第 5.1 节中详述的限制进行编码。

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in BCP 14 [RFC2119].
本文档中的关键词"MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL"是 按照 BCP 14 [RFC2119] 中的描述进行解释。



# 2. Subentry Schema(subentry的schema定义)

## 2.1.  Subtree Specification Syntax(subtree的语法定义)

The Subtree Specification syntax provides a general purpose mechanism for the specification of a subset of entries in a subtree of the Directory Information Tree (DIT).  A subtree begins at some base entry and includes the subordinates of that entry down to some identified lower boundary, possibly extending to the leaf entries.  A subtree specification is always used within a context or scope which implicitly determines the bounds of the subtree.  For example, the scope of a subtree specification for a subschema administrative area does not include the subtrees of any subordinate administrative point entries for subschema administration.  Where a subtree specification does not identify a contiguous subset of the entries within a single subtree the collection is termed a subtree refinement.
**<font color=red>subtree规范语法  为DIT-subtree中 entry的子集   的规范  提供了通用机制。 </font>**
**<font color=red>subentry从某个base-entry开始，并包括该entry的下级到某个已识别的下边界，可能会扩展到叶条目/leaf-entry。 </font>**
**<font color=red>subtree规范  总是在    隐式确定子树边界   的上下文/context或范围/scope内   使用。</font>** 
<font color=red>**例如，subschema管理区域的  subtree规范的scope     不包括   subschema管理的任何从属管理点entry的subtree。** </font>
<font color=red>**在  subtree规范  未标识  单个subtree内entry的连续子集的情况下，该集合被称为子树细化。**</font>

This syntax corresponds to the SubtreeSpecification ASN.1 type described in [X.501], Section 11.3.  This ASN.1 data type definition is reproduced here for completeness.
此语法对应于 [X.501] 第 11.3 节中描述的 SubtreeSpecification ASN.1 类型。 
为了完整起见，此处复制了此 ASN.1 数据类型定义。

```ASN.1
     SubtreeSpecification ::= SEQUENCE {
         base                [0] LocalName DEFAULT { },
                                 COMPONENTS OF ChopSpecification,
         specificationFilter [4] Refinement OPTIONAL }

     LocalName ::= RDNSequence 	-- RDN序列

     ChopSpecification ::= SEQUENCE {
         specificExclusions  [1] SET OF CHOICE {
                                 chopBefore [0] LocalName,
                                 chopAfter [1] LocalName } OPTIONAL,
         minimum             [2] BaseDistance DEFAULT 0,
         maximum             [3] BaseDistance OPTIONAL }

     BaseDistance ::= INTEGER (0 .. MAX)

     Refinement ::= CHOICE {
         item                [0] OBJECT-CLASS.&id,
         and                 [1] SET OF Refinement,
         or                  [2] SET OF Refinement,
         not                 [3] Refinement }
```

The components of SubtreeSpecification are: base, which identifies the base entry of the subtree or subtree refinement, and specificExclusions, minimum, maximum and specificationFilter, which then reduce the set of subordinate entries of the base entry.  The subtree or subtree refinement contains all the entries within scope that are not excluded by any of the components of the subtree specification.  When all of the components of SubtreeSpecification are absent (i.e., when a value of the Subtree Specification syntax is the empty sequence, {}), the specified subtree implicitly includes all the entries within scope.
SubtreeSpecification 的组件包括：
      base 它标识/指示了：subtree或subtree-refinement的   base-entry，
      specificExclusions、minimum、maximum和specificationFilter：减少base-entry的集合中的entry(这个集合，是 base-entry的从属entry组成的集合)。 
<font color=red>**subtree或subtree-refinement   包含scope内  未被subtree-specification的任何组件排除的所有entry。** </font>
<font color=red>当 SubtreeSpecification 的所有组件都不存在时（即，当 Subtree Specification 语法的值是空序列 {} 时），指定的subtree隐式包含scope内的所有entry。</font>

Any particular use of this mechanism MAY impose limitations or constraints on the components of SubtreeSpecification.
这种机制的任何特定使用  都可能对 SubtreeSpecification 的组件施加限制或约束。

The LDAP syntax specification is:
它的LDAP 语法规范是：

```ABNF
   ( 1.3.6.1.4.1.1466.115.121.1.45 DESC 'SubtreeSpecification' )
```

The LDAP-specific encoding of values of this syntax is defined by the Generic String Encoding Rules [RFC3641].  Appendix A provides an equivalent Augmented Backus-Naur Form (ABNF) [RFC2234] for this syntax.
此语法的   特定于LDAP 的值编码由通用字符串编码规则 [RFC3641] 定义。 
附录 A 为该语法提供了等效的增强型巴科斯-诺尔形式 (ABNF) [RFC2234]。



### 2.1.1.  Base(指定相对于base-entry的RDN)

The base component of SubtreeSpecification nominates the base entry of the subtree or subtree refinement.  The base entry may be an entry which is subordinate to the root entry of the scope in which the subtree specification is used, in which case the base component contains a sequence of Relative Distinguished Names (RDNs) relative to the root entry of the scope, or may be the root entry of the scope itself (the default), in which case the base component is absent or contains an empty sequence of RDNs.
<font color=red>SubtreeSpecification的base组件：为subtree或subtree-refinement指定 base-entry。 </font>
<font color=blue>base-entry是一个entry </font>
      <font color=blue>它可能从属于   使用了subtree-specification的    scope的root-entry ，在这种情况下，base组件包含 相对于   scope的root-entry   的RDN序列， </font>
     <font color=blue> 或者可能是    scope的root-entry自身（默认），在这种情况下，base组件不存在 或 包含一个空的RDN序列。</font>

Entries that are not subordinates of the base entry are excluded from the subtree or subtree refinement.
不是base-entry的下级的entry  被排除在子树或子树细化之外。

<font color=red>**总结：1)  SubtreeSpecification的base组件，用于指定 subtree的base-entry(即该subtree的 父亲是谁)；若该base-entry从属于root-entry那么 base组件的值即为相对于root-entry的RDN；若该base-entry即为root-entry 那么base组件不存在或者值为空。**</font>



### 2.1.2.  Specific Exclusions(指定排除列表)

The specificExclusions component of a ChopSpecification is a list of exclusions that specify entries and their subordinates to be excluded from the subtree or subtree refinement.  The entry is specified by a sequence of RDNs relative to the base entry (i.e., a LocalName). Each exclusion is of either the chopBefore or chopAfter form.  If the chopBefore form is used then the specified entry and its subordinates are excluded from the subtree or subtree refinement.  If the chopAfter form is used then only the subordinates of the specified entry are excluded from the subtree or subtree refinement.
<font color=blue>ChopSpecification 的 specificExclusions组件：是一个排除列表，用于指定要从子树或子树细化中排除的条目及其下级。 </font>
<font color=blue>该条目由  相对于base-entry(即 LocalName)的  一系列RDN指定。</font> 
<font color=red>每个排除项 要么是chopBefore形式 要么是chopAfter形式。 </font>
		<font color=red>如果使用了chopBefore 形式，那么  **指定条目及其下级**  将从子树或子树细化中排除。 </font>
		<font color=red>如果使用了**chopAfter 形式**，则**只有  指定条目的下级**     被排除在子树或子树细化之外。</font>

### 2.1.3.  Minimum and Maximum(根据entry在DIT中的深度  排除entry)

The minimum and maximum components of a ChopSpecification allow the exclusion of entries based on their depth in the DIT.
<font color=green>ChopSpecification的Minimum和Maximum组件：允许  **根据条目在DIT中的深度  排除条目**。</font>

Entries that are less than the minimum number of RDN arcs below the base entry are excluded from the subtree or subtree refinement.  A minimum value of zero (the default) corresponds to the base entry.
小于base-entry下方最小RDN弧数的条目  被排除在子树或子树细化之外。 
minimum值为0（默认值）对应于base-entry。

Entries that are more than the maximum number of RDN arcs below the base entry are excluded from the subtree or subtree refinement.  An absent maximum component indicates that there is no upper limit on the number of RDN arcs below the base entry for entries in the subtree or subtree refinement.
超过base-entry下最大RDN弧数的条目  被排除在子树或子树细化之外。 
缺少maximum组件  表示子树或子树细化中的  条目的base-entry下方的 RDN 弧的数量没有上限。

<font color=red>**总结： 小于minimum的 和 大于maximim的 都被排除在外。**</font>



### 2.1.4.  Specification Filter

The specificationFilter component is a boolean expression of assertions about the values of the objectClass attribute of the base entry and its subordinates.  A Refinement assertion item evaluates to true for an entry if that entry's objectClass attribute contains the OID nominated in the assertion.  Entries for which the overall filter evaluates to false are excluded from the subtree refinement.  If the specificationFilter is absent then no entries are excluded from the subtree or subtree refinement because of their objectClass attribute values.
<font color=blue>SpecificationFilter组件：是关于基本条目及其子条目的   objectClass attribute-value的断言的布尔表达式。 </font>
如果entry的objectClass attribute中包含  断言中指定的OID，则该条目的  Refinement断言项  评估为true。 
整体过滤器 评估为false的entry，被排除在 子树细化/subtree refinement 之外。 
如果没有specificationFilter，则不会因为它们的 objectClass attribute-value而从子树/subtree或子树细化/subtree-refinement中排除任何entry。



## 2.2.  Administrative Role Attribute Type

The Administrative Model defined in [X.501], clause 10 requires that administrative entries contain an administrativeRole attribute to indicate that the associated administrative area is concerned with one or more administrative roles.
<font color=green>[X.501]第10条中定义的  管理模型  要求administrative-entry包含一个 managementRole -attribute，以指示相关的administrative-area与一个或多个administrative-role有关。</font>

The administrativeRole operational attribute is specified as follows:
administrativeRole操作属性，指定如下：

```ABNF
   ( 2.5.18.5 NAME 'administrativeRole'
       EQUALITY objectIdentifierMatch
       USAGE directoryOperation
       SYNTAX 1.3.6.1.4.1.1466.115.121.1.38 )
```

The possible values of this attribute defined in X.501 are:
X.501中定义的   该属性的可能值是：

```ABNF
    OID            NAME
    --------  -------------------------------
   2.5.23.1   autonomousArea
   2.5.23.2   accessControlSpecificArea
   2.5.23.3   accessControlInnerArea
   2.5.23.4   subschemaAdminSpecificArea
   2.5.23.5   collectiveAttributeSpecificArea
   2.5.23.6   collectiveAttributeInnerArea
```

Other values may be defined in other specifications.  Names associated with each administrative role are Object Identifier Descriptors [RFC3383].
其他值可以在其他规范中定义。 
与每个管理角色相关联的name  是OID描述符 [RFC3383]。

The administrativeRole operational attribute is also used to regulate the subentries permitted to be subordinate to an administrative entry.  A subentry not of a class permitted by the administrativeRole attribute cannot be subordinate to the administrative entry.
<font color=green>administrativeRole操作属性，也用于调节  允许从属于administrative-entry的subentry。 </font>
<font color=green>不属于administrativeRole-attribute允许的class的subentry   不能从属于administrative-entry。</font>



## 2.3.  Subtree Specification Attribute Type

The subtreeSpecification operational attribute is defined as follows:
subtreeSpecification 操作属性定义如下：

```ABNF
       ( 2.5.18.6 NAME 'subtreeSpecification'
           SINGLE-VALUE
           USAGE directoryOperation
           SYNTAX 1.3.6.1.4.1.1466.115.121.1.45 )
```

This attribute is present in all subentries.  See [X.501], clause 10. Values of the subtreeSpecification attribute nominate collections of entries within the DIT for one or more aspects of administrative authority.
<font color=blue>此属性存在于所有subentry中。 </font>
见[X.501]，第10 节。
<font color=blue>subtreeSpecification 属性的值指定了DIT 内的条目集合，用于管理权限的一个或多个方面。</font>



## 2.4.  Subentry Object Class

The subentry object class is a structural object class.
subentry object-class是structural-object-class。

```ABNF
   ( 2.5.17.0 NAME 'subentry'
       SUP top STRUCTURAL
       MUST ( cn $ subtreeSpecification ) )
```



# 3. Subentries Control(subentry控件)

The subentries control MAY be sent with a searchRequest to control the visibility of entries and subentries which are within scope. Non-visible entries or subentries are not returned in response to the request.
<font color=green>subentry控件  可以与 searchRequest 一起发送，以控制scope内entry和subentry的可见性。 </font>
不可见的entry或子subentry不会响应请求而返回。

The subentries control is an LDAP Control whose controlType is 1.3.6.1.4.1.4203.1.10.1, criticality is TRUE or FALSE (hence absent), and controlValue contains a BER-encoded BOOLEAN indicating visibility.  A controlValue containing the value TRUE indicates that subentries are visible and normal entries are not.  A controlValue containing the value FALSE indicates that normal entries are visible and subentries are not.
<font color=green>subentry-控件是一个 LDAP-控件，</font>
      <font color=green>其 controlType 为 1.3.6.1.4.1.4203.1.10.1，</font>
     <font color=green> criticality 为 TRUE 或 FALSE（因此不存在），</font>
     <font color=green> 并且 controlValue 包含指示可见性的 BER 编码的 BOOLEAN。 </font>
            <font color=green>包含值 TRUE 的 controlValue 表示子条目可见而正常条目不可见。 </font>
            <font color=green>包含值 FALSE 的 controlValue 表示正常条目可见而子条目不可见。</font>

Note that TRUE visibility has the three octet encoding { 01 01 FF } and FALSE visibility has the three octet encoding { 01 01 00 }.
请注意，<font color=green>TRUE</font> 可见性具有三个八位字节编码<font color=green> { 01 01 FF }</font>，而 <font color=green>FALSE</font> 可见性具有三个八位字节编码<font color=green> { 01 01 00 }</font>。

The controlValue SHALL NOT be absent.
controlValue "不应"不存在。

In absence of this control, subentries are not visible to singleLevel and wholeSubtree scope Search requests but are visible to baseObject scope Search requests.
<font color=green>包含如果没有此控件，子条目对 singleLevel 和 wholeSubtree 范围搜索请求不可见，但对 baseObject 范围搜索请求可见。</font>

There is no corresponding response control.
<font color=green>没有相应的   响应控件/response-control。</font>

This control is not appropriate for non-Search operations.
<font color=green>此控件  不适用于非搜索操作/non-Search operation。</font>



# 4. Security Considerations(安全注意事项)

Subentries often hold administrative information or other sensitive information and should be protected from unauthorized access and disclosure as described in [RFC2829][RFC2830].
subentry通常包含管理信息或其他敏感信息，应按照 [RFC2829][RFC2830] 中的描述防止未经授权的访问和披露。

General LDAP [RFC3377] security considerations also apply.
通用 LDAP [RFC3377] 安全注意事项也适用。



# 5. IANA Considerations

## 5.1.  Descriptors

The IANA has registered the LDAP descriptors detailed in this  technical specification.  The following registration template is suggested:
IANA 已注册此技术规范中详述的 LDAP描述符。建议使用以下注册模板：

```ABNF
   Subject: Request for LDAP Descriptor Registration
   Descriptor (short name): see comment
   Object Identifier: see comment
   Person & email address to contact for further information:
       Kurt Zeilenga <kurt@OpenLDAP.org>
   Usage: see comment
   Specification: RFC3672
   Author/Change Controller: IESG
   Comments:

     NAME                            Type OID
     ------------------------        ---- --------
     accessControlInnerArea          R    2.5.23.3
     accessControlSpecificArea       R    2.5.23.2
     administrativeRole              A    2.5.18.5
     autonomousArea                  R    2.5.23.1
     collectiveAttributeInnerArea    R    2.5.23.6
     collectiveAttributeSpecificArea R    2.5.23.5
     subentry                        O    2.5.17.0
     subschemaAdminSpecificArea      R    2.5.23.4
     subtreeSpecification            A    2.5.18.6

   where Type A is Attribute, Type O is ObjectClass, and Type R is Administrative Role.
   其中 
      Type=A 表明它是一个  Attribute，
      Type=O 表明它是一个  ObjectClass，
      Type=R 表明它是一个  Administrative Role，

```



## 5.2.  Object Identifiers

This document uses the OID 1.3.6.1.4.1.4203.1.10.1 to identify an LDAP protocol element defined herein.  This OID was assigned [ASSIGN] by OpenLDAP Foundation, under its IANA-assigned private enterprise allocation [PRIVATE], for use in this specification.
本文档使用 OID 1.3.6.1.4.1.4203.1.10.1 来标识此处定义的 LDAP protocol element。 
该 OID 由 OpenLDAP 基金会根据其 IANA 分配的私有企业分配 [PRIVATE] 分配 [ASSIGN]，用于本规范。

Other OIDs which appear in this document were either assigned by the ISO/IEC Joint Technical Committee 1 - Subcommittee 6 to identify elements of X.500 schema or assigned in RFC 2252 for the use described here.
本文档中出现的其他 OID 要么由 ISO/IEC 联合技术委员会 1 - 小组委员会 6 指定用于标识 X.500 模式的元素，要么在 RFC 2252 中指定用于此处描述的用途。





## 5.3.  Protocol Mechanisms

```
   The IANA has registered the LDAP protocol mechanisms [RFC3383]
   detailed in this specification.

   Subject: Request for LDAP Protocol Mechanism Registration

   Description: Subentries

   Person & email address to contact for further information:
        Kurt Zeilenga <kurt@openldap.org>

   Usage: Control

   Specification: RFC3672

   Author/Change Controller: IESG

   Comments: none
```
# 6. Acknowledgment

This document is based on engineering done by IETF LDUP and LDAPext Working Groups including "LDAP Subentry Schema" by Ed Reed.  This document also borrows from a number of ITU documents including X.501.



# 7. Intellectual Property Statement(知识产权声明.略)

The IETF takes no position regarding the validity or scope of any intellectual property or other rights that might be claimed to pertain to the implementation or use of the technology described in this document or the extent to which any license under such rights might or might not be available; neither does it represent that it has made any effort to identify any such rights.  Information on the IETF's procedures with respect to rights in standards-track and standards-related documentation can be found in BCP-11.  Copies of claims of rights made available for publication and any assurances of licenses to be made available, or the result of an attempt made to obtain a general license or permission for the use of such proprietary rights by implementors or users of this specification can be obtained from the IETF Secretariat.

The IETF invites any interested party to bring to its attention any copyrights, patents or patent applications, or other proprietary rights which may cover technology that may be required to practice this standard.  Please address the information to the IETF Executive Director.



# A.  Subtree Specification ABNF(使用ABNF描述subtree规范！！！)

This appendix is non-normative.
本附录是非规范性的。

The LDAP-specific string encoding for the Subtree Specification syntax is specified by the Generic String Encoding Rules [RFC3641]. The ABNF [RFC2234] in this appendix for this syntax is provided only as a convenience and is equivalent to the encoding specified by the application of [RFC3641].  Since the SubtreeSpecification ASN.1 type may be extended in future editions of [X.501], the provided ABNF should be regarded as a snapshot in time.  The LDAP-specific encoding for any extension to the SubtreeSpecification ASN.1 type can be determined from [RFC3641].
子树规范语法的  LDAP特定字符串编码  由通用字符串编码规则 [RFC3641] 指定。 
本附录中用于此语法的 ABNF [RFC2234] 仅为方便起见而提供，等效于 [RFC3641] 的应用程序指定的编码。 
由于 SubtreeSpecification ASN.1 类型可能会在 [X.501] 的未来版本中扩展，提供的 ABNF 应该被视为及时的快照。 
SubtreeSpecification ASN.1 类型的任何扩展的 LDAP 特定编码可以从 [RFC3641] 中确定。

In the event that there is a discrepancy between this ABNF and the encoding determined by [RFC3641], [RFC3641] is to be taken as definitive.
如果此 ABNF 与 [RFC3641] 确定的编码之间存在差异，则 [RFC3641] 将被视为确定的。
```
   SubtreeSpecification = "{"    [ sp ss-base ]
                             [ sep sp ss-specificExclusions ]
                             [ sep sp ss-minimum ]
                             [ sep sp ss-maximum ]
                             [ sep sp ss-specificationFilter ]
                                   sp "}"

   ss-base                = id-base                msp LocalName
   ss-specificExclusions  = id-specificExclusions  msp
                               SpecificExclusions
   ss-minimum             = id-minimum             msp BaseDistance
   ss-maximum             = id-maximum             msp BaseDistance
   ss-specificationFilter = id-specificationFilter msp Refinement

   id-base                = %x62.61.73.65 ; "base"
   id-specificExclusions  = %x73.70.65.63.69.66.69.63.45.78.63.6C.75.73
                               %x69.6F.6E.73 ; "specificExclusions"
   id-minimum             = %x6D.69.6E.69.6D.75.6D ; "minimum"
   id-maximum             = %x6D.61.78.69.6D.75.6D ; "maximum"
   id-specificationFilter = %x73.70.65.63.69.66.69.63.61.74.69.6F.6E.46
                               %x69.6C.74.65.72 ; "specificationFilter"

   ;指定 排除列表
   SpecificExclusions = "{" [ sp SpecificExclusion
                           *( "," sp SpecificExclusion ) ] sp "}"
   SpecificExclusion  = chopBefore / chopAfter
   chopBefore         = id-chopBefore ":" LocalName
   chopAfter          = id-chopAfter  ":" LocalName
   id-chopBefore      = %x63.68.6F.70.42.65.66.6F.72.65 ; "chopBefore"
   id-chopAfter       = %x63.68.6F.70.41.66.74.65.72    ; "chopAfter"


   Refinement  = item / and / or / not
   item        = id-item ":" OBJECT-IDENTIFIER
   and         = id-and  ":" Refinements
   or          = id-or   ":" Refinements
   not         = id-not  ":" Refinement
   Refinements = "{" [ sp Refinement
                    *( "," sp Refinement ) ] sp "}"
   id-item     = %x69.74.65.6D ; "item"
   id-and      = %x61.6E.64    ; "and"
   id-or       = %x6F.72       ; "or"
   id-not      = %x6E.6F.74    ; "not"

   BaseDistance = INTEGER-0-MAX

   The <sp>, <msp>, <sep>, <INTEGER>, <INTEGER-0-MAX>, <OBJECT-IDENTIFIER> and <LocalName> rules are defined in [RFC3642].
   
```
# Normative References(略)

   [X.501]     ITU-T, "The Directory -- Models," X.501, 1993.

   [X.680]     ITU-T, "Abstract Syntax Notation One (ASN.1) -
               Specification of Basic Notation", X.680, 1994.

   [X.690]     ITU-T, "Specification of ASN.1 encoding rules:  Basic,
               Canonical, and Distinguished Encoding Rules", X.690,
               1994.

   [RFC2119]   Bradner, S., "Key words for use in RFCs to Indicate
               Requirement Levels", BCP 14, RFC 2119, March 1997.

   [RFC2251]   Wahl, M., Howes, T. and S. Kille, "Lightweight Directory
               Access Protocol (v3)", RFC 2251, December 1997.

   [RFC2252]   Wahl, M., Coulbeck, A., Howes, T. and S. Kille,
               "Lightweight Directory Access Protocol (v3):  Attribute
               Syntax Definitions", RFC 2252, December 1997.

   [RFC2829]   Wahl, M., Alvestrand, H., Hodges, J. and R. Morgan,
               "Authentication Methods for LDAP", RFC 2829, May 2000.

   [RFC2830]   Hodges, J., Morgan, R. and M. Wahl, "Lightweight
               Directory Access Protocol (v3): Extension for Transport
               Layer Security", RFC 2830, May 2000.

   [RFC3377]   Hodges, J. and R. Morgan, "Lightweight Directory Access
               Protocol (v3): Technical Specification", RFC 3377,
               September 2002.



Zeilenga & Legg             Standards Track                    [Page 10]

RFC 3672                   Subentries in LDAP              December 2003


   [RFC3383]   Zeilenga, K., "Internet Assigned Numbers Authority (IANA)
               Considerations for the Lightweight Directory Access
               Protocol (LDAP)", RFC 3383, September 2002.

   [RFC3641]   Legg, S., "Generic String Encoding Rules (GSER) for ASN.1
               Types", RFC 3641, October 2003.

Informative References

   [RFC2234]   Crocker, D. and P. Overell, "Augmented BNF for Syntax
               Specifications: ABNF", RFC 2234, November 1997.

   [RFC3642]   Legg, S., "Common Elements of Generic String Encoding
               Rules (GSER) Encodings", RFC 3642, October 2003.

   [ASSIGN]    OpenLDAP Foundation, "OpenLDAP OID Delegations",
               http://www.openldap.org/foundation/oid-delegate.txt

   [PRIVATE]   IANA, "Private Enterprise Numbers",
               http://www.iana.org/assignments/enterprise-numbers

# Authors' Addresses(略)

   Kurt D. Zeilenga
   OpenLDAP Foundation

   EMail: Kurt@OpenLDAP.org


   Steven Legg
   Adacel Technologies Ltd.
   250 Bay Street
   Brighton, Victoria 3186
   AUSTRALIA

   Phone: +61 3 8530 7710
   Fax:   +61 3 8530 7888
   EMail: steven.legg@adacel.com.au













Zeilenga & Legg             Standards Track                    [Page 11]

RFC 3672                   Subentries in LDAP              December 2003

# Full Copyright Statement(略)

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



















Zeilenga & Legg             Standards Track                    [Page 12]

