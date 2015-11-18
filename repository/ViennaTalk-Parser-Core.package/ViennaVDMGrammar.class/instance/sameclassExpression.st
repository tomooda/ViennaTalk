parsers-expressions-type discriminations
sameclassExpression
	^ ((self reserved: 'sameclass') , lparen , expression , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]