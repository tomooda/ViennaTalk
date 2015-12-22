formatting-types
mapType: aViennaNode
	^ self
		noIndentString: (self indentString: 'map' insertCrIfNeeded: (self format: aViennaNode first))
		insertCrIfNeeded: (self indentString: 'to' insertCrIfNeeded: (self format: aViennaNode second))