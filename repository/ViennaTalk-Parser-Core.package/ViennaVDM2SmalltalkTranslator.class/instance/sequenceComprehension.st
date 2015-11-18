parsers-expressions-basics
sequenceComprehension
	^ super sequenceComprehension
		==> [ :triple | 
			| seq |
			seq := '_seq'.
			[ 
			(triple first findString: seq) > 0
				or: [ (triple second second findString: seq) > 0 or: [ triple third notNil and: [ (triple third findString: seq) > 0 ] ] ] ]
				whileTrue: [ seq := seq , '_' ].
			'(Array new: 1024 streamContents: [ :' , seq , ' | ' , triple second second , ' asSortedCollection do: [:'
				, triple second first , '|' , (triple third ifNil: [ '' ] ifNotNil: [ triple third , ' ifTrue: [' ]) , seq
				, ' nextPut: ' , triple first
				, (triple third ifNil: [ ']]) asOrderedCollection' ] ifNotNil: [ ']]]) asOrderedCollection' ]) ]