translating
accept: anObject
	| binds |
	anObject isDictionary
		ifFalse: [ ^ nil ].
	(matchers contains: [ :assoc | (anObject includesKey: assoc key) not ])
		ifTrue: [ ^ nil ].
	binds := Dictionary new.
	matchers
		do: [ :assoc | 
			| field matcher |
			field := assoc key.
			matcher := assoc value.
			((matcher accept: (anObject at: field)) ifNil: [ ^ nil ]) keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds