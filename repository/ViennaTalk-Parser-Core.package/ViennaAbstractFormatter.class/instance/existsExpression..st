formatting-expressions
existsExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: self exists insertCrIfNeeded: bindList trim , ' ' , self dot)
		insertCrIfNeeded: expression