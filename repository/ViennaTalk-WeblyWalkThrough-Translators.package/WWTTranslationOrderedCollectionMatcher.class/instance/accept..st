translating
accept: anObject
	| binds |
	anObject isSequence
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	anObject
		do: [ :element | 
			((elementMatcher accept: element) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ] ].
	^ binds