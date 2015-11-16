parsers-expressions-basics
sequenceComprehension
	^ (lbracket , expression , bar , setBind , ((amp , expression) ==> #second) optional , rbracket)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]