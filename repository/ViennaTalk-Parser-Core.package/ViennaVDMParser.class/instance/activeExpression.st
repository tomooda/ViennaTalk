parsers-expressions-threads
activeExpression
	^ super activeExpression ==> [ :nameNode | ViennaNode label: 'ActiveExpression' with: nameNode ]