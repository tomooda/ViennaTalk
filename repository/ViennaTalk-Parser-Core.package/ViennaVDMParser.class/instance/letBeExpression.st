parsers-expressions-basics
letBeExpression
	^ super letBeExpression ==> [ :array | ViennaNode label: 'LetBeExpression' withAll: array ]