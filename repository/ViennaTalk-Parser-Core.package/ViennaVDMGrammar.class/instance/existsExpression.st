parsers-expressions-basics
existsExpression
	^ (self exists , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]