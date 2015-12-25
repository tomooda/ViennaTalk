parsers-types
inmapType
	^ ((self reserved: 'inmap') , type , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]