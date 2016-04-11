formatting-patterns and binds
fieldPatternList: aViennaNode
	| fieldPatterns |
	fieldPatterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: fieldPatterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: fieldPatterns