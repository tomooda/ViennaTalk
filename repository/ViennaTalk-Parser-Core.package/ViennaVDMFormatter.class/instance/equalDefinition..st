formatting-definitions
equalDefinition: aViennaNode
	| patternBind expression |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ patternBind
		,
			((self needsIndent: patternBind , expression)
				ifTrue: [ String cr , indent ]
				ifFalse: [ String space ]) , '= ' , expression