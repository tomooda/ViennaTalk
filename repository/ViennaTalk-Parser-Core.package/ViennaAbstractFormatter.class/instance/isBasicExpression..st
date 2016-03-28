formatting-expressions
isBasicExpression: aViennaNode
	| name expression |
	name := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'is_' , name , '('
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ expression ]) , ')'