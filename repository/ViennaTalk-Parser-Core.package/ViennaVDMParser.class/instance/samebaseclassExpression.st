parsers-expressions-type discriminations
samebaseclassExpression
	^ super samebaseclassExpression ==> [ :array | ViennaNode label: 'SamebaseclassExpression' withAll: array ]