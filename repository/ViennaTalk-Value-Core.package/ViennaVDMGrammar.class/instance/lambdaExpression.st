parsers-expressions-basics
lambdaExpression
	^ ((self reserved: 'lambda') , (typeBind separatedBy: comma) withoutSeparators , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]