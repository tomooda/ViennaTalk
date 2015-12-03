parsers-patterns
fieldPattern
	^ (identifier , mapletArrow , pattern)
		==> [ :triple | 
			{(triple first).
			(triple third)} ]