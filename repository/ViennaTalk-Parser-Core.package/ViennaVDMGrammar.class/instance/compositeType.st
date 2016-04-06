parsers-types
compositeType
	^ ((self reserved: 'compose') , self typeIdentifier trim , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]