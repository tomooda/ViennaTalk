parsers-expressions
mapComprehension
	^ ((self operator: ${) , expression , (self operator: '|->') , expression , (self operator: $|) , bindList
		, (((self operator: $&) , expression) ==> #second) optional , (self operator: $}))
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh)} ]