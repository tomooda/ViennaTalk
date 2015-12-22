formatting-expressions
iotaExpression: aViennaNode
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: 'iota ' , bind , ' &' insertCrIfNeeded: expression