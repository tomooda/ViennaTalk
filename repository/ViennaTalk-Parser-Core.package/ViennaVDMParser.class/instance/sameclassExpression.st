parsers-expressions-type discriminations
sameclassExpression
	^ super sameclassExpression ==> [ :array | ViennaNode label: 'SameclassExpression' withAll: array ]