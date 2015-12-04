parsers-expressions-basics
othersExpression
	^ ((self reserved: 'others') , (self operator: '->') , expression) ==> #third