# Objects for VDM values

ViennaTalk mapps VDM values to Smalltalk objects as well as provides classes for those of particular types.

## Values mapped to Smalltalk objects

 VDM value | Smalltalk objects
 ---|---
 true, false | true, false
 ..., -1,  0, 1, ... | ..., -1, 0, 1, ...
 ..., -0.1, 0.1, ... | ..., -0.1, 0, 1, ...
 nil | nil
{e1, ..., en} | {e1 . ... . en} asSet
[e1, ..., en} | {e1 . ... . en} asOrderedCollection
{k1 \|->v1, ..., kn \|->vn} | {k1 -> v1 . ... . kn -> kn} asOrderedCollection
mk_(e1, ..., en} | {e1 . ... . en}
"string" | 'string'
'c' | $c
lambda x:t & exp | [:x \| exp]
<quote> | #quote
mk_T(v1, ..., vn) | ViennaComposite constructorName: 'T' withAll: {v1 . ... . vn}
mk_token(v) | ViennaToken with: v

# Extensions to Smalltalk standard classes

Class | extended protocol | comment
---|---|---
Object | viennaString | answers a VDM expression that reproduce the receiver
 | isFunction | answers if the receiver is a function value
 | isSequence | answers if the receiver is a sequence
 | isSet | answers if the receiver is a set
 | isViennaComposite | answers if the receiver is a composite value
Collection | onlyOneSatisfy | answers if the reciever has the only one member that satisfies the given block be true
 | power | answers a collection of all possible subcollections
 | powerDo | iterates over all possible subcollections
Array | applyTo: | answers the member with the given index
SequenceableCollection | applyTo: | answers the member with the given index
 | tail | answers the copy of collection without the 1st member.
Dictionary | ** | iteration
  | applyTo | answers the value corresponds to the given key
  | comp | function composition
  | inversed | answers the dictionary with flipped keys and values
BlockClosure | ** | iteration
 | applyTo: | equivalent to valueWithArguments:
 | comp: | function composition

# Classes for particular types

Class | major protocol | comment
---|---|---
ViennaComposite | | The class for composite or record values
 | at: , at:put: | read/write access to the field by given index or field name
 | constructorName | answers the constructor name
 | asArray | answers the array of all fields
ViennaToken | The class for token values
 | value | read the content value of the token

# Auxiliary classes

Class | major protocol | comment
---|---|---
ViennaComposition | | The result of function or map composition
 | value:, value:value:, value:value:value: | Evaluates the receiver by the given argument(s)
 | valueWithArguments: | Evaluates the receiver with the arguments in the given array
 | applyTo: | Equivalent to valueWithArguments (for compatibility with BlockClosure, Dictionary, SequenceableCollection and Array
ViennaIteration | | THe result of function or map iteration
 | ** | further iteration
 | comp: | function composition with the given function or map
 | value:, value:value:, value:value:value: | Evaluates the receiver by the given argument(s)
 | valueWithArguments: | Evaluates the receiver with the arguments in the given array
 | applyTo: | Equivalent to valueWithArguments (for compatibility with BlockClosure, Dictionary, SequenceableCollection and Array
