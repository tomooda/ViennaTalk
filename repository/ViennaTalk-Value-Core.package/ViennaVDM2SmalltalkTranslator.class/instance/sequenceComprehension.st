parsers-expressions-basics
sequenceComprehension
	^ super sequenceComprehension
		==> [ :triple | 
			'(Array new: 1024 streamContents: [:seq | ' , triple second second , ' asSortedCollection do: [:' , triple second first
				, '|' , (triple third ifNil: [ '' ] ifNotNil: [ triple third , ' ifTrue: [' ]) , 'seq nextPut: ' , triple first
				, (triple third ifNil: [ ']])' ] ifNotNil: [ ']]])' ]) ]