parsers-expressions-type discriminations
isofclassExpression
	^ super isofclassExpression ==> [ :array | ViennaNode label: 'IsofclassExpression' withAll: array ]