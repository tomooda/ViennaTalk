parsers-expressions-basics
existsExpression
	^ super existsExpression ==> [ :array | ViennaNode label: 'ExistsExpression' withAll: array ]