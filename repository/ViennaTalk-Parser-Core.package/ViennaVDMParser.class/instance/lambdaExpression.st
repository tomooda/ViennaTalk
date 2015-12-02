parsers-expressions-basics
lambdaExpression
	^ super lambdaExpression ==> [ :array | ViennaNode label: 'LambdaExpression' withAll: array ]