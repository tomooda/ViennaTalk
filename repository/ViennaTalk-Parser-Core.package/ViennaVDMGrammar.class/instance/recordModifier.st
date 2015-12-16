parsers-expressions-basics
recordModifier
	^ ((self reserved: 'mu') , lparen , expression , comma , self mapletList , rparen)
		==> [ :array | 
			{(array third).
			(array fifth)} ]