formatting-expressions
tokenConstructor: aViennaNode
	| expression |
	expression := self format: aViennaNode first.
	^ 'mk_token('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ')'