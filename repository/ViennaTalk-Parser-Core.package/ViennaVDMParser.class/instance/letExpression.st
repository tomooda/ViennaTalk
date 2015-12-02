parsers-expressions-basics
letExpression
	^ super letExpression ==> [ :array | ViennaNode label: 'LetExpression' withAll: array ]