parsers-expressions-basics
elseifExpression
	^ super elseifExpression ==> [ :array | ViennaNode label: 'ElseifExpression' withAll: array ]