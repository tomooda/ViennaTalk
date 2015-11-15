parsers-expressions
setComprehension
	^ ((self operator: ${) , expression , (self operator: $|) , bindList
		, (((self operator: $&) , expression) ==> #second) optional , (self operator: $}))
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]