parsers-expressions-type discriminations
isBasicExpression
	^ ('is_' asParser , self basicTypeName , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]