parsers-statements
whileLoop
	^ ((self reserved: 'while') , expression , (self reserved: 'do') , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]