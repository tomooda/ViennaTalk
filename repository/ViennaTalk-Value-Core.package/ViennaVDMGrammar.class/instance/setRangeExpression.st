parsers-expressions-basics
setRangeExpression
	^ (lbrace , expression , comma , (self operator: '...') , comma , expression , rbrace)
		==> [ :array | 
			{(array second).
			(array sixth)} ]