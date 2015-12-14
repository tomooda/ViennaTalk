formatting-expressions
expressionList: aViennaNode
	| expressions |
	expressions := self formatAll: aViennaNode.
	^ ','
		,
			((self anyNeedsIndent: expressions)
				ifTrue: [ String cr ]
				ifFalse: [ String space ]) join: expressions