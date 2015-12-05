parsers-statements
setForLoop
	^ ((self reserved: 'for') , (self reserved: 'all') , pattern , (self reserved: 'in') , (self reserved: 'set')
		, expression , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array third).
			(array sixth).
			(array eighth)} ]