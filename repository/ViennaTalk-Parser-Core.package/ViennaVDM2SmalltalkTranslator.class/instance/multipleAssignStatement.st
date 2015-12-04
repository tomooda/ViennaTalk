parsers-statements
multipleAssignStatement
	^ super multipleAssignStatement ==> [ :array | '.' join: array ]