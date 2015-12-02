parsers-expressions-type discriminations
isBasicExpression
	^ super isBasicExpression ==> [ :array | ViennaNode label: 'IsBasicExpression' withAll: array ]