parsers-expressions-threads
finExpression
	^ super finExpression ==> [ :nameNode | ViennaNode label: 'FinExpression' with: nameNode ]