parsers-expressions-basics
iotaExpression
	^ ((self reserved: 'iota') , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]