parsers-expressions-basics
maplet
	^ (expression , mapletArrow , expression)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]