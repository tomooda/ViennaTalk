accessing
at: aString ifAbsent: errorBlock
	| index |
	index := candidates indexOf: aString asString.
	index = 0
		ifTrue: [ 
			| base |
			base := 'template' , aString asString capitalized.
			candidates := (self class allSelectors
				select: [ :selector | selector size >= base size and: [ (selector copyFrom: 1 to: base size) = base ] ])
				asSortedCollection asArray collect: [ :selector | self perform: selector ].
			index := candidates size ].
	index = 0
		ifTrue: [ ^ errorBlock value ].
	index := index \\ candidates size + 1.
	^ candidates at: index