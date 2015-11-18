parsers-types
inmapType
	^ ((self reserved: 'inmap') , type3 , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]