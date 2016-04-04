parsers-expressions-basics
forallExpression
	^ (self forall , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]