accessing-morphs
morphsNamed: aString ifNotEmpty: aBlock ifEmpty: errorBlock
	| any |
	any := false.
	self
		morphsNamed: aString
		do: [ :submorph | 
			aBlock value: submorph.
			any := any or: [ true ] ].
	any
		ifFalse: [ errorBlock value ]