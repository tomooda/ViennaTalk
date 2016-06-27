parsers-expressions-basics
sequenceComprehension
	^ (lbracket , expression , bar , self setSeqBind , ((amp , expression) ==> #second) optional , rbracket)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]