parsers-expressions-type discriminations
isNameExpression
	^ ('is_' asParser , name , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]