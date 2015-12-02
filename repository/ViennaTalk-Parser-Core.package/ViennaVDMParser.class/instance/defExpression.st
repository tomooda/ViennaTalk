parsers-expressions-basics
defExpression
	^ super defExpression ==> [ :array | ViennaNode label: 'DefExpression' withAll: array ]