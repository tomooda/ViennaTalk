parsers-statements
whileLoop
	^ (self while , expression , self do , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]