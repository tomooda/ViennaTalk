parsers-expressions-basics
setRangeExpression
	^ super setRangeExpression ==> [ :pair | '(' , pair first , ' to: ' , pair second , ') asSet' ]