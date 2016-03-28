formatting-expressions
typeJudgement: aViennaNode
	| type expression |
	expression := self format: aViennaNode first.
	type := self format: aViennaNode second.
	(self needsIndent: expression , type)
		ifFalse: [ ^ 'is_(' , expression , ', ' , type , ')' ].
	^ 'is_('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ',' , String cr , indent , (self indentString: type) , ')'