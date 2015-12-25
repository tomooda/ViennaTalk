parsers-expressions-basics
lambdaExpression
	^ ((self reserved: 'lambda') , self typeBindList , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]