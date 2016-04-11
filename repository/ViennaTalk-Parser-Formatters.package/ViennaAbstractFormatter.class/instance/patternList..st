formatting-patterns and binds
patternList: aViennaNode
	| patterns |
	patterns := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: patterns)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: patterns