formatting-expressions
iotaExpression: aViennaNode
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: self iota , ' ' , bind , ' ' , self dot insertCrIfNeeded: expression