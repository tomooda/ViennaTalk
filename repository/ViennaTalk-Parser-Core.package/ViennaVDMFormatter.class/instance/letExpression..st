formatting-expressions
letExpression: aViennaNode
	| localDefinitionList expression |
	localDefinitionList := self format: aViennaNode first.
	expression := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'let' insertCrIfNeeded: localDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: expression)