parsers-expressions
isNameExpression
	^ ('is_' asParser , (self type: name) , lparen , expression , rparen)
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]