translating
accept: anObject
	| associations binds |
	anObject isDictionary
		ifFalse: [ ^ nil ].
	associations := anObject associations asArray.
	binds := Dictionary new.
	associations
		do: [ :assoc | 
			((keyMatcher accept: assoc key) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ].
			((valueMatcher accept: assoc value) ifNil: [ ^ nil ])
				keysAndValuesDo: [ :var :val | (binds at: var ifAbsentPut: [ OrderedCollection new ]) add: val ] ].
	^ binds