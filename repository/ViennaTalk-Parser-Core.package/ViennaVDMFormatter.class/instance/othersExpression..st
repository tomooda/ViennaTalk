formatting-expressions
othersExpression: aViennaNode
	| expression |
	expression := self format: aViennaNode first.
	^ 'others ->'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , expression