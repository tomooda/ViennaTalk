parsers-expressions-basics
setComprehension
	^ (lbrace , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]