parsers-expressions-type discriminations
isNameExpression
	^ super isNameExpression ==> [ :array | ViennaNode label: 'IsNameExpression' withAll: array ]