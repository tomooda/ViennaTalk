parsers-expressions-threads
activeExpression
	^ super activeExpression ==> [ :array | ViennaNode label: 'ActiveExpression' with: array ]