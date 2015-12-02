parsers-expressions-basics
casesExpression
	^ super casesExpression ==> [ :array | ViennaNode label: 'CasesExpression' withAll: array ]