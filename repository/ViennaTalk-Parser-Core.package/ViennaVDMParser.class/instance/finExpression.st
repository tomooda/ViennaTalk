parsers-expressions-threads
finExpression
	^ super finExpression ==> [ :array | ViennaNode label: 'FinExpression' with: array ]