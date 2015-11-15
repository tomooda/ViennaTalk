parsers-expressions
forallExpression
	^ ((self reserved: 'forall') , bindList , (self operator: $&) , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]