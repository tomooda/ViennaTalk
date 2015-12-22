formatting-expressions
existsExpression: aViennaNode
	| bindList expression |
	bindList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: (self indentString: 'exists' insertCrIfNeeded: bindList trim , ' &') insertCrIfNeeded: expression