parsers-statements
indexForLoop
	^ (self for , identifier trim , eq , expression , self to , expression , ((self by , expression) ==> #second) optional
		, self do , statement)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh).
			(array ninth)} ]