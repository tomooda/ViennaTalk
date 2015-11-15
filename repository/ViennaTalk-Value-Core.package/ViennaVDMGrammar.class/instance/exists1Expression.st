parsers-expressions
exists1Expression
	^ ((self reserved: 'exists1') , bind , (self operator: $&) , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]