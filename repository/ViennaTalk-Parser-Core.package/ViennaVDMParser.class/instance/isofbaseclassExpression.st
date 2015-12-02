parsers-expressions-type discriminations
isofbaseclassExpression
	^ super isofbaseclassExpression ==> [ :array | ViennaNode label: 'IsofbaseclassExpression' withAll: array ]