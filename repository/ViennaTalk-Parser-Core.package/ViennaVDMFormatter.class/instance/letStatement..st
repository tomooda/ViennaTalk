formatting-statements
letStatement: aViennaNode
	| localDefinitionList statement |
	localDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'let' insertCrIfNeeded: localDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: statement)