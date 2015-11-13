parsers-types
mapType
	^ ((self reserved: 'map') , type3 , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]