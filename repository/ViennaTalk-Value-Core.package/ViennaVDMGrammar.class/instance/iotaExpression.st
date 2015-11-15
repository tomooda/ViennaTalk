parsers-expressions
iotaExpression
	^ ((self reserved: 'iota') , bind , (self operator: $&) , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]