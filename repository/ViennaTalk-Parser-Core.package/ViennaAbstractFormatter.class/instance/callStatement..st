formatting-statements
callStatement: aViennaNode
	| args |
	args := self format: aViennaNode second.
	^ (self format: aViennaNode first) , '('
		,
			((self needsIndent: args)
				ifTrue: [ self newlineIndentString: args ]
				ifFalse: [ args ]) , ')'