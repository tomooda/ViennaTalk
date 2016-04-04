parsers-expressions-basics
elseifExpression
	^ (self elseif , expression , self then , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]