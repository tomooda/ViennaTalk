formatting-patterns and binds
matchValue: aViennaNode
	| value |
	value := self format: aViennaNode first.
	^ aViennaNode first label = 'SymbolicLiteral'
		ifTrue: [ value ]
		ifFalse: [ '(' , value , ')' ]