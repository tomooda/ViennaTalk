parsers-types
mapType
	^ ((self reserved: 'map') , type , (self reserved: 'to') , type3)
		==> [ :quatro | 
			{(quatro second).
			(quatro fourth)} ]