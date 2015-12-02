parsers-expressions-basics
narrowExpression
	^ super narrowExpression ==> [ :array | ViennaNode label: 'NarrowExpression' withAll: array ]