formatting-expressions
forallExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: self forall insertCrIfNeeded: bindList trim , ' ' , self dot)
		insertCrIfNeeded: expression