formatting-expressions
fieldList: aViennaNode
	| fields |
	fields := self formatAll: aViennaNode.
	^ ((self anyNeedsIndent: fields)
		ifTrue: [ String cr ]
		ifFalse: [ String space ]) join: fields