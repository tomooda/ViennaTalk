formatting-expressions
forallExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: (self indentString: 'forall' insertCrIfNeeded: bindList trim , ' &') insertCrIfNeeded: expression