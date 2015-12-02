parsers-expressions-basics
newExpression
	^ super newExpression ==> [ :array | ViennaNode label: 'NewExpression' withAll: array ]