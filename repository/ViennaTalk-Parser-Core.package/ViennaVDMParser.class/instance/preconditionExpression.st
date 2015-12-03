parsers-expressions-basics
preconditionExpression
	^ super preconditionExpression ==> [ :array | ViennaNode label: 'PreconditionExpression' withAll: array ]