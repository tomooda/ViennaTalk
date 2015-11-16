parsers-expressions-basics
existsExpression
	^ ((self reserved: 'exists') , bindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]