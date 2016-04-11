formatting-statements
assignStatement: aViennaNode
	^ self indentString: (self format: aViennaNode first) insertCrIfNeeded: ':= ' , (self format: aViennaNode second)