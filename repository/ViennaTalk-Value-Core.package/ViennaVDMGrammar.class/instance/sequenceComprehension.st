parsers-expressions
sequenceComprehension
	^ ((self operator: $[) , expression , (self operator: $|) , setBind
		, (((self operator: $&) , expression) ==> #second) optional , (self operator: $]))
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]