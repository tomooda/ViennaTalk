parsers-expressions-type discriminations
samebaseclassExpression
	^ ((self reserved: 'samebaseclass') , lparen , expression , comma , expression , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]