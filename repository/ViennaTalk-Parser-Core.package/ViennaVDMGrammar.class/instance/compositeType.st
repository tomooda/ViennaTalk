parsers-types
compositeType
	^ ((self reserved: 'compose' ) , identifier , (self reserved: 'of') , fieldList , (self reserved: 'end'))
		==> [ :quin | 
			{(quin second).
			(quin fourth)} ]