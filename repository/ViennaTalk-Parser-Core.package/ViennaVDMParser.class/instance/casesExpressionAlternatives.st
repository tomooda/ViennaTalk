parsers-expressions-basics
casesExpressionAlternatives
	^ super casesExpressionAlternatives ==> [ :array | ViennaNode label: 'CaseExpressionAlternatives' withAll: array ]