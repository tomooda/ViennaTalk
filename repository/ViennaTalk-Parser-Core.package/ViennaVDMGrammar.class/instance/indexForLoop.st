parsers-statements
indexForLoop
	^ ((self reserved: 'for') , identifier trim , eq , expression , (self reserved: 'to') , expression
		, (((self reserved: 'by') , expression) ==> #second) optional , (self reserved: 'do') , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh).
			(array ninth)} ]