formatting-expressions
apply: aViennaNode
	| expression args |
	expression := self format: aViennaNode first.
	args := self format: aViennaNode second.
	^ expression , '('
		,
			((self needsIndent: expression , args)
				ifTrue: [ String cr , indent , (self indentString: args) ]
				ifFalse: [ args ]) , ')'