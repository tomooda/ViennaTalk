parsers-expressions-basics
lambdaExpression
	^ (self lambda , self typeBindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]