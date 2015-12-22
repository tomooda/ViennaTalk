formatting-statements
sequenceForLoop: aViennaNode
	| patternBind expression statement |
	patternBind := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	statement := self format: aViennaNode third.
	^ self
		noIndentString:
			(self
				noIndentString: (self indentString: 'for' insertCrIfNeeded: patternBind)
				insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression))
		insertCrIfNeeded: (self indentString: 'do' insertCrIfNeeded: statement)