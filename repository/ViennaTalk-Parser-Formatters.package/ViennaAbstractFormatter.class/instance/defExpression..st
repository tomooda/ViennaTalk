formatting-expressions
defExpression: aViennaNode
	| defs expression |
	defs := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		indentString: (self indentString: 'def' insertCrIfNeeded: defs)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression)