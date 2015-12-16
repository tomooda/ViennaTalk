formatting-expressions
iotaExpression: aViennaNode
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ 'iota ' , bind , ' &'
		,
			((self needsIndent: bind , expression)
				ifTrue: [ String cr , indent , (self indentString: expression) ]
				ifFalse: [ String space , expression ])