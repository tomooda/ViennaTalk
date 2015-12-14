parsers-expressions-basics
casesExpressionAlternative
	^ super casesExpressionAlternative ==> [ :array | ViennaNode label: 'CasesExpressionAlternative' withAll: array ]