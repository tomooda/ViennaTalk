parsers-statements
elseifStatement
	^ ((self reserved: 'elseif') , expression , (self reserved: 'then') , statement)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]