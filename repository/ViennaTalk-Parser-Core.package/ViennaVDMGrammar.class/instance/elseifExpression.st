parsers-expressions-basics
elseifExpression
	^ ((self reserved: 'elseif') , expression , (self reserved: 'then') , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]