parsers-expressions-basics
forallExpression
	^ super forallExpression ==> [ :array | ViennaNode label: 'ForallExpression' withAll: array ]