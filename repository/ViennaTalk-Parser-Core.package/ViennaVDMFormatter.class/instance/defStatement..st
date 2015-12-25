formatting-statements
defStatement: aViennaNode
	| equalDefinitionList statement |
	equalDefinitionList := self format: aViennaNode first.
	statement := self format: aViennaNode second.
	^ self
		noIndentString: (self indentString: 'def' insertCrIfNeeded: equalDefinitionList)
		insertCrIfNeeded: (self indentString: 'in' insertCrIfNeeded: statement)