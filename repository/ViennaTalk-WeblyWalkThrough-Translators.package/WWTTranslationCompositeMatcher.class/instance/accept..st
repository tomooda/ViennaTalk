translating
accept: anObject
	| binds |
	(anObject isViennaComposite and: [ anObject constructorName = constructorName ])
		ifFalse: [ ^ nil ].
	binds := Dictionary new.
	1 to: memberMatchers size do: [ :index | 
		(((memberMatchers at: index) accept: (anObject at: index)) ifNil: [ ^ nil ])
			keysAndValuesDo: [ :var :val | binds at: var put: val ] ].
	^ binds