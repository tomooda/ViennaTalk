# VDM types as Smalltalk objects

[![ViennaTalk: Types, Values and Objects](http://img.youtube.com/vi/anZoWeA5vd0/1.jpg)](http://www.youtube.com/watch?v=anZoWeA5vd0)

Although types are not the first class objects in VDM-family, ViennaTalk provides classes to prepresent VDM types.
The following table shows mapping from VDM types to corresponding Smalltalk expressions.

type | Smalltalk expression | class | class of value
---|---|---|---
nat | ViennaType nat | ViennaNatType | Integer
nat1 | ViennaType nat1 | ViennaNat1Type | Integer
int | ViennaType int | ViennaIntType | Integer
real | ViennaType real | ViennaRealType | Float
bool | ViennaType bool | ViennaBoolType | Boolean
<quote> | ViennaType quote: #quote | ViennaQuoteType | Symbol
[*t*] | *t* optional | ViennaOptionType | the class of *t*'s value or UndefinedObject
*t1* * *t2* | *t1* * *t2* | ViennaProductType | Array
*t1* \| *t2* | *t1* \| *t2* | ViennaUnionType | either the class of *t1* or *t2*'s value
set of *t* | *t* set | ViennaSetType | Set
seq of *t* | *t* seq | ViennaSeqType | OrderedCollection
seq1 of *t* | *t* seq1 | ViennaSeq1Type | OrderedCollection
map *t1* to *t2* | *t1* mapTo: *t2* | ViennaMapType | Dictionary
inmap *t1* to *t2* |*t1* inmapTo: *t2* | ViennaInmapType | Dictionary
*t1* -> *t2* | *t1* -> *t2* | ViennaPartialFunctionType | BlockClosure
*t1* +> *t2* | *t1* +> *t2* | ViennaTotalFunctionType | BlockClosure
compose *t* of <br> *f1* : *t1* <br> *f2* : *t2* <br> *t3* end | ViennaType compose: '*t*' of: <br>{{*f1* . false . *t1*}.<br>{*f2* . true . *t2*}.<br>{nil . false . *t3*}}| ViennaCompositeType | ViennaComposite
*t* inv *pattern*==*expr* | *t* inv: [:*v*| *expr*] | ViennaConstrainedType | the class of *t*'s value

## Functionality of VDM types

As the first class objects of Smalltalk, VDM types in ViennaTalk provides protocols shown below.

## Type discrimination

Types responds to the <tt>includes:</tt> message with a value as the argument.

```
ViennaType nat includes: 1
```

will return <tt>true</tt>, and

```
ViennaType nat includes: -1
```

will return <tt>false</tt>.

Type invariants are also taken into account.

```
| t |
t := ViennaType nat inv: [:n | n < 10].
t includes: 100
```

returns <tt>false</tt>.

## Subtyping

You can check subtype relationship by sending <tt><=</tt> message to a type object.

```
ViennaType nat <= ViennaType int
```

returns true as <tt>nat</tt> is a subtype of <tt>int</tt> in VDM.

## Enumerating values

A type is a set of values. A type object can enumerate its value by sending the <tt>do:</tt> message if the type is a finite set.

```
| bools |
bools := OrderedCollection new.
ViennaType bool do: [ :b |  bools add: b].
bools asArray
```

The result is an array of <tt>true</tt> and <tt>false</tt>.
Other <tt>Collection</tt> protocols such as <tt>collect:</tt>, <tt>select:</tt> and <tt>detect:</tt> are also implemented.

You can check if a type is enumerable or not by sending the <tt>isEnumerable</tt> message.

```
| t |
t := ViennaType bool * ViennaType nat.
t isEnumerable
```

returns <tt>false</tt> because <tt>nat</tt> is infinite set.

## Composing a value

A composite type can create a value by sending the <tt>applyTo:</tt> message.

```
| t |
t := ViennaType
	compose: 'T' 
	of: { { 'f' . false . ViennaType nat}. 
		{ nil . false . ViennaType bool optional } }.
t applyTo: { 1 . nil }
```

returns a composite value that represents <tt>mk_T(1, nil)</tt>.
