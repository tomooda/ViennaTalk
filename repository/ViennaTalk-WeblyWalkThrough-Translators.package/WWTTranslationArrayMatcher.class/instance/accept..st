translating
accept: anObject
	| binds |
	anObject isArray
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	1 to: elementMatchers size do: [ :index | 
		(((elementMatchers at: index) accept: (anObject at: index)) ifNil: [ ^ nil ])
			keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds