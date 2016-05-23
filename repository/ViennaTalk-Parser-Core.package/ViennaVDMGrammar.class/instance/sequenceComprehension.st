parsers-expressions-basics
sequenceComprehension
	^ (lbracket , expression , bar , (setBind / self seqBind) , ((amp , expression) ==> #second) optional , rbracket)
		==> [ :six | 
			{(six second).
			(six fourth).
			(six fifth)} ]