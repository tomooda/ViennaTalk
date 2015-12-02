parsers-expressions-basics
setRangeExpression
	^ super setRangeExpression ==> [ :array | ViennaNode label: 'SetRangeExpression' withAll: array ]