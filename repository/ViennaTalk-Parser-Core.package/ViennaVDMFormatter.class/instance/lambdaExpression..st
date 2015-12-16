formatting-expressions
lambdaExpression: aViennaNode
	| typeBind expression |
	typeBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'lambda ' , typeBind , ' &'
		,
			((self needsIndent: expression)
				ifTrue: [ String cr , indent , (self indent: expression) ]
				ifFalse: [ String space , expression ])