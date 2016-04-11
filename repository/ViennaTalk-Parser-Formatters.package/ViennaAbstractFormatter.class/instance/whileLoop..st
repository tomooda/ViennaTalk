formatting-statements
whileLoop: aViennaNode
	| expression statement |
	expression := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'while' insertCrIfNeeded: expression)
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)