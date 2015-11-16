parsers-expressions-basics
exists1Expression
	^ ((self reserved: 'exists1') , bind , amp , expression)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]