parsers-expressions
existsExpression
	^ ((self reserved: 'exists') , bindList , (self operator: $&) , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]