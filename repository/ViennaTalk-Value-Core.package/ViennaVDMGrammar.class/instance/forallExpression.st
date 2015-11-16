parsers-expressions-basics
forallExpression
	^ ((self reserved: 'forall') , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]