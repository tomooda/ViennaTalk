formatting-expressions
lambdaExpression: aViennaNode
	| typeBind expression |
	typeBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: self lambda , ' ' , typeBind , ' ' , self dot insertCrIfNeeded: expression