parsers-expressions-basics
iotaExpression
	^ (self iota , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]