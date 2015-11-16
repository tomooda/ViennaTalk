parsers-expressions-basics
narrowExpression
	^ ((self reserved: 'narrow_') , lparen , expression , comma , type , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]