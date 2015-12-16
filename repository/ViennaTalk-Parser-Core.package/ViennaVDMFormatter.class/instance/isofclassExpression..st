formatting-expressions
isofclassExpression: aViennaNode
	| cls expression |
	cls := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'isofclass(' , cls , ','
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ]) , ')'