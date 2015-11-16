parsers-expressions-basics
mapComprehension
	^ (lbrace , expression , maplet , expression , bar , bindList , ((amp , expression) ==> #second) optional , rbrace)
		==> [ :array | 
			{(array second).
			(array fourth).
			(array sixth).
			(array seventh)} ]