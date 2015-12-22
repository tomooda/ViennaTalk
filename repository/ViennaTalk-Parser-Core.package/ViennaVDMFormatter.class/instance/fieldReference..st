formatting-statements
fieldReference: aViennaNode
	| stateDesignator field |
	stateDesignator := self format: aViennaNode first.
	field := self format: aViennaNode second.
	^ self indentString: stateDesignator insertCrIfNeeded: '.' , field