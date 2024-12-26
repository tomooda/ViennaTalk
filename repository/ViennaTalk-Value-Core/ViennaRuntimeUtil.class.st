Class {
	#name : 'ViennaRuntimeUtil',
	#superclass : 'Object',
	#classInstVars : [
		'random'
	],
	#category : 'ViennaTalk-Value-Core',
	#package : 'ViennaTalk-Value-Core'
}

{ #category : 'private' }
ViennaRuntimeUtil class >> aggregateBinding: aDictionary1 with: aDictionary2 [
	| dict |
	dict := aDictionary1 copy.
	aDictionary2
		keysAndValuesDo: [ :key :value | 
			(dict includesKey: key)
				ifTrue: [ 
					(dict at: key) = value
						ifFalse: [ ^ nil ] ]
				ifFalse: [ dict at: key put: value ] ].
	^ dict
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 conc: aBlock2 [
	^ [ :value | 
	(value isSequence and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					0 to: value size do: [ :index | 
						| seq1 seq2 |
						seq1 := value copyFrom: 1 to: index.
						seq2 := value copyFrom: index + 1 to: value size.
						(aBlock1 value: seq1)
							ifNotEmpty: [ :bindings1 | 
								(aBlock2 value: seq2)
									ifNotEmpty: [ :bindings2 | 
										bindings1
											do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 conc: aBlock2 left: anInteger [
	^ [ :value | 
	(value isSequence and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					| seq1 seq2 |
					seq1 := value copyFrom: 1 to: anInteger.
					seq2 := value copyFrom: anInteger + 1 to: value size.
					(aBlock1 value: seq1)
						ifNotEmpty: [ :bindings1 | 
							(aBlock2 value: seq2)
								ifNotEmpty: [ :bindings2 | 
									bindings1
										do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 conc: aBlock2 left: anInteger1 right: anInteger2 [
	^ [ :value | 
	(value isSequence and: [ value notEmpty and: [ value size = (anInteger1 + anInteger2) ] ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					| seq1 seq2 |
					seq1 := value copyFrom: 1 to: anInteger1.
					seq2 := value copyFrom: anInteger1 + 1 to: value size.
					(aBlock1 value: seq1)
						ifNotEmpty: [ :bindings1 | 
							(aBlock2 value: seq2)
								ifNotEmpty: [ :bindings2 | 
									bindings1
										do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 conc: aBlock2 right: anInteger [
	^ [ :value | 
	(value isSequence and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					| seq1 seq2 |
					seq1 := value copyFrom: 1 to: value size - anInteger.
					seq2 := value copyFrom: value size - anInteger + 1 to: value size.
					(aBlock1 value: seq1)
						ifNotEmpty: [ :bindings1 | 
							(aBlock2 value: seq2)
								ifNotEmpty: [ :bindings2 | 
									bindings1
										do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 munion: aBlock2 [
	^ [ :value | 
	(value isDictionary and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					self
						powersetOf: value keys asArray
						withComplementsDo: [ :keys1 :keys2 | 
							| dict1 dict2 |
							dict1 := Dictionary new: keys1 size.
							keys1 do: [ :key | dict1 at: key put: (value at: key) ].
							dict2 := Dictionary new: keys2 size.
							keys2 do: [ :key | dict2 at: key put: (value at: key) ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 munion: aBlock2 left: anInteger [
	^ [ :dict | 
	(dict isDictionary and: [ dict size >= anInteger ])
		ifTrue: [ 
			| value size generator |
			value := dict keys asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| dict1 dict2 |
							dict1 := Dictionary new: size.
							dict2 := Dictionary new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ dict1 at: (value at: i) put: (dict at: (value at: i)) ]
									ifFalse: [ dict2 at: (value at: i) put: (dict at: (value at: i)) ] ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 munion: aBlock2 left: anInteger1 right: anInteger2 [
	^ [ :dict | 
	(dict isDictionary and: [ dict size = (anInteger1 + anInteger2) ])
		ifTrue: [ 
			| value size generator |
			value := dict keys asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger1 - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| dict1 dict2 |
							dict1 := Dictionary new: size.
							dict2 := Dictionary new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ dict1 at: (value at: i) put: (dict at: (value at: i)) ]
									ifFalse: [ dict2 at: (value at: i) put: (dict at: (value at: i)) ] ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 munion: aBlock2 right: anInteger [
	^ [ :dict | 
	(dict isDictionary and: [ dict size >= anInteger ])
		ifTrue: [ 
			| value size generator |
			value := dict keys asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| dict1 dict2 |
							dict1 := Dictionary new: size.
							dict2 := Dictionary new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ dict2 at: (value at: i) put: (dict at: (value at: i)) ]
									ifFalse: [ dict1 at: (value at: i) put: (dict at: (value at: i)) ] ].
							(aBlock1 value: dict1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: dict2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 union: aBlock2 [
	^ [ :value | 
	(value isSet and: [ value notEmpty ])
		ifTrue: [ 
			Array
				new: 16
				streamContents: [ :stream | 
					self
						powersetOf: value asArray
						withComplementsDo: [ :union1 :union2 | 
							(aBlock1 value: union1 asSet)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: union2 asSet)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 union: aBlock2 left: anInteger [
	^ [ :set | 
	(set isSet and: [ set notEmpty ])
		ifTrue: [ 
			| value size generator |
			value := set asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| set1 set2 |
							set1 := Set new: size.
							set2 := Set new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ set1 add: (value at: i) ]
									ifFalse: [ set2 add: (value at: i) ] ].
							(aBlock1 value: set1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: set2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 union: aBlock2 left: anInteger1 right: anInteger2 [
	^ [ :set | 
	(set isSet and: [ set size = (anInteger1 + anInteger2) ])
		ifTrue: [ 
			| value size generator |
			value := set asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger1 - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| set1 set2 |
							set1 := Set new: size.
							set2 := Set new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ set1 add: (value at: i) ]
									ifFalse: [ set2 add: (value at: i) ] ].
							(aBlock1 value: set1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: set2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> match: aBlock1 union: aBlock2 right: anInteger [
	^ [ :set | 
	(set isSet and: [ set notEmpty ])
		ifTrue: [ 
			| value size generator |
			value := set asArray.
			size := value size.
			generator := [ :block | 1 to: size do: [ :i | block value: (Array with: i) ] ].
			anInteger - 1
				timesRepeat: [ 
					generator := [ :g | [ :block | g value: [ :is | is last + 1 to: size do: [ :i | block value: (is copyWith: i) ] ] ] ]
						value: generator ].
			Array
				new: 16
				streamContents: [ :stream | 
					generator
						value: [ :is | 
							| set1 set2 |
							set1 := Set new: size.
							set2 := Set new: size.
							1 to: size do: [ :i | 
								(is includes: i)
									ifTrue: [ set2 add: (value at: i) ]
									ifFalse: [ set1 add: (value at: i) ] ].
							(aBlock1 value: set1)
								ifNotEmpty: [ :bindings1 | 
									(aBlock2 value: set2)
										ifNotEmpty: [ :bindings2 | 
											bindings1
												do: [ :bind1 | bindings2 do: [ :bind2 | (self aggregateBinding: bind1 with: bind2) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchIdentifier: aStringOrNil [
	^ [ :value | 
	aStringOrNil
		ifNil: [ Array with: Dictionary new ]
		ifNotNil: [ 
			Array
				with:
					(Dictionary new
						at: aStringOrNil put: value;
						yourself) ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchMapEnumeration: anArrayOfPairOfBlock [
	^ [ :value | 
	(value isDictionary and: [ value size = anArrayOfPairOfBlock size ])
		ifTrue: [ 
			value
				ifEmpty: [ Array with: Dictionary new ]
				ifNotEmpty: [ 
					| keys bindingsMatrix sizes |
					keys := value keys asArray.
					bindingsMatrix := anArrayOfPairOfBlock
						collect: [ :pair | 
							| keyBlock valueBlock |
							keyBlock := pair first.
							valueBlock := pair second.
							Array
								new: keys size
								streamContents: [ :stream | 
									1 to: keys size do: [ :memberIndex | 
										(keyBlock value: (keys at: memberIndex))
											ifNotEmpty: [ :keyBinds | 
												(valueBlock value: (value at: (keys at: memberIndex)))
													ifNotEmpty: [ :valueBinds | 
														(Array
															new: 4
															streamContents: [ :stream0 | 
																keyBinds
																	do: [ :keyBind | 
																		valueBinds
																			do: [ :valueBind | (self aggregateBinding: keyBind with: valueBind) ifNotNil: [ :bind | stream0 nextPut: bind ] ] ] ])
															ifNotEmpty: [ :binds | stream nextPut: memberIndex -> binds ] ] ] ] ] ].
					sizes := bindingsMatrix collect: #size.
					(sizes includes: 0)
						ifTrue: [ Array new ]
						ifFalse: [ 
							Array
								new: 16
								streamContents: [ :stream | 
									| decode |
									decode := nil.
									decode := [ :n :blockIndex | 
									| p |
									p := sizes at: blockIndex.
									(blockIndex = sizes size
										ifTrue: [ #() ]
										ifFalse: [ decode value: n // p value: blockIndex + 1 ]) copyWithFirst: n \\ p + 1 ].
									0 to: (sizes inject: 1 into: [ :p :s | p * s ]) - 1 do: [ :n | 
										| indices |
										indices := decode value: n value: 1.
										((1 to: indices size)
											collect: [ :blockIndex | ((bindingsMatrix at: blockIndex) at: (indices at: blockIndex)) key ]) asSet size
											= indices size
											ifTrue: [ 
												stream
													nextPutAll:
														((1 to: indices size)
															inject: (Array with: Dictionary new)
															into: [ :bindings :blockIndex | 
																bindings
																	ifEmpty: [ bindings ]
																	ifNotEmpty: [ 
																		| assoc memberIndex binds nextBindings |
																		assoc := (bindingsMatrix at: blockIndex) at: (indices at: blockIndex).
																		memberIndex := assoc key.
																		binds := assoc value.
																		nextBindings := Array
																			new: bindings size * binds size
																			streamContents: [ :stream0 | 
																				bindings
																					do: [ :binding | binds do: [ :bind | (self aggregateBinding: binding with: bind) ifNotNil: [ :b | stream0 nextPut: b ] ] ] ] ] ]) ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchRecord: aString args: anArrayOfBlock [
	^ [ :value | 
	(value isViennaComposite and: [ value size = anArrayOfBlock size and: [ value constructorName = aString ] ])
		ifTrue: [ 
			(1 to: anArrayOfBlock size)
				inject: (Array with: Dictionary new)
				into: [ :bindings :index | 
					bindings
						ifEmpty: [ bindings ]
						ifNotEmpty: [ 
							((anArrayOfBlock at: index) value: (value at: index))
								ifEmpty: [ Array new ]
								ifNotEmpty: [ :newBinds | 
									| nextBindings |
									nextBindings := Array
										new: bindings size * newBinds size
										streamContents: [ :stream | 
											bindings
												do: [ :binding | newBinds do: [ :newBind | (self aggregateBinding: binding with: newBind) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchSequenceEnumeration: anArrayOfBlock [
	^ [ :value | 
	(value isSequence and: [ value size = anArrayOfBlock size ])
		ifTrue: [ 
			(1 to: anArrayOfBlock size)
				inject: (Array with: Dictionary new)
				into: [ :bindings :index | 
					bindings
						ifEmpty: [ bindings ]
						ifNotEmpty: [ 
							((anArrayOfBlock at: index) value: (value at: index))
								ifEmpty: [ Array new ]
								ifNotEmpty: [ :newBinds | 
									Array
										new: bindings size * newBinds size
										streamContents: [ :stream | 
											bindings
												do: [ :binding | newBinds do: [ :newBind | (self aggregateBinding: binding with: newBind) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchSetEnumeration: anArrayOfBlock [
	^ [ :value | 
	(value isSet and: [ value size = anArrayOfBlock size ])
		ifTrue: [ 
			value
				ifEmpty: [ Array with: Dictionary new ]
				ifNotEmpty: [ 
					| members bindingsMatrix sizes |
					members := value asArray.
					bindingsMatrix := anArrayOfBlock
						collect: [ :block | 
							Array
								new: members size
								streamContents: [ :stream | 1 to: members size do: [ :memberIndex | (block value: (members at: memberIndex)) ifNotEmpty: [ :binds | stream nextPut: memberIndex -> binds ] ] ] ].
					sizes := bindingsMatrix collect: #size.
					(sizes includes: 0)
						ifTrue: [ Array new ]
						ifFalse: [ 
							Array
								new: 16
								streamContents: [ :stream | 
									| decode |
									decode := nil.
									decode := [ :n :blockIndex | 
									| p |
									p := sizes at: blockIndex.
									(blockIndex = sizes size
										ifTrue: [ #() ]
										ifFalse: [ decode value: n // p value: blockIndex + 1 ]) copyWithFirst: n \\ p + 1 ].
									0 to: (sizes inject: 1 into: [ :p :s | p * s ]) - 1 do: [ :n | 
										| indices |
										indices := decode value: n value: 1.
										((1 to: indices size)
											collect: [ :blockIndex | ((bindingsMatrix at: blockIndex) at: (indices at: blockIndex)) key ]) asSet size
											= indices size
											ifTrue: [ 
												stream
													nextPutAll:
														((1 to: indices size)
															inject: (Array with: Dictionary new)
															into: [ :bindings :blockIndex | 
																bindings
																	ifEmpty: [ bindings ]
																	ifNotEmpty: [ 
																		| assoc memberIndex binds nextBindings |
																		assoc := (bindingsMatrix at: blockIndex) at: (indices at: blockIndex).
																		memberIndex := assoc key.
																		binds := assoc value.
																		nextBindings := Array
																			new: bindings size * binds size
																			streamContents: [ :stream0 | 
																				bindings
																					do: [ :binding | binds do: [ :bind | (self aggregateBinding: binding with: bind) ifNotNil: [ :b | stream0 nextPut: b ] ] ] ] ] ]) ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchTuple: anArrayOfBlock [
	^ [ :value | 
	(value isArray and: [ value size = anArrayOfBlock size ])
		ifTrue: [ 
			(1 to: anArrayOfBlock size)
				inject: (Array with: Dictionary new)
				into: [ :bindings :index | 
					bindings
						ifEmpty: [ bindings ]
						ifNotEmpty: [ 
							((anArrayOfBlock at: index) value: (value at: index))
								ifEmpty: [ Array new ]
								ifNotEmpty: [ :newBinds | 
									| nextBindings |
									nextBindings := Array
										new: bindings size * newBinds size
										streamContents: [ :stream | 
											bindings
												do: [ :binding | newBinds do: [ :newBind | (self aggregateBinding: binding with: newBind) ifNotNil: [ :bind | stream nextPut: bind ] ] ] ] ] ] ] ]
		ifFalse: [ Array new ] ]
]

{ #category : 'pattern matching' }
ViennaRuntimeUtil class >> matchValue: anObject [
	^ [ :value | 
	anObject = value
		ifTrue: [ Array with: Dictionary new ]
		ifFalse: [ Array new ] ]
]

{ #category : 'private' }
ViennaRuntimeUtil class >> nonEmptyPowersetOf: anArray withComplementsDo: aBlock [
	1 to: (1 << anArray size) - 2 do: [ :index | 
		| array1 array2 |
		array1 := (Array new: anArray size) writeStream.
		array2 := (Array new: anArray size) writeStream.
		1 to: anArray size do: [ :bit | 
			((index bitAt: bit) = 0
				ifTrue: [ array1 ]
				ifFalse: [ array2 ]) nextPut: (anArray at: bit) ].
		aBlock value: array1 contents value: array2 contents ]
]

{ #category : 'private' }
ViennaRuntimeUtil class >> powersetOf: anArray do: aBlock [
	0 to: (1 << anArray size) - 1 do: [ :index | 
		aBlock
			value:
				(Array
					new: anArray size
					streamContents: [ :stream | 
						1 to: anArray size do: [ :bit | 
							(index bitAt: bit) = 0
								ifTrue: [ stream nextPut: (anArray at: bit) ] ] ]) ]
]

{ #category : 'private' }
ViennaRuntimeUtil class >> powersetOf: anArray withComplementsDo: aBlock [
	0 to: (1 << anArray size) - 1 do: [ :index | 
		| array1 array2 |
		array1 := (Array new: anArray size) writeStream.
		array2 := (Array new: anArray size) writeStream.
		1 to: anArray size do: [ :bit | 
			((index bitAt: bit) = 0
				ifTrue: [ array1 ]
				ifFalse: [ array2 ]) nextPut: (anArray at: bit) ].
		aBlock value: array1 contents value: array2 contents ]
]

{ #category : 'randomization' }
ViennaRuntimeUtil class >> random [
	^ random ifNil: [ random := Random new ]
]

{ #category : 'randomization' }
ViennaRuntimeUtil class >> randomInt: anInteger [

	^ self random nextInteger: anInteger
]

{ #category : 'randomization' }
ViennaRuntimeUtil class >> seed: anInteger [
	self random seed: anInteger
]

{ #category : 'randomization' }
ViennaRuntimeUtil class >> shuffleDo: anArrayOfBlock [
	(anArrayOfBlock collect: [ :block | self random next -> block ]) asSortedCollection do: [ :assoc | assoc value value ]
]
