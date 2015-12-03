parsers-expressions-basics
casesExpressionAlternative
	^ super casesExpressionAlternative ==> [ :array | ViennaNode label: 'CaseExpressionAlternative' withAll: array ]