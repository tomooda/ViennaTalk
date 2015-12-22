formatting-expressions
exists1Expression: aViennaNode
	| bind expression |
	bind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self indentString: (self indentString: 'exists1' insertCrIfNeeded: bind , ' &') insertCrIfNeeded: expression